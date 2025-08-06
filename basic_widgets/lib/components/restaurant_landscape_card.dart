import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantLandscapeCard extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantLandscapeCard({super.key, required this.restaurant});

  @override
  State<RestaurantLandscapeCard> createState() {
    return _RestaurantLandscapeCardState();
  }
}

class _RestaurantLandscapeCardState extends State<RestaurantLandscapeCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(
      context,
    ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final restaurant = widget.restaurant;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(widget.restaurant.imageUrl, fit: BoxFit.cover),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                      },
                      icon: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                      ),
                      color: Colors.red[400],
                      iconSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            title: Text(restaurant.name, style: textTheme.titleSmall),
            subtitle: Text(
              restaurant.attributes,
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            onTap: () {
              print('Tap on ${restaurant.name}');
            },
          ),
        ],
      ),
    );
  }
}
