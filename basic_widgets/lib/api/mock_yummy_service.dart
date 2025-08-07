import '../models/models.dart';

class ExploreData {
  final List<Restaurant> restaurants;
  final List<FoodCategory> categories;
  final List<Post> friendPosts;

  ExploreData(this.restaurants, this.categories, this.friendPosts);
}

class MockYummyService {
  Future<ExploreData> getExploreData() async {
    List<Post> posts = await _getFriendFeed();
    List<Restaurant> retaurants = await _getRestaruants();
    List<FoodCategory> categories = await _getCategories();
    return ExploreData(retaurants, categories, posts);
  }

  Future<List<Post>> _getFriendFeed() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return posts;
  }

  Future<List<FoodCategory>> _getCategories() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return categories;
  }

  Future<List<Restaurant>> _getRestaruants() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return restaurants;
  }
}
