import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:user_repository/src/mappers/remote_to_domain.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/user_local_storage.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/src/user_secure_storage.dart';

class UserRepository {
  final FavQsApi remoteApi;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  final UserLocalStorage _localStorage;
  final UserSecureStorage _secureStorage;
  final BehaviorSubject<DarkModePreference> _darkkModePreferenceSubject =
      BehaviorSubject();

  UserRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
    @visibleForTesting UserLocalStorage? localStorage,
    @visibleForTesting UserSecureStorage? secureStorage,
  }) : _localStorage =
           localStorage ?? UserLocalStorage(noSqlStorage: noSqlStorage),
       _secureStorage = secureStorage ?? const UserSecureStorage();

  Future<void> signIn(String email, String password) async {
    try {
      final apiUser = await remoteApi.signIn(email, password);
      final domainUser = apiUser.toDomainModel();
      _userSubject.add(domainUser);
    } on InvalidCredentialsFavQsException catch (_) {
      throw InvalidCredentialsException();
    }
  }
}
