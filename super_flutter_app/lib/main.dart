import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:flutter/material.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:super_flutter_app/l10n/app_localizations.dart';
import 'package:super_flutter_app/routing_table.dart';
import 'package:user_repository/user_repository.dart';
import 'package:routemaster/routemaster.dart';

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
  late final _userRepository = UserRepository(
    remoteApi: _favQsApi,
    noSqlStorage: _keyValueStorage,
  );
  late final _quoteRepositry = QuoteRepository(
    keyValueStorage: _keyValueStorage,
    remoteApi: _favQsApi,
  );
  late final RoutemasterDelegate _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
          quoteRepository: _quoteRepositry,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: const [Locale('en', ''), Locale('pt', 'BR')],
      localizationsDelegates: const [AppLocalizations.delegate],
      routerDelegate: _routerDelegate,
      routeInformationParser: const RoutemasterParser(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openInitialDynamicLinkIfAny();
    });
  }

  Future<void> _openInitialDynamicLinkIfAny() async {}
}
