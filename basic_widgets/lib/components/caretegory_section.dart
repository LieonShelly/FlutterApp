import 'package:basic_widgets/components/category_card.dart';
import 'package:flutter/material.dart';
import '../models/food_category.dart';

class CaretegorySection extends StatelessWidget {
  final List<FoodCategory> categories;
  const CaretegorySection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 275,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: CategoryCard(category: categories[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
