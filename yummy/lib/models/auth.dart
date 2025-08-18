import 'package:basic_widgets/models/app_cache.dart';
import 'package:flutter/material.dart';

class Yummyauth extends ChangeNotifier {
  bool _loggedIn = false;

  final _appCache = AppCache();

  Future<bool> get loggedIn => _appCache.isUserLoggedIn();

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _loggedIn = false;
    await _appCache.invalidate();
    notifyListeners();
  }

  Future<bool> siginIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _loggedIn = true;
    await _appCache.cacheUser();
    notifyListeners();
    return _loggedIn;
  }
}
