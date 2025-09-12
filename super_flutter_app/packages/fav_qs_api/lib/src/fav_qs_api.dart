import 'package:dio/dio.dart';
import 'package:fav_qs_api/src/models/exceptions.dart';
import 'package:fav_qs_api/src/models/request/sign_in_request_rm.dart';
import 'package:fav_qs_api/src/models/request/user_credentials_rm.dart';
import 'package:fav_qs_api/src/models/response/quote_list_page_rm.dart';
import 'package:fav_qs_api/src/models/response/user_rm.dart';
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
    final response = await _dio.get(url);
    final jsonObject = response.data;
    final quoteListPage = QuoteListPageRM.fromJson(jsonObject);
    final firstItem = quoteListPage.quoteList.first;
    if (firstItem.id == 0) {
      throw EmptySearchResultFavQsException();
    }
    return quoteListPage;
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
