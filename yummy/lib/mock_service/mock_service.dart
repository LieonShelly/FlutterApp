import 'dart:convert';
import 'dart:math';
import 'package:basic_widgets/models/recipe.dart';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/network/query_result.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:basic_widgets/network/spoonacular_model.dart';
import 'package:flutter/services.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

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
    var spoonacularResults = SpoonacularResults.fromJson(
      jsonDecode(josnString),
    );
    var recipes = spoonacularResultsToRecipe(spoonacularResults);
    var apiQueryResults = QueryResult(
      offset: spoonacularResults.offset,
      number: spoonacularResults.number,
      totalResults: spoonacularResults.totalResults,
      recipes: recipes,
    );
    _currentRecipes1 = apiQueryResults;

    josnString = await rootBundle.loadString('assets/recipes2.json');
    spoonacularResults = SpoonacularResults.fromJson(jsonDecode(josnString));
    recipes = spoonacularResultsToRecipe(spoonacularResults);
    apiQueryResults = QueryResult(
      offset: spoonacularResults.offset,
      number: spoonacularResults.number,
      totalResults: spoonacularResults.totalResults,
      recipes: recipes,
    );
    _currentRecipes2 = apiQueryResults;

    josnString = await rootBundle.loadString('assets/recipe_details.json');
    final spoonacularRecipe = SpoonacularRecipe.fromJson(
      jsonDecode(josnString),
    );
    spoonacularRecipe.id = recipes[0].id!;
    recipeDetails = spoonacularRecipeToRecipe(spoonacularRecipe);
  }

  @override
  Future<RecipeResponse> queryRecipes(String query, int offset, int number) {
    switch (nextRecipe.nextInt(2)) {
      case 0:
        return Future.value(
          chopper.Response(
            http.Response('Dummy', 200, request: null),
            Success<QueryResult>(_currentRecipes1),
          ),
        );
      case 1:
        return Future.value(
          chopper.Response(
            http.Response('Dummy', 200, request: null),
            Success<QueryResult>(_currentRecipes2),
          ),
        );
      default:
        return Future.value(
          chopper.Response(
            http.Response('Dummy', 200, request: null),
            Success<QueryResult>(_currentRecipes1),
          ),
        );
    }
  }

  @override
  Future<RecipeDetailResponse> queryRecipe(String id) {
    final result = Success<Recipe>(recipeDetails);
    return Future.value(
      chopper.Response(http.Response('Dummy', 200, request: null), result),
    );
  }
}
