import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  bool _isLoading = true;
  String _locationStatus = "Getting location...";

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addSampleNGOMarkers();
  }

  void _addSampleNGOMarkers() {
    setState(() {
      _markers.addAll({
        const Marker(
          markerId: MarkerId('ngo1'),
          position: LatLng(18.5204, 73.8567), // Pune
          infoWindow: InfoWindow(
            title: 'Food for All NGO',
            snippet: 'Available for pickup 9 AM - 6 PM',
          ),
          // Using default marker - will appear as red pin
        ),
        const Marker(
          markerId: MarkerId('ngo2'),
          position: LatLng(18.5314, 73.8446), // Another location in Pune
          infoWindow: InfoWindow(
            title: 'Hope Foundation',
            snippet: 'Accepting donations 24/7',
          ),
          // Using default marker - will appear as red pin
        ),
        const Marker(
          markerId: MarkerId('ngo3'),
          position: LatLng(18.5074, 73.8677),
          infoWindow: InfoWindow(
            title: 'Helping Hands',
            snippet: 'Specializes in cooked food pickup',
          ),
          // Using default marker - will appear as red pin
        ),
      });
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationStatus = "Location services are disabled";
          _isLoading = false;
        });
        _showLocationServiceDialog();
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationStatus = "Location permissions denied";
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationStatus = "Location permissions permanently denied";
          _isLoading = false;
        });
        _showPermissionDialog();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
        _locationStatus = "Location found";
      });

      // Add current location marker
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentLocation!,
            infoWindow: const InfoWindow(
              title: 'Your Location',
              snippet: 'Current position',
            ),
            // Using default red marker for current location
          ),
        );
      });

    } catch (e) {
      setState(() {
        _locationStatus = "Error getting location: $e";
        _isLoading = false;
      });
    }
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
            'Please enable location services to view the map and find nearby NGOs.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'This app needs location permission to show nearby NGOs and pickup points. Please grant permission in app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _goToCurrentLocation() {
    if (_controller != null && _currentLocation != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation!, 15),
      );
    }
  }

  void _refreshLocation() {
    setState(() {
      _isLoading = true;
      _locationStatus = "Refreshing location...";
    });
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainBg = Color(0xFFEFDBF6);
    const Color textColor = Color(0xFF5C2C9C);

    return Scaffold(
      backgroundColor: mainBg,
      appBar: AppBar(
        backgroundColor: mainBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'WasteNot Map',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: textColor),
            onPressed: _refreshLocation,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    _locationStatus,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : _currentLocation == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_off,
                        size: 64,
                        color: textColor.withOpacity(0.6),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _locationStatus,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshLocation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textColor,
                        ),
                        child: const Text(
                          'Retry Location',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 14.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false, // We'll use our custom button
                  markers: _markers,
                  mapType: MapType.normal,
                  compassEnabled: true,
                  trafficEnabled: false,
                  buildingsEnabled: true,
                  onTap: (LatLng position) {
                    // Handle map tap if needed
                    print('Map tapped at: ${position.latitude}, ${position.longitude}');
                  },
                ),
      floatingActionButton: _currentLocation == null
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "location_fab",
                  onPressed: _goToCurrentLocation,
                  backgroundColor: textColor,
                  child: const Icon(Icons.my_location, color: Colors.white),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "refresh_fab",
                  onPressed: _refreshLocation,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.refresh, color: textColor),
                ),
              ],
            ),
      bottomSheet: _currentLocation != null
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearby NGOs & Pickup Points',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap on markers to see details and contact information',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('Your Location  ', style: TextStyle(fontSize: 12)),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('NGOs & Pickup Points', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}