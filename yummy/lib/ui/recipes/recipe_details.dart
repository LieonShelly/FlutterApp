import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_widgets/models/recipe.dart';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/providers.dart';
import 'package:basic_widgets/ui/theme/colors.dart';
import 'package:basic_widgets/ui/widgets/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:flutter_html/flutter_html.dart';

class RecipeDetails extends ConsumerStatefulWidget {
  final Recipe recipe;

  const RecipeDetails({Key? key, required this.recipe}) : super(key: key);

  @override
  ConsumerState<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends ConsumerState<RecipeDetails> {
  Recipe? recipeDetail;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  void loadRecipe() async {
    final resposne = await ref
        .read(serviceProvider)
        .queryRecipe(widget.recipe.id.toString());
    final result = resposne.body;
    if (result is Success<Recipe>) {
      final body = result;
      recipeDetail = body.value;
      if (mounted) {
        setState(() {});
      }
    } else {
      logMessage('Problems getting Recipe $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: maxHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                topImage(context),
                sizedW16,
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [titleRow(), sizedW16, description()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: 150,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [lightGreen, Colors.white, lightGreen],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: 'recipe-${widget.recipe.id}',
            child: CachedNetworkImage(
              imageUrl: widget.recipe.image ?? '',
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
              placeholder: (context, url) => const CircularProgressIndicator(),
              height: 150,
              width: 200,
            ),
          ),
        ),
      ],
    );
  }

  Widget titleRow() {
    final repository = ref.read(repositoryProvider.notifier);
    final titleRowColor = widget.recipe.bookmarked
        ? Colors.black
        : Colors.white;
    return Container(
      decoration: const BoxDecoration(color: lightGreen),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: titleRowColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: AutoSizeText(
                widget.recipe.label ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Roboo',
                  color: titleRowColor,
                ),
              ),
            ),

            IconButton(
              onPressed: () {
                if (!widget.recipe.bookmarked) {
                  if (recipeDetail != null) {
                    repository.insertRecipe(recipeDetail!);
                  }
                } else {
                  repository.deleteRecipe(recipeDetail!);
                }
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                widget.recipe.bookmarked
                    ? 'assets/images/icon_bookmarks.svg'
                    : 'assets/images/icon_bookmark.svg',
                colorFilter: ColorFilter.mode(titleRowColor, BlendMode.srcIn),
              ),
            ),

            sizedW8,
          ],
        ),
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24),
      child: Html(data: recipeDetail?.description ?? ''),
    );
  }
}
