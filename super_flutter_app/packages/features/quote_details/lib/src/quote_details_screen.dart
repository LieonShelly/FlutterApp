import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_details/src/quote_details_cubit.dart';
import 'package:quote_repository/quote_repository.dart';

typedef QUoteDetailsShareableLinkGenerator =
    Future<String> Function(Quote quote);

class QuoteDetailsScreen extends StatelessWidget {
  final int quoteId;
  final VoidCallback onAuthenticatonError;
  final QuoteRepository quoteRepository;
  final QUoteDetailsShareableLinkGenerator? shareableLinkGenerator;

  const QuoteDetailsScreen({
    required this.quoteId,
    required this.onAuthenticatonError,
    required this.quoteRepository,
    this.shareableLinkGenerator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          QuoteDetailsCubit(quoteId: quoteId, quoteRepository: quoteRepository),
      child: QuoteDetailsView(
        onAuthenticatonError: onAuthenticatonError,
        shareableLinkGenerator: shareableLinkGenerator,
      ),
    );
  }
}

@visibleForTesting
class QuoteDetailsView extends StatelessWidget {
  final VoidCallback onAuthenticatonError;
  final QUoteDetailsShareableLinkGenerator? shareableLinkGenerator;

  const QuoteDetailsView({
    required this.onAuthenticatonError,
    this.shareableLinkGenerator,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return StyledStatusBar.dark(
      child: BlocConsumer<QuoteDetailsCubit, QuoteDetailsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              final dispayedQuote = state is QuoteDetailsSuccess
                  ? state.quote
                  : null;
              Navigator.of(context).pop(dispayedQuote);
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(Spacing.mediumLarge),
                child: state is QuoteDetailsSuccess
                    ? _Quote(quote: state.quote)
                    : state is QuoteDetailFailure
                    ? ExceptionIndicator(
                        onTryAgain: () {
                          final cubit = context.read<QuoteDetailsCubit>();
                          cubit.refetch();
                        },
                      )
                    : const CenteredCircularProgressIndicator(),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

class _Quote extends StatelessWidget {
  static const double _quoteIconWidth = 46;
  final Quote quote;

  const _Quote({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: OpeningQuoteSvgAsset(width: _quoteIconWidth),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xxLarge),
            child: Center(
              child: ShrinkableText(
                text: quote.body,
                style: TextStyle(fontSize: FontSize.xxLarge),
              ),
            ),
          ),
        ),

        const ClosingQuoteSvgAsset(width: _quoteIconWidth),

        const SizedBox(height: Spacing.medium),

        Text(
          quote.author ?? '',
          style: const TextStyle(fontSize: FontSize.large),
        ),
      ],
    );
  }
}
