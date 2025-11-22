import 'package:latlong2/latlong.dart';

class RoutePoint {
  final String id;
  final String name;
  final LatLng coordinates;
  final String? address;
  final String? category;
  final String? icon;
  final DateTime? arrivalTime;
  final DateTime? departureTime;
  final String? notes;
  final bool isVisited;

  RoutePoint({
    required this.id,
    required this.name,
    required this.coordinates,
    this.address,
    this.category,
    this.icon,
    this.arrivalTime,
    this.departureTime,
    this.notes,
    this.isVisited = false,
  });

  RoutePoint copyWith({
    String? id,
    String? name,
    LatLng? coordinates,
    String? address,
    String? category,
    String? icon,
    DateTime? arrivalTime,
    DateTime? departureTime,
    String? notes,
    bool? isVisited,
  }) {
    return RoutePoint(
      id: id ?? this.id,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
      address: address ?? this.address,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departureTime: departureTime ?? this.departureTime,
      notes: notes ?? this.notes,
      isVisited: isVisited ?? this.isVisited,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': coordinates.latitude,
      'lng': coordinates.longitude,
      'address': address,
      'category': category,
      'icon': icon,
      'arrivalTime': arrivalTime?.toIso8601String(),
      'departureTime': departureTime?.toIso8601String(),
      'notes': notes,
      'isVisited': isVisited,
    };
  }

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      id: json['id'],
      name: json['name'],
      coordinates: LatLng(json['lat'], json['lng']),
      address: json['address'],
      category: json['category'],
      icon: json['icon'],
      arrivalTime: json['arrivalTime'] != null
          ? DateTime.parse(json['arrivalTime'])
          : null,
      departureTime: json['departureTime'] != null
          ? DateTime.parse(json['departureTime'])
          : null,
      notes: json['notes'],
      isVisited: json['isVisited'] ?? false,
    );
  }
}
