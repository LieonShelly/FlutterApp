import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:flutter/material.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:quote_list/quote_list.dart';
import 'package:quote_repository/quote_repository.dart';
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
  final _keyValueStorage = KeyValueStorage();
  late final _userRepository = UserRepository(remoteApi: _favQsApi);
  late final _quoteRepositry = QuoteRepository(
    keyValueStorage: _keyValueStorage,
    remoteApi: _favQsApi,
  );

  @override
  Widget build(BuildContext context) {
    final listScreen = QuoteListScreen(
      quoteRepository: _quoteRepositry,
      userRepository: _userRepository,
      onAuthenticationError: (context) => {},
    );
    final signInScreen = SignInScreen(
      onSignInSuccess: () {},
      onForgotMyPasswordTap: () {},
      userRepository: _userRepository,
    );
    return MaterialApp(home: Scaffold(body: listScreen));
  }
}
