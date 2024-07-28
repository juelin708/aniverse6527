import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*void main() => runApp(const MyApp());*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(1.309187723985679, 103.77357859089092);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Flutter'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  final String location;

  const MapPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> coordinates = location.split(',');
    final double latitude = double.parse(coordinates[0]);
    final double longitude = double.parse(coordinates[1]);
    final LatLng animalLocation = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(title: const Text('Animal Location')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: animalLocation,
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('animalLocation'),
            position: animalLocation,
          ),
        },
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        mapToolbarEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          // Additional map initialization if needed
        },
        padding: EdgeInsets.only(top: 50.0),
      ),
    );
  }
}
