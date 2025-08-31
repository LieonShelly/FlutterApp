import 'dart:convert';
import 'dart:developer';

import 'package:basic_widgets/models/models.dart';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/network/query_result.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:basic_widgets/network/spoonacular_model.dart';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';

class HttpSpoonacularService implements ServiceInterface {
  static const String apiKey = '';
  static const String apiUrl = 'https://api.spoonacular.com/';

  Future getData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log(response.statusCode.toString());
    }
  }

  @override
  Future<RecipeDetailResponse> queryRecipe(String id) {
    // TODO: implement queryRecipe
    throw UnimplementedError();
  }

  @override
  Future<RecipeResponse> queryRecipes(
    String query,
    int offset,
    int number,
  ) async {
    final recipeData = await getData(
      '${apiUrl}recipes/complexSearch?apiKey=$apiKey&query=$query&offset=$offset&number=$number',
    );
    final spoonacularResults = SpoonacularResults.fromJson(
      jsonDecode(recipeData),
    );
    final recipes = spoonacularResultsToRecipe(spoonacularResults);
    final apiQueryResults = QueryResult(
      offset: spoonacularResults.offset,
      number: spoonacularResults.number,
      totalResults: spoonacularResults.totalResults,
      recipes: recipes,
    );
    // return Success(Response(body, statusCode));
    return Future.value(
      Response(
        http.Response('Dummy', 200, request: null),
        Success<QueryResult>(apiQueryResults),
      ),
    );
  }
}
