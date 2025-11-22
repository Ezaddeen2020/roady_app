import 'package:fdelux_source_neytrip/common/app_colors.dart';
import 'package:fdelux_source_neytrip/common/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TripPlanningPage extends StatefulWidget {
  const TripPlanningPage({super.key});

  @override
  State<TripPlanningPage> createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> {
  final MapController _mapController = MapController();
  final TextEditingController _startPointController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  // State variables
  String _selectedCategory = 'Coffee';
  List<String> _stops = [];
  bool _isMapLoading = true;
  LatLng? _currentCenter;
  double _currentZoom = 12.0;

  // Map layer types
  String _selectedMapType = 'standard';
  bool _showTraffic = false;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.coffee, 'label': 'Coffee'},
    {'icon': Icons.restaurant, 'label': 'Lunch'},
    {'icon': Icons.content_cut, 'label': 'Hair'},
    {'icon': Icons.spa, 'label': 'Nails'},
    {'icon': Icons.shopping_bag, 'label': 'Shopping'},
  ];

  final List<String> _favorites = [
    'Arabica Café',
    'Matcha Lab DXB',
    'SALT Kite Beach',
  ];

  // Sample destinations with detailed route
  final List<Map<String, dynamic>> _destinations = [
    {
      'name': 'Matcha Lab DXB',
      'icon': Icons.coffee,
      'category': 'Coffee',
      'offset': [0.01, 0.01],
    },
    {
      'name': 'Arabica Café',
      'icon': Icons.local_cafe,
      'category': 'Coffee',
      'offset': [-0.008, 0.012],
    },
    {
      'name': 'The Restaurant',
      'icon': Icons.restaurant,
      'category': 'Lunch',
      'offset': [0.015, -0.005],
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() async {
    // Simulate getting user location
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      // Default to Dubai coordinates
      _currentCenter = LatLng(25.2048, 55.2708);
      _isMapLoading = false;
    });

    // Move map to center after initialization
    if (_currentCenter != null) {
      _mapController.move(_currentCenter!, _currentZoom);
    }
  }

  @override
  void dispose() {
    _startPointController.dispose();
    _destinationController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _onTapMarker(LatLng point, String placeName) {
    setState(() {
      _mapController.move(point, 15.0);
    });

    // Show place details
    _showPlaceDetails(placeName);
  }

  void _showPlaceDetails(String placeName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on,
                    color: AppColors.primary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    placeName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add to Route'),
            ),
          ],
        ),
      ),
    );
  }

  void _addStop() {
    setState(() {
      _stops.add('Stop ${_stops.length + 1}');
    });
  }

  void _removeStop(int index) {
    setState(() {
      _stops.removeAt(index);
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(2.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(2.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _centerToUserLocation() {
    if (_currentCenter != null) {
      setState(() {
        _mapController.move(_currentCenter!, 14.0);
      });
    }
  }

  void _toggleMapType() {
    setState(() {
      _selectedMapType =
          _selectedMapType == 'standard' ? 'satellite' : 'standard';
    });
  }

  // Generate smooth route points
  List<LatLng> _generateRoutePoints() {
    if (_currentCenter == null) return [];

    List<LatLng> points = [_currentCenter!];

    // Add intermediate points for smooth curves
    points.add(LatLng(
        _currentCenter!.latitude + 0.003, _currentCenter!.longitude + 0.002));
    points.add(LatLng(
        _currentCenter!.latitude + 0.006, _currentCenter!.longitude + 0.004));
    points.add(LatLng(
        _currentCenter!.latitude + 0.008, _currentCenter!.longitude + 0.007));
    points.add(LatLng(
        _currentCenter!.latitude + 0.01, _currentCenter!.longitude + 0.01));

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: const Text(
          'Roady',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Fields Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Start Point Field
                  _buildInputField(
                    controller: _startPointController,
                    hint: 'Start point',
                    icon: Icons.circle,
                    iconColor: AppColors.primary,
                    onTap: () {
                      // Open location picker
                    },
                  ),
                  const SizedBox(height: 12),

                  // Destination Field
                  _buildInputField(
                    controller: _destinationController,
                    hint: 'Destination',
                    icon: Icons.location_on,
                    iconColor: AppColors.failed,
                    onTap: () {
                      // Open location picker
                    },
                  ),

                  // Additional Stops
                  ..._stops.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: _buildStopField(entry.key, entry.value),
                    );
                  }).toList(),

                  const SizedBox(height: 12),

                  // Add Stop Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: _addStop,
                      icon: const Icon(Icons.add_circle_outline,
                          color: AppColors.primary, size: 20),
                      label: const Text(
                        'Add stop',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Enhanced Map Section with Controls
            Container(
              height: 320,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Map Widget
                    _isMapLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _currentCenter == null
                            ? Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Text('Unable to load map'),
                                ),
                              )
                            : FlutterMap(
                                mapController: _mapController,
                                options: MapOptions(
                                  keepAlive: true,
                                  initialCenter: _currentCenter!,
                                  minZoom: 2.0,
                                  maxZoom: 18.0,
                                  initialZoom: _currentZoom,
                                  interactionOptions: const InteractionOptions(
                                    flags: InteractiveFlag.all &
                                        ~InteractiveFlag.rotate,
                                  ),
                                ),
                                children: [
                                  // Tile Layer
                                  TileLayer(
                                    urlTemplate: _selectedMapType == 'standard'
                                        ? 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
                                        : 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                                    userAgentPackageName: AppConstants.appId,
                                  ),

                                  // Enhanced Route Line with shadow effect
                                  PolylineLayer(
                                    polylines: [
                                      // Shadow line
                                      Polyline(
                                        points: _generateRoutePoints(),
                                        strokeWidth: 8,
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      // Main route line
                                      Polyline(
                                        points: _generateRoutePoints(),
                                        strokeWidth: 5,
                                        color: AppColors.primary,
                                        borderStrokeWidth: 2,
                                        borderColor: Colors.white,
                                      ),
                                      // Animated dashed line overlay
                                      Polyline(
                                        points: _generateRoutePoints(),
                                        strokeWidth: 5,
                                        color: Colors.white.withOpacity(0.4),
                                        // isDotted: true,
                                      ),
                                    ],
                                  ),

                                  // Markers Layer
                                  MarkerLayer(
                                    markers: [
                                      // User Location Marker (Start Point)
                                      Marker(
                                        point: _currentCenter!,
                                        width: 50,
                                        height: 50,
                                        child: GestureDetector(
                                          onTap: () => _onTapMarker(
                                              _currentCenter!, 'Your Location'),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // Pulse effect
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.primary
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                              // Main marker
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 3),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 8,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'A',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Destination Markers
                                      ..._destinations
                                          .where((d) =>
                                              _selectedCategory == 'Coffee' ||
                                              d['category'] ==
                                                  _selectedCategory)
                                          .map((destination) {
                                        final point = LatLng(
                                          _currentCenter!.latitude +
                                              destination['offset'][0],
                                          _currentCenter!.longitude +
                                              destination['offset'][1],
                                        );
                                        return Marker(
                                          point: point,
                                          width: 120,
                                          height: 90,
                                          child: GestureDetector(
                                            onTap: () => _onTapMarker(
                                                point, destination['name']),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Marker icon with shadow
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.failed,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        blurRadius: 8,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Icon(
                                                    destination['icon'],
                                                    color: Colors.white,
                                                    size: 22,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                // Place name label
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.15),
                                                        blurRadius: 6,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text(
                                                    destination['name'],
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.textPrimary,
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

                    // Map Controls Overlay
                    if (!_isMapLoading && _currentCenter != null)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Column(
                          children: [
                            // Map Type Toggle
                            _buildMapControl(
                              icon: Icons.layers,
                              onTap: _toggleMapType,
                              tooltip: 'Map Type',
                            ),
                            const SizedBox(height: 8),
                            // Zoom In
                            _buildMapControl(
                              icon: Icons.add,
                              onTap: _zoomIn,
                              tooltip: 'Zoom In',
                            ),
                            const SizedBox(height: 8),
                            // Zoom Out
                            _buildMapControl(
                              icon: Icons.remove,
                              onTap: _zoomOut,
                              tooltip: 'Zoom Out',
                            ),
                          ],
                        ),
                      ),

                    // Center to User Location Button
                    if (!_isMapLoading && _currentCenter != null)
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: _buildMapControl(
                          icon: Icons.my_location,
                          onTap: _centerToUserLocation,
                          tooltip: 'My Location',
                          backgroundColor: AppColors.primary,
                          iconColor: Colors.white,
                        ),
                      ),

                    // Distance and Time Info
                    if (!_isMapLoading && _currentCenter != null)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.directions_car,
                                  size: 18, color: AppColors.primary),
                              const SizedBox(width: 6),
                              const Text(
                                '2.5 km • 8 min',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter by category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected =
                            _selectedCategory == category['label'];

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            selected: isSelected,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  category['icon'],
                                  size: 18,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(category['label']),
                              ],
                            ),
                            onSelected: (selected) =>
                                _onCategorySelected(category['label']),
                            backgroundColor: Colors.white,
                            selectedColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color:
                                  isSelected ? Colors.white : AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            side: BorderSide(
                              color:
                                  isSelected ? AppColors.primary : AppColors.divider,
                              width: 1.5,
                            ),
                            elevation: isSelected ? 2 : 0,
                            shadowColor: AppColors.primary.withOpacity(0.3),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Your Favorites Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Your Favorites ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('💛', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _favorites.map((favorite) {
                      return InkWell(
                        onTap: () {
                          // Navigate to favorite location
                        },
                        child: Chip(
                          avatar: const Icon(Icons.star,
                              size: 16, color: Colors.amber),
                          label: Text(favorite),
                          backgroundColor: Colors.grey[100],
                          side: BorderSide(color: Colors.grey[300]!),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Featured Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink[50]!, Colors.pink[100]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink[200]!, width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('⭐', style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Featured: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  'Dolcetto Café – Try our new pistachio matcha!',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControl({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    Color backgroundColor = Colors.white,
    Color iconColor = AppColors.textPrimary,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: onTap != null,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(icon, color: iconColor, size: 22),
          suffixIcon: const Icon(Icons.search, color: AppColors.textThin, size: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildStopField(int index, String stopName) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: stopName,
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.location_on,
                    color: Colors.orange, size: 22),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
            onPressed: () => _removeStop(index),
          ),
        ],
      ),
    );
  }
}
