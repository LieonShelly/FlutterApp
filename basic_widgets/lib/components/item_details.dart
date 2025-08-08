import 'package:basic_widgets/models/cart_manager.dart';
import 'package:basic_widgets/models/restaurant.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  final Item item;
  final CartManager cartManager;
  final void Function() quantityUpdated;

  const ItemDetails({
    super.key,
    required this.item,
    required this.cartManager,
    required this.quantityUpdated,
  });

  @override
  State<ItemDetails> createState() {
    return _ItemDetailsState();
  }
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(
      context,
    ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final colorTheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.name, style: textTheme.headlineMedium),
              const SizedBox(height: 16),
              _mostLikedBadge(colorTheme),
              const SizedBox(height: 16),
              Text(widget.item.description),
              const SizedBox(height: 16),
              _itemImage(widget.item.imageUrl),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mostLikedBadge(ColorScheme colorTheme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(4),
        color: colorTheme.onPrimary,
        child: const Text('#1 Most Liked'),
      ),
    );
  }

  Widget _itemImage(String imageUrl) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
