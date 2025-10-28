import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_menu/src/profile_menu_bloc.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';

class ProfileMenuScreen extends StatelessWidget {
  final VoidCallbackAction? onSignInTap;
  final VoidCallbackAction? onUpdateProfileTap;
  final VoidCallbackAction? onSignUpTap;
  final UserRepository userRepository;
  final QuoteRepository quoteRepository;

  const ProfileMenuScreen({
    required this.userRepository,
    required this.quoteRepository,
    this.onSignInTap,
    this.onSignUpTap,
    this.onUpdateProfileTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileMenuBloc>(create: (_) => ());
  }
}

class ProfileMenuView extends StatelessWidget {
  final VoidCallbackAction? onSignInTap;
  final VoidCallbackAction? onUpdateProfileTap;
  final VoidCallbackAction? onSignUpTap;

  const ProfileMenuView({
    this.onSignInTap,
    this.onSignUpTap,
    this.onUpdateProfileTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledStatusBar.dark(
      child: Scaffold(
        body: SafeArea(child: BlocBuilder(builder: (context, state) {})),
      ),
    );
  }
}
