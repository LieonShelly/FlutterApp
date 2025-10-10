import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const FavoriteIconButton({required this.isFavorite, this.onTap, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: 'Favorite',
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
    );
  }
}
