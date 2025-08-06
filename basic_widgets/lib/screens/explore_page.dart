import 'package:basic_widgets/components/caretegory_section.dart';
import 'package:flutter/material.dart';
import '../api/mock_yummy_service.dart';

class ExplorePage extends StatelessWidget {
  final mockService = MockYummyService();

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final categories = snapshot.data?.categories ?? [];
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [CaretegorySection(categories: categories)],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
