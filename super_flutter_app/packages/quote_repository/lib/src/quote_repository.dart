import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:flutter/foundation.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:quote_repository/src/mappers/mappers.dart';
import 'package:quote_repository/src/quote_local_storage.dart';

class QuoteRepository {
  final FavQsApi remoteApi;
  final QuoteLocalStorage _localStorage;

  QuoteRepository({
    required KeyValueStorage keyValueStorage,
    required this.remoteApi,
    @visibleForTesting QuoteLocalStorage? localStorage,
  }) : _localStorage =
           localStorage ?? QuoteLocalStorage(keyValueStorage: keyValueStorage);

  Stream<QuoteListPage> getQuoteListPage(
    int pageNumber, {
    Tag? tag,
    String searchTerm = '',
    String? favoriteByUsername,
    required QuoteListPageFetchPolicy fetchPolicy,
  }) async* {
    final isFilteringByTag = tag != null;
    final isSearching = searchTerm.isNotEmpty;
    final isFectchPolicyNetworkOnly =
        fetchPolicy == QuoteListPageFetchPolicy.networkOnly;
    final shouldSkipCachecLookup =
        isFilteringByTag || isSearching || isFectchPolicyNetworkOnly;

    if (shouldSkipCachecLookup) {
      final freshPage = await _getQuoteListPageFromNetwork(
        pageNumber,
        tag: tag,
        searchTerm: searchTerm,
        favoritedByUsername: favoriteByUsername,
      );
      yield freshPage;
    } else {
      final isFilteringByFavorites = favoriteByUsername != null;

      final cachedPage = await _localStorage.getQuoteListPage(
        pageNumber,
        isFilteringByFavorites,
      );

      final isFetchPolicyCacheAndNetwork =
          fetchPolicy == QuoteListPageFetchPolicy.cacheAndNetwork;

      final isFetchPolicyCachePreferably =
          fetchPolicy == QuoteListPageFetchPolicy.cachePreferably;

      final shouldEmitCachedPageInAdvance =
          isFetchPolicyCachePreferably || isFetchPolicyCacheAndNetwork;

      if (shouldEmitCachedPageInAdvance && cachedPage != null) {
        yield cachedPage.toDomainModel();
        if (isFetchPolicyCachePreferably) {
          return;
        }
      }

      try {
        final freshPage = await _getQuoteListPageFromNetwork(
          pageNumber,
          favoritedByUsername: favoriteByUsername,
        );
        yield freshPage;
      } catch (_) {
        final isFetchPolicyNetworkPreferably =
            fetchPolicy == QuoteListPageFetchPolicy.networkPreferably;
        if (cachedPage != null && isFetchPolicyNetworkPreferably) {
          yield cachedPage.toDomainModel();
          return;
        }
        rethrow;
      }
    }
  }

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

enum QuoteListPageFetchPolicy {
  cacheAndNetwork,
  networkOnly,
  networkPreferably,
  cachePreferably,
}
