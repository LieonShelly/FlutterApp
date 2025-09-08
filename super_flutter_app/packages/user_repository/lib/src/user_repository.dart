import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:user_repository/src/mappers/remote_to_domain.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  final FavQsApi remoteApi;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  UserRepository({required this.remoteApi});

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
