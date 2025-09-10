import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/sign_in.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(const WonderWordsApp());
}

class WonderWordsApp extends StatefulWidget {
  const WonderWordsApp({Key? key}) : super(key: key);

  @override
  State<WonderWordsApp> createState() {
    return WonderWordsAppState();
  }
}

class WonderWordsAppState extends State<WonderWordsApp> {
  late final FavQsApi _favQsApi = FavQsApi(
    userTokenSupplier: () async {
      return "";
    },
  );
  late final _userRepository = UserRepository(remoteApi: _favQsApi);
  // late final _quoteRepositry = Quore

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(
        onSignInSuccess: () {},
        onForgotMyPasswordTap: () {},
        userRepository: _userRepository,
      ),
    );
  }
}
