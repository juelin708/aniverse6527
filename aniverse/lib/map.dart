import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aniverse/service/animal_service.dart';
import 'package:aniverse/entity/animal_dto.dart';
import 'package:aniverse/various_animals.dart';

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
  final List<Marker> _markers = [];
  late Future<List<Animal>> _animalsFuture;

  @override
  void initState() {
    super.initState();
    _animalsFuture = AnimalService().getAnimals();
    _populateMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _populateMarkers() async {
    final animals = await _animalsFuture;
    for (final animal in animals) {
      final coordinates = animal.location.split(' ,');
      final double latitude = double.parse(coordinates[0]);
      final double longitude = double.parse(coordinates[1]);
      final LatLng animalLocation = LatLng(latitude, longitude);

      final marker = Marker(
        markerId: MarkerId(animal.id.toString()),
        position: animalLocation,
        icon: await _createMarkerImageFromUrl(animal.imageUrl ?? ''),
        infoWindow: InfoWindow(
          title: animal.animalname,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimalDetailPage(name: animal.animalname),
              ),
            );
          },
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    }
  }

  Future<BitmapDescriptor> _createMarkerImageFromUrl(String url) async {
    final ImageConfiguration imageConfiguration =
        ImageConfiguration(size: Size(48, 48));
    BitmapDescriptor bitmapImage =
        await BitmapDescriptor.fromAssetImage(imageConfiguration, url);
    return bitmapImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Flutter'),
        backgroundColor: Colors.green[700],
      ),
      body: FutureBuilder<List<Animal>>(
        future: _animalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13.0,
              ),
              markers: Set<Marker>.of(_markers),
            );
          }
        },
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

/*
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
*/
