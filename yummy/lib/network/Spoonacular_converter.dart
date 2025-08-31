import 'dart:async';
import 'dart:convert';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/network/query_result.dart';
import 'package:basic_widgets/network/spoonacular_model.dart';
import 'package:chopper/chopper.dart';

class SpoonacularConverter extends Converter {
  @override
  FutureOr<Request> convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      final mapData = json.decode(body) as Map<String, dynamic>;
      if (mapData.keys.contains('totalResults')) {
        final spoonacularResults = SpoonacularResults.fromJson(mapData);
        final recipes = spoonacularResultsToRecipe(spoonacularResults);
        final apiQueryResults = QueryResult(
          offset: spoonacularResults.offset,
          number: spoonacularResults.number,
          totalResults: spoonacularResults.totalResults,
          recipes: recipes,
        );
        return response.copyWith<BodyType>(
          body: Success(apiQueryResults) as BodyType,
        );
      } else {
        final spoonacularRecipe = SpoonacularRecipe.fromJson(mapData);
        final recipe = spoonacularRecipeToRecipe(spoonacularRecipe);
        return response.copyWith<BodyType>(body: Success(recipe) as BodyType);
      }
    } catch (e) {
      chopperLogger.warning(e);
      final error = Error<InnerType>(Exception(e.toString()));
      return Response(response.base, null, error: error);
    }
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
