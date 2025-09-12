import 'dart:ffi';

import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

class QuoteLocalStorage {
  final KeyValueStorage keyValueStorage;

  QuoteLocalStorage({required this.keyValueStorage});

  Future<void> upsertQuoteListPage(
    int pageNumber,
    QuoteListPageCM quoteListPage,
    bool favoritesOnly,
  ) async {
    final box = await (favoritesOnly
        ? keyValueStorage.favoriteQuoteListPageBox
        : keyValueStorage.quoteListPageBox);
    return box.put(pageNumber, quoteListPage);
  }

  Future<void> clearQuoteListPageList(bool favoriteOnly) async {
    final box = await (favoriteOnly
        ? keyValueStorage.favoriteQuoteListPageBox
        : keyValueStorage.quoteListPageBox);
    await box.clear();
  }

  Future<void> clear() async {
    await Future.wait([
      keyValueStorage.quoteListPageBox.then((box) => box.clear()),
      keyValueStorage.favoriteQuoteListPageBox.then((box) => box.clear()),
    ]);
  }

  Future<QuoteListPageCM?> getQuoteListPage(
    int pageNumber,
    bool favoriteOnly,
  ) async {
    final box = await (favoriteOnly
        ? keyValueStorage.favoriteQuoteListPageBox
        : keyValueStorage.quoteListPageBox);
    return box.get(pageNumber);
  }

  Future<QuoteCM?> getQuote(int id) async {
    final favoriteBox = await keyValueStorage.favoriteQuoteListPageBox;
    final quoteBox = await keyValueStorage.quoteListPageBox;

    final completeQuoteList = [
      ...quoteBox.values,
      ...favoriteBox.values,
    ].expand((page) => page.quoteList);
    try {
      return completeQuoteList.firstWhere((quote) => quote.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateQuote(
    QuoteCM updatedQuote,
    bool shouldUpdateFavorites,
  ) async {
    final favoritesBox = await keyValueStorage.favoriteQuoteListPageBox;
    final quoteBox = await keyValueStorage.quoteListPageBox;
    final list = [
      quoteBox.updateQuote(updatedQuote),
      if (shouldUpdateFavorites) favoritesBox.updateQuote(updatedQuote),
    ];
    await Future.wait(list);
  }
}

extension on Box<QuoteListPageCM> {
  Future<void> updateQuote(QuoteCM updatedQuote) async {
    final pageList = values.toList();
    try {
      final outdatedPage = pageList.firstWhere(
        (page) => page.quoteList.any((quote) => quote.id == updatedQuote.id),
      );
      final outdatedPageIndex = pageList.indexOf(outdatedPage);

      final updatedQuotePage = QuoteListPageCM(
        isLastPage: outdatedPage.isLastPage,
        quoteList: outdatedPage.quoteList.map((quote) {
          if (quote.id == updatedQuote.id) {
            return updatedQuote;
          }
          return quote;
        }).toList(),
      );

      final pageNumber = outdatedPageIndex + 1;
      return put(pageNumber, updatedQuotePage);
    } catch (_) {}
  }
}
