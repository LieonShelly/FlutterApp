import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';

class QuoteRepository {
  final FavQsApi remoteApi;

  QuoteRepository({required this.remoteApi});

  // Stream<QuoteListPage> getListPage()

  Future<QuoteListPage> _getQuoteListPageFromNetwork(
    int pageNumber, {
    Tag? tag,
    String searchTerm = '',
    String? favoritedByUsername,
  }) async {}
}
