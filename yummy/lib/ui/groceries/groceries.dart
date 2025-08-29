import 'dart:io';

import 'package:basic_widgets/models/ingredient.dart';
import 'package:basic_widgets/providers.dart';
import 'package:basic_widgets/ui/theme/colors.dart';
import 'package:basic_widgets/ui/widgets/common.dart';
import 'package:basic_widgets/ui/widgets/ingredient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  final checkBoxValue = <int, bool>{};
  late TextEditingController searchTextController;
  bool showAll = true;
  List<Ingredient> currentIngredients = [];
  bool searching = false;
  List<Ingredient> searchIngredients = [];
  final ScrollController _scrollController = ScrollController();
  final searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          buildSearchRow(),
          showAll ? buildIngredientList() : buildNededHaveList(),
        ],
      ),
    );
  }

  Widget buildNededHaveList() {
    final repository = ref.watch(repositoryProvider);
    currentIngredients = repository.curentIngredients;
    final needListIndexes = <int, bool>{};
    final haveListIndexes = <int, bool>{};

    final ingredients = currentIngredients;
    for (var index = 0; index < ingredients.length; index++) {
      if (!checkBoxValue.containsKey(index)) {
        needListIndexes[index] = true;
      } else {
        haveListIndexes[index] = true;
      }
    }
    final needList = <Ingredient>[];
    final haveList = <Ingredient>[];
    for (var index = 0; index < ingredients.length; index++) {
      if (needListIndexes.containsKey(index)) {
        needList.add(ingredients[index]);
      }
      if (haveListIndexes.containsKey(index)) {
        haveList.add(ingredients[index]);
      }
    }
    final columnList = <Widget>[];
    if (needList.isNotEmpty) {
      columnList.add(const Text('Need'));
      columnList.add(ingredientList(needList, null, false));
    }
    if (haveList.isNotEmpty) {
      columnList.add(const Text('Have'));
      columnList.add(ingredientList(haveList, null, false));
    }
    return Expanded(child: Column(children: columnList));
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Container(decoration: const BoxDecoration(color: background1Color)),
          Center(
            child: Image.asset(
              'assets/images/background1.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchRow() {
    return Row(
      children: [
        sizedW8,
        IconButton(
          onPressed: () {
            startSearch(searchTextController.text);
          },
          icon: const Icon(Icons.search),
        ),
        sizedH8,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                  ),
                  focusNode: searchFocusNode,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (vallue) {
                    startSearch(searchTextController.text);
                  },
                  controller: searchTextController,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              searching = false;
              searchTextController.text = '';
            });
          },
          icon: const Icon(Icons.close),
        ),

        PopupMenuButton(
          icon: const Icon(Icons.filter_list),
          onSelected: (String value) {
            setState(() {
              showAll = value == 'All';
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              CheckedPopupMenuItem(
                value: 'All',
                checked: showAll,
                child: const Text('All'),
              ),
              CheckedPopupMenuItem(
                value: 'Need',
                checked: !showAll,
                child: const Text('Need/Have'),
              ),
            ];
          },
        ),
        sizedW8,
      ],
    );
  }

  Widget buildIngredientList() {
    final repository = ref.watch(repositoryProvider);
    currentIngredients = repository.curentIngredients;
    if (searching) {
      startSearch(searchTextController.text);
      return ingredientList(searchIngredients, checkBoxValue, true);
    } else {
      return ingredientList(currentIngredients, checkBoxValue, true);
    }
  }

  Widget ingredientList(
    List<Ingredient> ingredients,
    Map<int, bool>? checkBoxValues,
    bool showCheckbox,
  ) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          final checked = checkBoxValues?[index] ?? false;
          return createIngredientCard(
            ingredients[index],
            checkBoxValues,
            checked,
            index,
            showCheckbox,
          );
        },
      ),
    );
  }

  Widget createIngredientCard(
    Ingredient ingredient,
    Map<int, bool>? checkBoxValues,
    bool checked,
    int index,
    bool showCheckbox,
  ) {
    final even = index % 2 == 0;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IngredientCard(
        name: ingredient.name ?? '',
        initiallyChecked: checked,
        evenRow: even,
        showCheckbox: showCheckbox,
        onChecked: (newValue) {
          checkBoxValues?[index] = newValue;
        },
      ),
    );
  }

  void startSearch(String searchString) {
    searching = searchString.isNotEmpty;
    searchIngredients = ref
        .read(repositoryProvider.notifier)
        .findAllIngredients()
        .where((element) => true == element.name?.contains(searchString))
        .toList();
    setState(() {});
  }
}
