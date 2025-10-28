import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:fav_qs_api/src/models/request/sign_up_request_rm.dart';
import 'package:fav_qs_api/src/url_builder.dart';
import 'package:meta/meta.dart';

typedef UserTokenSupplier = Future<String?> Function();

class FavQsApi {
  static const _errorCodeJsonKey = 'error_code';
  static const _errorMessageJsonKey = 'message';
  final Dio _dio;
  final UrlBuilder _urlBuilder;

  FavQsApi({
    required UserTokenSupplier userTokenSupplier,
    @visibleForTesting Dio? dio,
    @visibleForTesting UrlBuilder? urlBuilder,
  }) : _dio = dio ?? Dio(),
       _urlBuilder = urlBuilder ?? const UrlBuilder() {
    _dio.setUpAuthHeaders(userTokenSupplier);
    _dio.interceptors.add(LogInterceptor(responseBody: false));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.findProxy = (uri) {
            return 'PROXY 127.0.0.1:8888';
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
  }

  Future<UserRM> signIn(String email, String password) async {
    final url = _urlBuilder.buildSignInUrl();
    final requestJsonBody = SignInRequestRM(
      credentials: UserCredentialsRM(email: email, password: password),
    ).toJson();
    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;
    try {
      final user = UserRM.fromJson(jsonObject);
      return user;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 21) {
        throw InvalidCredentialsFavQsException();
      }
      rethrow;
    }
  }

  Future<QuoteListPageRM> getQuoteListPage(
    int page, {
    String? tag,
    String searchTerm = '',
    String? favoritedByUsername,
  }) async {
    final url = _urlBuilder.buildGetQuoteListPageUrl(
      page,
      tag: tag,
      searchTerm: searchTerm,
      favoritedByUsername: favoritedByUsername,
    );
    try {
      final response = await _dio.get(url);
      final jsonObject = response.data;
      final quoteListPage = QuoteListPageRM.fromJson(jsonObject);
      final firstItem = quoteListPage.quoteList.first;
      if (firstItem.id == 0) {
        throw EmptySearchResultFavQsException();
      }
      return quoteListPage;
    } on DioError catch (error) {
      rethrow;
    }
  }

  Future<QuoteRM> getQuote(int id) async {
    final url = _urlBuilder.buildGetQuoteUrl(id);
    final response = await _dio.get(url);
    final jsonObject = response.data;
    final quote = QuoteRM.fromJson(jsonObject);
    return quote;
  }

  Future<QuoteRM> favoriteQuote(int id) async {
    final url = _urlBuilder.buildFavoriteQuoteUrl(id);
    return _updateQuote(url);
  }

  Future<QuoteRM> _updateQuote(String url) async {
    final response = await _dio.put(url);
    final jsonObject = response.data;
    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 20) {
        throw UserAuthRequiredFavQsException();
      }
      rethrow;
    }
  }

  Future<QuoteRM> unfavoriteQuote(int id) async {
    final url = _urlBuilder.buildUnfavoriteQuoteUrl(id);
    return _updateQuote(url);
  }

  Future<QuoteRM> upvoteQuote(int id) async {
    final url = _urlBuilder.buildUpvoteQuoteUrl(id);
    return _updateQuote(url);
  }

  Future<QuoteRM> downvoteQuote(int id) async {
    final url = _urlBuilder.buildDownvoteQuoteUrl(id);
    return _updateQuote(url);
  }

  Future<QuoteRM> unvoteQuote(int id) async {
    final url = _urlBuilder.buildUnvoteQuoteUrl(id);
    return _updateQuote(url);
  }

  Future<String> signUp(String username, String email, String password) async {
    final url = _urlBuilder.buildSignUpUrl();
    final requestJsonBody = SignUpRequestRM(
      user: UserInfoRM(username: username, email: email, password: password),
    ).toJson();

    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;
    try {
      return jsonObject['User-Token'];
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 32) {
        final String errorMessage = jsonObject[_errorMessageJsonKey];
        if (errorMessage.toLowerCase().contains('email')) {
          throw EmailAlreadyRegisteredFavQsException();
        } else {
          throw UsernameAlreadyTakenFavQsException();
        }
      }
      rethrow;
    }
  }

  Future<void> updateProfile(
    String username,
    String email,
    String? password,
  ) async {
    final url = _urlBuilder.buildUpdateProfileUrl(username);
    final requestJsonBody = UpdateUserRequestRM(
      user: UserInfoRM(username: username, email: email, password: password),
    ).toJson();
    final response = await _dio.put(url, data: requestJsonBody);
    final Map<String, dynamic> jsonObject = response.data;
    if (jsonObject.containsKey(_errorCodeJsonKey)) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 32) {
        throw UsernameAlreadyTakenFavQsException();
      }
    }
  }

  Future<void> signOut() async {
    final url = _urlBuilder.buildSignOutUrl();
    await _dio.delete(url);
  }

  Future<void> requestPasswordResetEmail(String email) async {
    final url = _urlBuilder.buildRequestPasswordResetEmailUrl();
    try {
      await _dio.post(
        url,
        data: PasswordResetEmailRequestRM(user: UserEmailRM(email: email)),
      );
    } on DioError catch (error) {
      if (error.response?.statusCode == 404) {
        return;
      }
      rethrow;
    }
  }
}

extension on Dio {
  static const _appTokenEnvironmentVariableKey = 'fav-qs-app-token';

  void setUpAuthHeaders(UserTokenSupplier userTokenSupplier) {
    final appToken = const String.fromEnvironment(
      _appTokenEnvironmentVariableKey,
    );
    options = BaseOptions(headers: {'Authorization': 'Token token=$appToken'});
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? userToken = await userTokenSupplier();
          if (userToken != null) {
            options.headers.addAll({'User-Token': userToken});
          }
          return handler.next(options);
        },
      ),
    );
  }
}
