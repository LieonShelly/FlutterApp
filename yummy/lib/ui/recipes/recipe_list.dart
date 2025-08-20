import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ListType { all, bookmarks }

class RecipeList extends ConsumerStatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipeListState();
}

class _RecipeListState extends ConsumerState<RecipeList> {
  static const String prefSearchKey = "previousSearches";
  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
}
