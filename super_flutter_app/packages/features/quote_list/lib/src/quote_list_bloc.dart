import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/transformers.dart';
import 'package:user_repository/user_repository.dart';
part 'quote_list_event.dart';
part 'quote_list_state.dart';

class QuoteListBloc extends Bloc<QuoteListEvent, QuoteListState> {
  late final StreamSubscription _authChangesSubscription;
  String? _authenticationUsername;
  final QuoteRepository _quoteRepository;

  QuoteListBloc({
    required QuoteRepository quoteRepositroy,
    required UserRepository userRepository,
  }) : _quoteRepository = quoteRepositroy,
       super(const QuoteListState()) {
    _registerEventHandler();
    // userRepository.get...
  }

  void _registerEventHandler() {
    on<QuoteListEvent>(
      (event, emitter) async {
        if (event is QuoteListUsernameObtained) {
        } else if (event is QuoteListFailedFetchRetried) {
        } else if (event is QuoteListItemUpdated) {
        } else if (event is QuoteListTagChanged) {}
      },
      transformer: (eventStream, eventHandler) {
        final nonDebounceEventStream = eventStream.where(
          (event) => event is! QuoteListSearchTermChanged,
        );
        final debounceEventStream = eventStream
            .whereType<QuoteListSearchTermChanged>()
            .debounceTime(const Duration(seconds: 1))
            .where((event) {
              final previousFilter = state.filter;
              final previousSearchTerm =
                  previousFilter is QuoteListFilterBySearchTerm
                  ? previousFilter.searchTerm
                  : '';
              return event.searhTerm != previousSearchTerm;
            });

        final mergedEventStream = MergeStream([
          nonDebounceEventStream,
          debounceEventStream,
        ]);
        final restartableTransformer = restartable<QuoteListEvent>();
        return restartableTransformer(mergedEventStream, eventHandler);
      },
    );
  }
}
