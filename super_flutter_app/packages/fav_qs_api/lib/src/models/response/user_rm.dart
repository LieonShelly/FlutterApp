import 'package:json_annotation/json_annotation.dart';
part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  @JsonKey(name: 'User-Token')
  final String token;

  @JsonKey(name: 'login')
  final String username;

  @JsonKey(name: 'email')
  final String email;

  const UserRM({
    required this.token,
    required this.username,
    required this.email,
  });

  static const fromJson = _$UserRMFromJson;
}
