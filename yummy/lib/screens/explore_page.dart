import 'package:basic_widgets/components/caretegory_section.dart';
import 'package:basic_widgets/components/post_section.dart';
import 'package:basic_widgets/components/restaurant_section.dart';
import 'package:basic_widgets/models/cart_manager.dart';
import 'package:basic_widgets/models/order_manager.dart';
import 'package:flutter/material.dart';
import '../api/mock_yummy_service.dart';

class ExplorePage extends StatelessWidget {
  final mockService = MockYummyService();
  final CartManager cartManager;
  final OrderManager orderManager;

  ExplorePage({
    super.key,
    required this.cartManager,
    required this.orderManager,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final categories = snapshot.data?.categories ?? [];
          final restaurants = snapshot.data?.restaurants ?? [];
          final posts = snapshot.data?.friendPosts ?? [];
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              RestaurantSection(
                restaurants: restaurants,
                cartManager: cartManager,
                orderManager: orderManager,
              ),
              CaretegorySection(categories: categories),
              PostSection(posts: posts),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
