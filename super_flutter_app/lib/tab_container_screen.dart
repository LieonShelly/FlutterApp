import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:routemaster/routemaster.dart';
import 'package:super_flutter_app/l10n/app_localizations.dart';

class TabContainerScreen extends StatelessWidget {
  const TabContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabeState = CupertinoTabPage.of(context);
    final l10n = AppLocalizations.of(context);

    return CupertinoTabScaffold(
      controller: tabeState.controller,
      tabBuilder: tabeState.tabBuilder,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            label: l10n.quotesBottomNavigationBarItemLabel,
            icon: const Icon(Icons.format_quote),
          ),
          BottomNavigationBarItem(
            label: l10n.profileBottomNavigationBarItemLabel,
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
