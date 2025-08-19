import 'package:basic_widgets/components/color_button.dart';
import 'package:basic_widgets/components/post_card.dart';
import 'package:basic_widgets/constants.dart';
import 'package:basic_widgets/models/auth.dart';
import 'package:basic_widgets/models/cart_manager.dart';
import 'package:basic_widgets/models/food_category.dart';
import 'package:basic_widgets/models/models.dart';
import 'package:basic_widgets/models/order_manager.dart';
import 'package:basic_widgets/models/user.dart';
import 'package:basic_widgets/screens/account_page.dart';
import 'package:basic_widgets/screens/explore_page.dart';
import 'package:basic_widgets/screens/myoder_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'components/category_card.dart';
import 'components/restaurant_landscape_card.dart';
import 'components/theme_button.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.auth,
    required this.colorSelected,
    required this.changeTheme,
    required this.changeColor,
    required this.cartManager,
    required this.orderManager,
    required this.tab,
  });

  final Yummyauth auth;
  final int tab;
  final ColorSelection colorSelected;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final String appTitle = "Yummy_Lieon";
  final CartManager cartManager;
  final OrderManager orderManager;

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: "Category",
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.list_outlined),
      label: "Order",
      selectedIcon: Icon(Icons.list),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      label: "Account",
      selectedIcon: Icon(Icons.person),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      ExplorePage(
        cartManager: widget.cartManager,
        orderManager: widget.orderManager,
      ),
      MyoderPage(orderManager: widget.orderManager),
      AccountPage(
        user: User(
          firstName: 'Stef',
          lastName: 'P',
          role: 'Flutteristas',
          profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
          points: 100,
          darkMode: true,
        ),
        onLogout: (logout) async {
          widget.auth.signOut().then((value) => context.go('/login'));
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(index: widget.tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.tab,
        onDestinationSelected: (index) {
          context.go('/$index');
        },
        destinations: appBarDestinations,
      ),
    );
  }
}
