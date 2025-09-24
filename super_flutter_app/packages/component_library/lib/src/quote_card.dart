import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String statement;
  final String? author;
  final bool isFavorite;
  final Widget? top;
  final Widget? boottom;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const QuoteCard({
    required this.statement,
    required this.isFavorite,
    this.author,
    this.top,
    this.boottom,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final top = this.top;
    final bottom = this.boottom;
    final author = this.author;
    return Card(
      margin: EdgeInsets.all(0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                if (top != null)
                  Padding(
                    padding: const EdgeInsets.only(left: Spacing.medium),
                    child: top,
                  ),
                const Spacer(),
                IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge),
              child: Text(
                statement,
                style: const TextStyle(
                  fontFamily: 'Fondamento',
                  package: 'component_library',
                ),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.only(right: Spacing.medium),
                child: bottom,
              ),
            const SizedBox(height: Spacing.mediumLarge),
            if (author != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: Spacing.medium,
                  right: Spacing.medium,
                ),
                child: Text(author),
              ),
          ],
        ),
      ),
    );
  }
}
