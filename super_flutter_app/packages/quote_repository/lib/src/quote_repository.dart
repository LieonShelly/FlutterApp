import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:quote_repository/src/mappers/mappers.dart';

class QuoteRepository {
  final FavQsApi remoteApi;

  QuoteRepository({required this.remoteApi});

  // Stream<QuoteListPage> getListPage()

  Future<QuoteListPage> _getQuoteListPageFromNetwork(
    int pageNumber, {
    Tag? tag,
    String searchTerm = '',
    String? favoritedByUsername,
  }) async {
    try {
      final apiPage = await remoteApi.getQuoteListPage(
        pageNumber,
        tag: tag?.toRemoteModel(),
        searchTerm: searchTerm,
        favoritedByUsername: favoritedByUsername,
      );

      final isFiltering = tag != null || searchTerm.isNotEmpty;
      final favoritesOnly = favoritedByUsername != null;

      final shouldStoreOnCache = !isFiltering;
      if (shouldStoreOnCache) {
        //...
      }
      final domainPage = apiPage.toDomainModel();
      return domainPage;
    } on EmptySearchResultFavQsException catch (_) {
      throw EmptySearchResultException();
    }
  }
}
