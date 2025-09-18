import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_list/src/quote_list_bloc.dart';

class FilterHorizontalList extends StatelessWidget {
  const FilterHorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: Spacing.mediumLarge),
      child: Row(children: [
        const _FavoritesChip(),
        ...Tag.values.map ((tag) => )
        ],
      ),
    );
  }
}

const _itemSpacing = Spacing.xSmall;

class _FavoritesChip extends StatelessWidget {
  const _FavoritesChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: _itemSpacing, left: Spacing.mediumLarge),
      child: BlocSelector<QuoteListBloc, QuoteListState, bool>(
        selector: (state) {
          final isFilterByFavorites =
              state.filter is QuoteListFilterByFavorites;
          return isFilterByFavorites;
        },
        builder: (constext, isFavoritesOnly) {
          return RoundedChoiceChip(
            label: "Favorites",
            avatar: Icon(
              isFavoritesOnly ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFavoritesOnly ? Colors.redAccent : Colors.black,
            ),
            isSelected: isFavoritesOnly,
            onSelected: (isSelected) {
              _releaseFocus(context);
              final bloc = context.read<QuoteListBloc>();
              bloc.add(const QuoteListFilterByFavoritesToggled());
            },
          );
        },
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final Tag tag;

  const _TagChip({
    required this.tag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLastag = Tag.values.last == tag;
    return Padding(
      padding: EdgeInsets.only(right:  isLastag ? Spacing.mediumLarge : _itemSpacing, left: _itemSpacing,),
      child: BlocSelector<QuoteListBloc, QuoteListState, Tag?>(selector: (state) {
        final filter = state.filter;
        final selectedTag = filter is QuoteListFilterByTag ? filter.tag : null;
        return selectedTag;
      }, builder: (context, selectedTag) {
        final isSelected = selectedTag == tag;
        return RoundedChoiceChip(
          label: tag.toLocalizedString(context), 
          isSelected: isSelected,
          onSelected: (isSelected) {
            _releaseFocus(context);
             final bloc = context.read<QuoteListBloc>();
              bloc.add(
                QuoteListTagChanged(
                  tag: isSelected ? tag : null
                ),
              );
          },
        );
      }),
    
    );
  }
}

void _releaseFocus(BuildContext context) {
  FocusScope.of(context).unfocus()
}
extension on Tag {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case Tag.life:
        return "Lfie";
      case Tag.happiness:
        return "happiness";
      case Tag.work:
        return "work";
      case Tag.nature:
        return "nature";
      case Tag.science:
        return "science";
      case Tag.love:
        return "love";
      case Tag.funny:
        return "love";
    }
  }
}
