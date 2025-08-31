import 'Spoonacular_converter.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:chopper/chopper.dart';
import '../models/models.dart';
import 'query_result.dart';
import 'model_reponse.dart';
part 'spoonacular_service.chopper.dart';

const String apiKey = '';
const String apiUrl = 'https://api.spoonacular.com/';

@ChopperApi()
abstract class SpoonacularService extends ChopperService
    implements ServiceInterface {
  @override
  @Get(path: 'recipes/{id}/information?includeNutrition=false')
  Future<RecipeDetailResponse> queryRecipe(@Path('id') String id);

  @override
  @Get(path: 'recipes/complexSearch')
  Future<RecipeResponse> queryRecipes(
    @Query('query') String query,
    @Query('offset') int offset,
    @Query('number') int number,
  );

  static SpoonacularService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: SpoonacularConverter(),
      errorConverter: const JsonConverter(),
      services: [_$SpoonacularService()],
    );
    return _$SpoonacularService(client);
  }
}

Request _addQuery(Request req) {
  final param = Map<String, dynamic>.from(req.parameters);
  param['apiKey'] = apiKey;
  return req.copyWith(parameters: param);
}
