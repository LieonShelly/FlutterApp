import 'package:basic_widgets/providers.dart';
import 'package:basic_widgets/ui/groceries/groceries.dart';
import 'package:basic_widgets/ui/recipes/recipe_list.dart';
import 'package:basic_widgets/ui/theme/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class RecipeMainScreen extends ConsumerStatefulWidget {
  const RecipeMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RecipeMainScreenState();
  }
}

class _RecipeMainScreenState extends ConsumerState<RecipeMainScreen> {
  List<Widget> pageList = <Widget>[];
  static const String preSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.add(const RecipeList());
    pageList.add(const GroceryList());
    Future.microtask(() async {
      getCurrentIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    return mobileLayout();
  }

  Widget mobileLayout() {
    return Scaffold(
      bottomNavigationBar: createBottomNavigatioBar(),
      body: SafeArea(
        child: IndexedStack(
          index: ref.watch(bottomNavigatioProvider).selectedIndex,
          children: pageList,
        ),
      ),
    );
  }

  void getCurrentIndex() async {
    final prefs = ref.read(sharedPrefProvider);
    if (prefs.containsKey(preSelectedIndexKey)) {
      final index = prefs.getInt(preSelectedIndexKey);
      if (index != null) {
        ref.read(bottomNavigatioProvider.notifier).updateSelectedIndex(index);
      }
    }
  }

  BottomNavigationBar createBottomNavigatioBar() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = isDarkMode ? Colors.white : Colors.black;
    final unSelectedItemColor = isDarkMode ? Colors.white : Colors.grey;
    final backgroundColor = isDarkMode
        ? darkBackgroundColor
        : smallCardBackgroundColor;
    final bottomNavigationIndex = ref
        .watch(bottomNavigatioProvider)
        .selectedIndex;
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      currentIndex: bottomNavigationIndex,
      selectedItemColor: selectedColor,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/images/icon_recipe.svg",
            colorFilter: ColorFilter.mode(
              bottomNavigationIndex == 0 ? selectedColor : unSelectedItemColor,
              BlendMode.srcIn,
            ),
            semanticsLabel: "Recipes",
          ),
          label: "Recipes",
        ),
        BottomNavigationBarItem(
          backgroundColor: bottomNavigationIndex == 1
              ? iconBackgroundColor
              : Colors.black,
          icon: SvgPicture.asset(
            'assets/images/shopping_cart.svg',
            colorFilter: ColorFilter.mode(
              bottomNavigationIndex == 1 ? selectedColor : unSelectedItemColor,
              BlendMode.srcIn,
            ),
            semanticsLabel: "Groceries",
          ),
          label: "Croceries",
        ),
      ],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    ref.read(bottomNavigatioProvider.notifier).updateSelectedIndex(index);
    saveCurrentIndex();
  }

  void saveCurrentIndex() async {
    final prefrs = ref.read(sharedPrefProvider);
    final bottomNavigation = ref.read(bottomNavigatioProvider);
    prefrs.setInt(preSelectedIndexKey, bottomNavigation.selectedIndex);
  }
}
