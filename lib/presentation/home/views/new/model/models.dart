// models.dart
class FoodCategory {
  final String imagePath;
  final String label;
  final String image;

  const FoodCategory({
    required this.imagePath,
    required this.label,
    required this.image,
  });
}

class Store {
  final String name;
  final String logoPath;
  final double rating;
  final String deliveryTime;
  final String category;

  const Store({
    required this.name,
    required this.logoPath,
    required this.rating,
    required this.deliveryTime,
    required this.category,
  });
}

class Restaurant {
  final String name;
  final String logoPath;
  final double rating;
  final String deliveryTime;
  final bool freeDelivery;
  final bool sponsored;
  final String? badge;
  final String? discount;

  const Restaurant({
    required this.name,
    required this.logoPath,
    required this.rating,
    required this.deliveryTime,
    this.freeDelivery = false,
    this.sponsored = false,
    this.badge,
    this.discount,
  });
}
