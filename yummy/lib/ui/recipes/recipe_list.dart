import 'dart:math';

import 'package:basic_widgets/models/recipe.dart';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/network/query_result.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:basic_widgets/providers.dart';
import 'package:basic_widgets/ui/bookmarks/bookmarks.dart';
import 'package:basic_widgets/ui/recipes/recipe_card.dart';
import 'package:basic_widgets/ui/recipes/recipe_details.dart';
import 'package:basic_widgets/ui/theme/colors.dart';
import 'package:basic_widgets/ui/widgets/common.dart';
import 'package:basic_widgets/ui/widgets/custom_dropdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  List<Recipe> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previusSearches = [];
  ListType currentType = ListType.all;
  Future<RecipeResponse>? currentResponse;
  bool newDataRequired = true;

  @override
  void initState() {
    super.initState();
    getPreviousSearches();
    searchTextController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    switch (currentType) {
      case ListType.all:
        return buildRecipeList();
      case ListType.bookmarks:
        return buildBookmarkList();
    }
  }

  @override
  void dispose() {
    searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBookmarkList() {
    return buildScrollList([
      buildHeader(),
      _buildTypePicker(),
    ], const Bookmarks());
  }

  Widget buildRecipeList() {
    return buildScrollList([
      buildHeader(),
      _buildTypePicker(),
      _buildSearchCard(),
    ], _buildRecipeLoader());
  }

  Widget buildHeader() {
    return SizedBox(
      height: 160,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Stack(
          children: [
            Container(decoration: const BoxDecoration(color: lightGreen)),
            Center(
              child: Image.asset(
                "assets/images/background2.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypePicker() {
    return IntrinsicWidth(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<ListType>(
              segments: const [
                ButtonSegment<ListType>(
                  value: ListType.all,
                  label: Text('All'),
                  enabled: true,
                ),
                ButtonSegment<ListType>(
                  value: ListType.bookmarks,
                  label: Text('Bookmarks'),
                  icon: Icon(Icons.bookmark_outline),
                  enabled: true,
                ),
              ],
              selected: {currentType},
              onSelectionChanged: (Set<ListType> newSelection) {
                setState(() {
                  currentType = newSelection.first;
                });
              },
              selectedIcon: Icon(Icons.search),
              showSelectedIcon: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            sizedW8,
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        startSearch(value);
                      },
                      controller: searchTextController,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        searchTextController.text = '';
                      });
                    },
                  ),

                  PopupMenuButton(
                    icon: const Icon(Icons.arrow_drop_down, color: lightGrey),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return previusSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                            return CustomDropdownMenuItem<String>(
                              value: value,
                              text: value,
                              callback: () {
                                setState(() {
                                  previusSearches.remove(value);
                                  savePreviousSearches();
                                  Navigator.pop(context);
                                });
                              },
                            );
                          })
                          .toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeLoader() {
    if (searchTextController.text.length < 3) {
      return emptySliverWidget;
    }
    return FutureBuilder<RecipeResponse>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SliverFillRemaining(
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          loading = false;
          final result = snapshot.data;
          if (result is Error || result?.body == null) {
            const errorMessage = 'Problems getting data';
            return const SliverFillRemaining(
              child: Center(
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }
          final query = (result!.body as Success).value as QueryResult;
          inErrorState = false;
          currentCount = query.totalResults;
          hasMore = query.totalResults > query.offset + query.number;
          currentSearchList.addAll(query.recipes);
          currentEndPosition = min(
            query.totalResults,
            currentEndPosition + query.number,
          );

          if (currentCount == 0) {
            return const SliverFillRemaining(
              child: Center(
                child: Text(
                  'No result',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          } else {
            return _buildRecipeList(context, currentSearchList);
          }
        } else {
          if (currentCount == 0) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return _buildRecipeList(context, currentSearchList);
          }
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext context, List<Recipe> recipes) {
    return SliverLayoutBuilder(
      builder: (BuildContext context, SliverConstraints constraints) {
        final numColumn = max(1, constraints.crossAxisExtent ~/ 264);
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(childCount: recipes.length, (
            BuildContext context,
            int index,
          ) {
            return _buildRecipeCard(context, recipes, index);
          }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: numColumn,
            mainAxisExtent: 330,
          ),
        );
      },
    );
  }

  Widget _buildRecipeCard(
    BuildContext topLevelContext,
    List<Recipe> recipes,
    int index,
  ) {
    final recipe = recipes[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          topLevelContext,
          MaterialPageRoute(
            builder: (context) {
              return RecipeDetails(recipe: recipe);
            },
          ),
        );
      },
      child: recipeCard(recipe),
    );
  }

  Future<RecipeResponse> fetchData() async {
    if (!newDataRequired && currentResponse != null) {
      return currentResponse!;
    }
    newDataRequired = false;
    final recipeService = ref.watch(serviceProvider);
    currentResponse = recipeService.queryRecipes(
      searchTextController.text.trim(),
      currentStartPosition,
      pageCount,
    );
    return currentResponse ?? Future.error('No Data found');
  }

  Widget buildScrollList(List<Widget> topList, Widget bottomWidget) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...topList,
        ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            physics: const ClampingScrollPhysics(),
          ),
          child: Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(padding: allPadding8, sliver: bottomWidget),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void startSearch(String value) {
    if (value.isEmpty) {
      return;
    }
    setState(() {
      currentSearchList.clear();
      newDataRequired = true;
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = false;
      value = value.trim();
      if (!previusSearches.contains(value)) {
        previusSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  void savePreviousSearches() async {
    final prefres = ref.read(sharedPrefProvider);
    prefres.setStringList(prefSearchKey, previusSearches);
  }

  void getPreviousSearches() async {
    final prefs = ref.read(sharedPrefProvider);
    if (prefs.containsKey(prefSearchKey)) {
      final searchs = prefs.getStringList(prefSearchKey);
      if (searchs != null) {
        previusSearches = searchs;
      } else {
        previusSearches = [];
      }
    }
  }
}
