import 'package:component_library/component_library.dart';
import 'package:component_library_storybook/stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StoryApp extends StatelessWidget {
  final _lightTheme = LightWonderThemeData();
  final _darkTheme = DarkWonderThemeData();

  StoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WonderTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: ComponentStorybook(
        lightThemeData: _lightTheme.materialThemeData,
        darkThemeData: _darkTheme.materialThemeData,
      ),
    );
  }
}

class ComponentStorybook extends StatelessWidget {
  final ThemeData lightThemeData, darkThemeData;

  const ComponentStorybook({
    Key? key,
    required this.lightThemeData,
    required this.darkThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = WonderTheme.of(context);
    return Storybook(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      localizationDelegates: const [],
      children: [...getStories(theme)],
      initialRoute: 'rounded-choice-chip',
    );
  }
}
