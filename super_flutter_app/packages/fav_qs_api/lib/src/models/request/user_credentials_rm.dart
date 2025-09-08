import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserCredentialsRM {
  @JsonKey(name: 'login')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  const UserCredentialsRM({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$UserCredentialsRMToJson(this);
}
