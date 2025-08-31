import 'package:basic_widgets/models/recipe.dart';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/network/query_result.dart';
import 'package:chopper/chopper.dart';

typedef RecipeResponse = Response<Result<QueryResult>>;
typedef RecipeDetailResponse = Response<Result<Recipe>>;

abstract class ServiceInterface {
  Future<RecipeResponse> queryRecipes(String query, int offset, int number);

  Future<RecipeDetailResponse> queryRecipe(String id);
}
