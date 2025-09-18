part of 'quote_list_bloc.dart';

abstract class QuoteListEvent extends Equatable {
  const QuoteListEvent();

  @override
  List<Object?> get props => [];
}

class QuoListFilterByFavoritesToggled extends QuoteListEvent {
  const QuoListFilterByFavoritesToggled();
}

class QuoteListTagChanged extends QuoteListEvent {
  final Tag? tag;

  const QuoteListTagChanged({this.tag});

  @override
  List<Object?> get props => [tag];
}

class QuoteListSearchTermChanged extends QuoteListEvent {
  final String searhTerm;

  const QuoteListSearchTermChanged(this.searhTerm);

  @override
  List<Object?> get props => [searhTerm];
}

class QuoteListRefreshed extends QuoteListEvent {
  const QuoteListRefreshed();
}

class QuoteListNextPageRequested extends QuoteListEvent {
  const QuoteListNextPageRequested({required this.pageNumber});

  final int pageNumber;
}

abstract class QuoteListItemFavoriteToggled extends QuoteListEvent {
  const QuoteListItemFavoriteToggled(this.id);

  final int id;
}

class QuoteListItemFavorited extends QuoteListItemFavoriteToggled {
  const QuoteListItemFavorited(int id) : super(id);
}

class QuoteListItemUnfavorited extends QuoteListItemFavoriteToggled {
  const QuoteListItemUnfavorited(int id) : super(id);
}

class QuoteListFailedFetchRetried extends QuoteListEvent {
  const QuoteListFailedFetchRetried();
}

class QuoteListUsernameObtained extends QuoteListEvent {
  const QuoteListUsernameObtained();
}

class QuoteListItemUpdated extends QuoteListEvent {
  const QuoteListItemUpdated(this.updatedQuote);

  final Quote updatedQuote;
}

class QuoteListFilterByFavoritesToggled extends QuoteListEvent {
  const QuoteListFilterByFavoritesToggled();
}
