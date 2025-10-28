import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:quote_list/quote_list.dart';
import 'package:sign_in/sign_in.dart';
import 'package:super_flutter_app/tab_container_screen.dart';
import 'package:user_repository/user_repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:quote_repository/quote_repository.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required QuoteRepository quoteRepository,
}) {
  return {
    _PathConstants.tabContainerPath: (_) => CupertinoTabPage(
      child: const TabContainerScreen(),
      paths: [_PathConstants.quoteListPath, _PathConstants.profileMenuPath],
    ),

    _PathConstants.quoteListPath: (route) {
      return MaterialPage(
        name: 'quote-list',
        child: Scaffold(
          body: QuoteListScreen(
            quoteRepository: quoteRepository,
            userRepository: userRepository,
            onAuthenticationError: (context) {
              routerDelegate.push(_PathConstants.signInPath);
            },
            onQuoteSelected: (id) {
              final navigation = routerDelegate.push<Quote?>(
                _PathConstants.quoteDetailsPush(quoteId: id),
              );
              return navigation.result;
            },
          ),
        ),
      );
    },
    _PathConstants.signInPath: (_) => MaterialPage(
      name: 'sign-in',
      fullscreenDialog: true,
      child: SafeArea(
        child: Builder(
          builder: (context) {
            return SignInScreen(
              userRepository: userRepository,
              onSignInSuccess: () {
                routerDelegate.pop();
              },
            );
          },
        ),
      ),
    ),
  };
}

class _PathConstants {
  const _PathConstants();

  static String get tabContainerPath => '/';

  static String get quoteListPath => '${tabContainerPath}quotes';

  static String get profileMenuPath => '${tabContainerPath}user';

  static String get updateProfilePath => '$profileMenuPath/update-profile';

  static String get signInPath => '${tabContainerPath}sign-in';

  static String get signUpPath => '${tabContainerPath}sign-up';

  static String get idPathParameter => 'id';

  static String quoteDetailsPush({int? quoteId}) =>
      '$quoteListPath/${quoteId ?? ':$idPathParameter'}';
}
