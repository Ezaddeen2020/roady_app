import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

import 'place.dart';

class DataService {
  static const String _favoritesKey = 'user_favorites';
  static const String _routesKey = 'user_routes';
  static const String _recentSearchesKey = 'recent_searches';

  // حفظ الأماكن المفضلة
  Future<void> saveFavorites(List<Place> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((place) => place.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(jsonList));
  }

  // استرجاع الأماكن المفضلة
  Future<List<Place>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString == null) return [];

    final jsonList = json.decode(jsonString) as List;
    return jsonList.map((json) => Place.fromJson(json)).toList();
  }

  // إضافة مكان للمفضلة
  Future<void> toggleFavorite(Place place) async {
    final favorites = await getFavorites();
    final index = favorites.indexWhere((p) => p.id == place.id);

    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(place.copyWith(isFavorite: true));
    }

    await saveFavorites(favorites);
  }

  // حفظ الرحلات
  Future<void> saveRoute(TripRoute route) async {
    final prefs = await SharedPreferences.getInstance();
    final routes = await getRoutes();
    routes.add(route);

    final jsonList = routes.map((r) => r.toJson()).toList();
    await prefs.setString(_routesKey, json.encode(jsonList));
  }

  // استرجاع جميع الرحلات
  Future<List<TripRoute>> getRoutes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_routesKey);
    if (jsonString == null) return [];

    final jsonList = json.decode(jsonString) as List;
    return jsonList.map((json) => TripRoute.fromJson(json)).toList();
  }

  // حفظ البحث الأخير
  Future<void> saveRecentSearch(String search) async {
    final prefs = await SharedPreferences.getInstance();
    final searches = await getRecentSearches();

    searches.remove(search);
    searches.insert(0, search);

    if (searches.length > 10) {
      searches.removeRange(10, searches.length);
    }

    await prefs.setString(_recentSearchesKey, json.encode(searches));
  }

  // استرجاع البحث الأخير
  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_recentSearchesKey);
    if (jsonString == null) return [];

    return List<String>.from(json.decode(jsonString));
  }

  // محاكاة جلب البيانات من API
  Future<List<Place>> fetchNearbyPlaces(
      LatLng location, String category) async {
    // في التطبيق الحقيقي، ستستدعي API هنا
    await Future.delayed(const Duration(seconds: 1));

    return _generateSamplePlaces(location, category);
  }

  List<Place> _generateSamplePlaces(LatLng center, String category) {
    final places = <Place>[];
    final random = DateTime.now().millisecondsSinceEpoch;

    for (int i = 0; i < 5; i++) {
      places.add(Place(
        id: '${category}_$i',
        name: '$category Place ${i + 1}',
        category: category,
        location: LatLng(
          center.latitude + (random % 100 - 50) / 10000,
          center.longitude + (random % 100 - 50) / 10000,
        ),
        rating: 3.5 + (random % 15) / 10,
        description: 'A great place for $category',
      ));
    }

    return places;
  }

  // البحث عن الأماكن
  Future<List<Place>> searchPlaces(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // في التطبيق الحقيقي، ستستدعي API البحث هنا
    return [];
  }
}
