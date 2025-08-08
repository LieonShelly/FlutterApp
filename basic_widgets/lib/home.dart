import 'package:basic_widgets/components/color_button.dart';
import 'package:basic_widgets/components/post_card.dart';
import 'package:basic_widgets/constants.dart';
import 'package:basic_widgets/models/cart_manager.dart';
import 'package:basic_widgets/models/food_category.dart';
import 'package:basic_widgets/models/models.dart';
import 'package:basic_widgets/models/order_manager.dart';
import 'package:basic_widgets/screens/explore_page.dart';
import 'package:flutter/material.dart';
import 'components/category_card.dart';
import 'components/restaurant_landscape_card.dart';
import 'components/theme_button.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.colorSelected,
    required this.changeTheme,
    required this.changeColor,
    required this.appTitle,
    required this.cartManager,
    required this.orderManager,
  });

  final ColorSelection colorSelected;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final String appTitle;
  final CartManager cartManager;
  final OrderManager orderManager;

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int tab = 0;
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: "Category",
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: "Post",
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: "Restaurant",
      selectedIcon: Icon(Icons.credit_card),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      ExplorePage(
        cartManager: widget.cartManager,
        orderManager: widget.orderManager,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PostCard(post: posts[0]),
        ),
      ),
      Center(child: Text("Account Page", style: TextStyle(fontSize: 32))),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        elevation: 4,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: appBarDestinations,
      ),
    );
  }
}
