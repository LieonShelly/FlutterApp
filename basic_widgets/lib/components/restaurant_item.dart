import 'package:basic_widgets/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final Item item;

  const RestaurantItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildListItem()),
        _buildImageStack(colorScheme),
      ],
    );
  }

  Widget _buildImageStack(ColorScheme colorScheme) {
    return Stack(children: [_buildImage(), _buildAddButton(colorScheme)]);
  }

  Widget _buildAddButton(ColorScheme colorScheme) {
    return Positioned(
      bottom: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Add',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.network(item.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildListItem() {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text(item.name),
      subtitle: _buildSubtitle(),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Row(
          children: [
            Text('${item.price}'),
            const SizedBox(width: 4),
            const Icon(Icons.thumb_up, color: Colors.green, size: 18),
          ],
        ),
      ],
    );
  }
}
