import 'package:latlong2/latlong.dart';
import 'route_point.dart';

class Trip {
  final String id;
  final String name;
  final List<RoutePoint> routePoints;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isActive;
  final int currentPointIndex;
  final String? description;

  Trip({
    required this.id,
    required this.name,
    required this.routePoints,
    this.startTime,
    this.endTime,
    this.isActive = false,
    this.currentPointIndex = 0,
    this.description,
  });

  RoutePoint? get currentPoint {
    if (currentPointIndex < routePoints.length) {
      return routePoints[currentPointIndex];
    }
    return null;
  }

  RoutePoint? get nextPoint {
    if (currentPointIndex + 1 < routePoints.length) {
      return routePoints[currentPointIndex + 1];
    }
    return null;
  }

  double get totalDistance {
    if (routePoints.length < 2) return 0.0;
    
    double total = 0.0;
    for (int i = 0; i < routePoints.length - 1; i++) {
      final Distance distance = const Distance();
      total += distance.as(
        LengthUnit.Kilometer,
        routePoints[i].coordinates,
        routePoints[i + 1].coordinates,
      );
    }
    return total;
  }

  int get completedPoints {
    return routePoints.where((point) => point.isVisited).length;
  }

  double get progress {
    if (routePoints.isEmpty) return 0.0;
    return completedPoints / routePoints.length;
  }

  Trip copyWith({
    String? id,
    String? name,
    List<RoutePoint>? routePoints,
    DateTime? startTime,
    DateTime? endTime,
    bool? isActive,
    int? currentPointIndex,
    String? description,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      routePoints: routePoints ?? this.routePoints,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
      currentPointIndex: currentPointIndex ?? this.currentPointIndex,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'routePoints': routePoints.map((p) => p.toJson()).toList(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isActive': isActive,
      'currentPointIndex': currentPointIndex,
      'description': description,
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      name: json['name'],
      routePoints: (json['routePoints'] as List)
          .map((p) => RoutePoint.fromJson(p))
          .toList(),
      startTime: json['startTime'] != null 
          ? DateTime.parse(json['startTime']) 
          : null,
      endTime: json['endTime'] != null 
          ? DateTime.parse(json['endTime']) 
          : null,
      isActive: json['isActive'] ?? false,
      currentPointIndex: json['currentPointIndex'] ?? 0,
      description: json['description'],
    );
  }
}