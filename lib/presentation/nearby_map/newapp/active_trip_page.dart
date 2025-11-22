import 'package:fdelux_source_neytrip/common/app_colors.dart';
import 'package:fdelux_source_neytrip/common/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

import 'model/route_point.dart';
import 'model/trip.dart';

class ActiveTripPage extends StatefulWidget {
  final Trip trip;

  const ActiveTripPage({
    super.key,
    required this.trip,
  });

  @override
  State<ActiveTripPage> createState() => _ActiveTripPageState();
}

class _ActiveTripPageState extends State<ActiveTripPage> {
  final MapController _mapController = MapController();
  late Trip _currentTrip;
  LatLng? _userCurrentLocation;
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    _currentTrip = widget.trip;
    _initializeTracking();
  }

  void _initializeTracking() async {
    // Simulate getting user location
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _userCurrentLocation = _currentTrip.routePoints.first.coordinates;
      _isTracking = true;
    });

    if (_userCurrentLocation != null) {
      _mapController.move(_userCurrentLocation!, 14.0);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _checkInAtPoint(RoutePoint point) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.teal, size: 28),
            SizedBox(width: 12),
            Text('Check In'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check in at ${point.name}?',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a note (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
              onChanged: (value) {
                // Store note
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _markPointAsVisited(point);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Check In'),
          ),
        ],
      ),
    );
  }

  void _markPointAsVisited(RoutePoint point) {
    setState(() {
      final index = _currentTrip.routePoints.indexOf(point);
      if (index != -1) {
        final updatedPoint = point.copyWith(
          isVisited: true,
          arrivalTime: DateTime.now(),
        );
        final updatedPoints = List<RoutePoint>.from(_currentTrip.routePoints);
        updatedPoints[index] = updatedPoint;

        _currentTrip = _currentTrip.copyWith(
          routePoints: updatedPoints,
          currentPointIndex: index + 1,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('Checked in at ${point.name}'),
          ],
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _endTrip() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('End Trip'),
        content: const Text('Are you sure you want to end this trip?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final endedTrip = _currentTrip.copyWith(
                isActive: false,
                endTime: DateTime.now(),
              );
              Navigator.pop(context); // Close dialog
              Navigator.pop(context,
                  endedTrip); // Return to previous page with ended trip
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('End Trip'),
          ),
        ],
      ),
    );
  }

  List<LatLng> _generateRoutePoints() {
    return _currentTrip.routePoints.map((p) => p.coordinates).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentPoint = _currentTrip.currentPoint;
    final nextPoint = _currentTrip.nextPoint;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, _currentTrip),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentTrip.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Active Trip',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop_circle, color: Colors.red),
            onPressed: _endTrip,
            tooltip: 'End Trip',
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress: ${_currentTrip.completedPoints}/${_currentTrip.routePoints.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${(_currentTrip.progress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _currentTrip.progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                ),
              ],
            ),
          ),

          // Map
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _userCurrentLocation ??
                        _currentTrip.routePoints.first.coordinates,
                    initialZoom: 13.0,
                    minZoom: 2.0,
                    maxZoom: 18.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: AppConstants.appId,
                    ),

                    // Route Line
                    PolylineLayer(
                      polylines: [
                        // Shadow
                        Polyline(
                          points: _generateRoutePoints(),
                          strokeWidth: 8,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        // Main route
                        Polyline(
                          points: _generateRoutePoints(),
                          strokeWidth: 5,
                          color: Colors.teal,
                          borderStrokeWidth: 2,
                          borderColor: Colors.white,
                        ),
                      ],
                    ),

                    // Markers
                    MarkerLayer(
                      markers: [
                        // User current location
                        if (_userCurrentLocation != null)
                          Marker(
                            point: _userCurrentLocation!,
                            width: 50,
                            height: 50,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.2),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Route points
                        ..._currentTrip.routePoints.map((point) {
                          final index = _currentTrip.routePoints.indexOf(point);
                          final isVisited = point.isVisited;
                          final isCurrent =
                              index == _currentTrip.currentPointIndex;

                          return Marker(
                            point: point.coordinates,
                            width: 100,
                            height: 90,
                            child: GestureDetector(
                              onTap: () {
                                if (!isVisited && isCurrent) {
                                  _checkInAtPoint(point);
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isVisited
                                          ? Colors.green
                                          : isCurrent
                                              ? Colors.orange
                                              : Colors.grey[400],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      isVisited
                                          ? Icons.check
                                          : Icons.location_on,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      point.name,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: isVisited
                                            ? Colors.green
                                            : Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),

                // Current Location Button
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (_userCurrentLocation != null) {
                        _mapController.move(_userCurrentLocation!, 14.0);
                      }
                    },
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.my_location, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentPoint != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.orange,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current Stop',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              currentPoint.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (currentPoint.address != null)
                              Text(
                                currentPoint.address!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!currentPoint.isVisited)
                    ElevatedButton(
                      onPressed: () => _checkInAtPoint(currentPoint),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Check In Here',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (nextPoint != null && currentPoint.isVisited) ...[
                    const Divider(height: 32),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward,
                            color: Colors.grey, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Next Stop',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                nextPoint.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ] else ...[
                  const Icon(Icons.celebration, color: Colors.teal, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Trip Completed!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You visited all ${_currentTrip.routePoints.length} locations',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _endTrip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Finish Trip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
