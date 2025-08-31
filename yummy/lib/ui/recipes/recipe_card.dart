import 'package:basic_widgets/models/models.dart';
import 'package:basic_widgets/ui/theme/colors.dart';
import 'package:basic_widgets/ui/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget recipeCard(Recipe reciipe) {
  return Card(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
      side: BorderSide(color: borderColor, width: 1.0),
    ),
    child: Container(
      decoration: const BoxDecoration(color: cardBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 0, 0),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    reciipe.label ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontFamily: 'Roboto', fontSize: 16),
                  ),
                ),
                SvgPicture.asset('assets/images/arrow_circle_right.svg'),
                const SizedBox(width: 20),
              ],
            ),
          ),
          sizedH8,
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: Hero(
              tag: 'recipe-${reciipe.id}',
              child: CachedNetworkImage(
                imageUrl: reciipe.image ?? '',
                height: 274,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
