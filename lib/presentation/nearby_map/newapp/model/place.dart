import 'package:latlong2/latlong.dart';

class Place {
  final String id;
  final String name;
  final String category;
  final LatLng location;
  final String? description;
  final double? rating;
  final String? imageUrl;
  final bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    this.description,
    this.rating,
    this.imageUrl,
    this.isFavorite = false,
  });

  Place copyWith({
    String? id,
    String? name,
    String? category,
    LatLng? location,
    String? description,
    double? rating,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      location: location ?? this.location,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'description': description,
      'rating': rating,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      location: LatLng(json['latitude'], json['longitude']),
      description: json['description'],
      rating: json['rating']?.toDouble(),
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}

class TripRoute {
  final String id;
  final String name;
  final LatLng startPoint;
  final LatLng endPoint;
  final List<Place> stops;
  final DateTime createdAt;

  TripRoute({
    required this.id,
    required this.name,
    required this.startPoint,
    required this.endPoint,
    required this.stops,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startLatitude': startPoint.latitude,
      'startLongitude': startPoint.longitude,
      'endLatitude': endPoint.latitude,
      'endLongitude': endPoint.longitude,
      'stops': stops.map((stop) => stop.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TripRoute.fromJson(Map<String, dynamic> json) {
    return TripRoute(
      id: json['id'],
      name: json['name'],
      startPoint: LatLng(json['startLatitude'], json['startLongitude']),
      endPoint: LatLng(json['endLatitude'], json['endLongitude']),
      stops:
          (json['stops'] as List).map((stop) => Place.fromJson(stop)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
