import 'dart:ffi';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:quote_list/src/filter_horizontal_list.dart';
import 'package:quote_list/src/quote_list_bloc.dart';
import 'package:quote_list/src/quote_paged_list_view.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';

typedef QuoteSelected = Future<Quote> Function(int selectedQuote);

class QuoteListScreen extends StatelessWidget {
  final QuoteRepository quoteRepository;
  final UserRepository userRepository;
  //final RemoteValueService remoteValueService;
  final QuoteSelected? onQuoteSelected;
  final void Function(BuildContext context) onAuthenticationError;

  const QuoteListScreen({
    required this.quoteRepository,
    required this.userRepository,
    required this.onAuthenticationError,
    // required this.remoteValueService,
    this.onQuoteSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteListBloc>(
      create: (_) => QuoteListBloc(
        quoteRepositroy: quoteRepository,
        userRepository: userRepository,
      ),
      child: QuoteListView(onAuthenticationError: onAuthenticationError),
    );
  }
}

@visibleForTesting
class QuoteListView extends StatefulWidget {
  // final RemoteValueService remoteValueService;
  final QuoteSelected? onQuoteSelected;
  final void Function(BuildContext context) onAuthenticationError;

  QuoteListView({
    required this.onAuthenticationError,
    this.onQuoteSelected,
    Key? key,
  });

  @override
  _QuoteListViewState createState() {
    return _QuoteListViewState();
  }
}

class _QuoteListViewState extends State<QuoteListView> {
  final PagingController<int, Quote> _pagingController = PagingController(
    firstPageKey: 1,
  );
  final TextEditingController _searchBarContoller = TextEditingController();

  QuoteListBloc get _bloc => context.read<QuoteListBloc>();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageNumber) {
      final isSubsequentPage = pageNumber > 1;
      if (isSubsequentPage) {
        _bloc.add(QuoteListNextPageRequested(pageNumber: pageNumber));
      }
    });

    _searchBarContoller.addListener(() {
      _bloc.add(QuoteListSearchTermChanged(_searchBarContoller.text));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteListBloc, QuoteListState>(
      listener: (context, state) {
        final searchBarText = _searchBarContoller.text;
        final isSearching =
            state.filter != null && state.filter is QuoteListFilterBySearchTerm;
        if (searchBarText.isNotEmpty && !isSearching) {
          _searchBarContoller.text = '';
        }

        if (state.refreshError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'We couldn\'t refresh your items.\nPlease, check your internet connection and try again later.',
              ),
            ),
          );
        } else if (state.favoriteToggleError != null) {
          final snackBar =
              state.favoriteToggleError is UserAuthenticationRequiredException
              ? const AuthenticationRequiredErrorSnackBar()
              : const GenericErrorSnackBar();

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          widget.onAuthenticationError(context);
        }
        _pagingController.value = state.toPagingState();
      },
      child: StyledStatusBar.dark(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBar(controller: _searchBarContoller),
                ),
                const FilterHorizontalList(),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      _bloc.add(const QuoteListRefreshed());
                      final stateChaneFuture = _bloc.stream.first;
                      return stateChaneFuture;
                    },
                    child: QuotePagedListView(
                      pagingController: _pagingController,
                      onQuoteSelected: widget.onQuoteSelected,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on QuoteListState {
  PagingState<int, Quote> toPagingState() {
    return PagingState(itemList: itemList, nextPageKey: nextPage, error: error);
  }
}
