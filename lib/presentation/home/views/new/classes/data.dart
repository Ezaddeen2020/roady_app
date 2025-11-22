// data.dart
import '../model/models.dart';

class AppData {
  static const List<FoodCategory> foodCategories = [
    FoodCategory(imagePath: 'assets/images/food/dessert.png', label: 'Italiaans', image: 'pasta'),
    FoodCategory(imagePath: 'assets/images/food/coffee.png', label: 'Koffie', image: 'coffee'),
    FoodCategory(imagePath: 'assets/images/food/burger.png', label: 'Mexicaans', image: 'mexican'),
    FoodCategory(imagePath: 'assets/images/food/piz.avif', label: 'pizza', image: 'pizza'),
    FoodCategory(imagePath: 'assets/images/food/perfeto.jpg', label: 'perfeto', image: 'perfeto'),
    FoodCategory(imagePath: 'assets/images/food/pizza.jpg', label: 'pizza', image: 'pizza'),
  ];

  static const List<Restaurant> restaurants = [
    Restaurant(
      name: 'CAFE DE PARIS REST...',
      logoPath: 'assets/images/cafe/cafede.png',
      rating: 4.7,
      deliveryTime: '20 min.',
      freeDelivery: true,
      badge: '20 YEARS',
    ),
    Restaurant(
      name: 'Sushi Buzz',
      logoPath: 'assets/images/cafe/sus.png',
      rating: 4.6,
      deliveryTime: '50 min.',
      discount: '-30% op geselecteerde items',
    ),
    Restaurant(
      name: 'KFC',
      logoPath: 'assets/images/food/kfc.png',
      rating: 4.4,
      deliveryTime: 'Ongeveer 30 min.',
      freeDelivery: true,
      sponsored: true,
    ),
    Restaurant(
      name: 'CAFE DE PARIS REST...',
      logoPath: 'assets/images/cafe/ore.webp',
      rating: 4.7,
      deliveryTime: '20 min.',
      freeDelivery: true,
      badge: '20 YEARS',
    ),
    // Restaurant(
    //   name: 'Sushi Buzz',
    //   logoPath: 'assets/images/cafe/do.png',
    //   rating: 4.6,
    //   deliveryTime: '50 min.',
    //   discount: '-30% op geselecteerde items',
    // ),
    // Restaurant(
    //   name: 'Sushi Buzz',
    //   logoPath: 'assets/images/cafe/sumo.png',
    //   rating: 4.6,
    //   deliveryTime: '50 min.',
    //   discount: '-30% op geselecteerde items',
    // ),
    Restaurant(
      name: 'Sushi Buzz',
      logoPath: 'assets/images/cafe/nes.png',
      rating: 4.6,
      deliveryTime: '50 min.',
      discount: '-30% op geselecteerde items',
    ),
    Restaurant(
      name: 'KFC',
      logoPath: 'assets/images/cafe/papa.png',
      rating: 4.4,
      deliveryTime: 'Ongeveer 30 min.',
      freeDelivery: true,
      sponsored: true,
    ),
    Restaurant(
      name: 'KFC',
      logoPath: 'assets/images/food/mcd.png',
      rating: 4.4,
      deliveryTime: 'Ongeveer 30 min.',
      freeDelivery: true,
      sponsored: true,
    ),
  ];

  static const List<String> filterOptions = [
    'Dietopties',
    'Deliveroo\'s Choice',
    'Sorteren',
    'Deals',
    'Popular',
    'Top Rated',
    'Free Delivery',
  ];
}
