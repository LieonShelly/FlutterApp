import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/models.dart';
part 'query_result.freezed.dart';
part 'query_result.g.dart';

@freezed
class QueryResult with _$QueryResult {
  const factory QueryResult({
    required int offset,
    required int number,
    required int totalResults,
    required List<Recipe> recipes,
  }) = _QueryResult;

  factory QueryResult.fromJson(Map<String, dynamic> json) =>
      _$QueryResultFromJson(json);
}
