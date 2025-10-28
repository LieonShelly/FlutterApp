import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:routemaster/routemaster.dart';

class TabContainerScreen extends StatelessWidget {
  const TabContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabeState = CupertinoTabPage.of(context);

    return CupertinoTabScaffold(
      controller: tabeState.controller,
      tabBuilder: tabeState.tabBuilder,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            label: 'Quotes',
            icon: const Icon(Icons.format_quote),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
