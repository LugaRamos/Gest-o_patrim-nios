import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-23.5505, -46.6333);
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('patrimonio'),
        position: LatLng(-23.5505, -46.6333),
        infoWindow: InfoWindow(
          title: 'Patrimônio 1',
          snippet: 'Descrição do Patrimônio',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMarkers,
        child: Icon(Icons.add_location),
      ),
    );
  }
}
