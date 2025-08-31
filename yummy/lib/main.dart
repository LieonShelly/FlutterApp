import 'package:basic_widgets/constants.dart';
import 'package:basic_widgets/home.dart';
import 'package:basic_widgets/mock_service/mock_service.dart';
import 'package:basic_widgets/models/auth.dart';
import 'package:basic_widgets/models/cart_manager.dart';
import 'package:basic_widgets/models/order_manager.dart';
import 'package:basic_widgets/models/restaurant.dart';
import 'package:basic_widgets/network/http_spoonacular_service.dart';
import 'package:basic_widgets/network/spoonacular_service.dart';
import 'package:basic_widgets/providers.dart';
import 'package:basic_widgets/recipe_app.dart';
import 'package:basic_widgets/screens/login_page.dart';
import 'package:basic_widgets/screens/restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  // final mockService = await MockService.create();
  // final httpService = HttpSpoonacularService();
  final service = SpoonacularService.create();
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefProvider.overrideWithValue(sharedPrefs),
        serviceProvider.overrideWithValue(service),
      ],
      child: const RecipeApp(),
    ),
  );
  // runApp(const Yummy());
}

class Yummy extends StatefulWidget {
  const Yummy({super.key});

  @override
  State<Yummy> createState() {
    return _YummyState();
  }
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;
  final CartManager _cartManager = CartManager();
  final OrderManager _orderManager = OrderManager();
  final Yummyauth _auth = Yummyauth();
  late final _router = GoRouter(
    initialLocation: '/login',
    redirect: _appRedirect,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(
          onLogIn: (Credentials credentials) async {
            _auth
                .siginIn(credentials.username, credentials.password)
                .then((_) => context.go('/${YummyTab.home.value}'));
          },
        ),
      ),
      GoRoute(
        path: '/:tab',
        builder: (context, state) {
          return Home(
            auth: _auth,
            colorSelected: colorSelected,
            changeTheme: changeThemeMode,
            changeColor: changeColor,
            cartManager: _cartManager,
            orderManager: _orderManager,
            tab: int.tryParse(state.pathParameters['tab'] ?? '') ?? 0,
          );
        },
        routes: [
          GoRoute(
            path: 'restaurant/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
              final restaurant = restaurants[id];
              return RestaurantPage(
                restaurant: restaurant,
                cartManager: _cartManager,
                orderManager: _orderManager,
              );
            },
          ),
        ],
      ),
    ],
  );

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = "Yummy";
    return MaterialApp.router(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
    );
  }

  Future<String?> _appRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final loggedIn = await _auth.loggedIn;
    final isOnLoginPage = state.matchedLocation == '/login';
    if (!loggedIn) {
      return '/login';
    } else if (loggedIn && isOnLoginPage) {
      return '/${YummyTab.home.value}';
    }
    return null;
  }
}
