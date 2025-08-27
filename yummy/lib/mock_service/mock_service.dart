import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:basic_widgets/models/recipe.dart';
import 'package:basic_widgets/network/query_result.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:flutter/services.dart';

class MockService implements ServiceInterface {
  late QueryResult _currentRecipes1;
  late QueryResult _currentRecipes2;
  late Recipe recipeDetails;
  Random nextRecipe = Random();

  static Future<MockService> create() async {
    final mockService = MockService();
    await mockService.loadRecipes();
    return mockService;
  }

  Future loadRecipes() async {
    var josnString = await rootBundle.loadString('assets/recipes1.json');
  }
}
