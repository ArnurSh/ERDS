import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng _initialPosition = const LatLng(51.1694, 71.4491); // Астана
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _setMarkers();
  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _initialPosition = LatLng(pos.latitude, pos.longitude);
      });
    }
  }

  void _setMarkers() {
    _markers = {
      const Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(51.1694, 71.4491),
        infoWindow: InfoWindow(title: 'Astana Center'),
      ),
      const Marker(
        markerId: MarkerId('marker2'),
        position: LatLng(51.1285, 71.4304),
        infoWindow: InfoWindow(title: 'Astana Mall'),
      ),
      const Marker(
        markerId: MarkerId('marker3'),
        position: LatLng(51.1605, 71.4704),
        infoWindow: InfoWindow(title: 'Astana Park'),
      ),
    };
  }

  void _zoomIn() {
    _controller?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _controller?.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map Example')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        markers: _markers,
        myLocationEnabled: true,
        onMapCreated: (controller) => _controller = controller,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomIn',
            onPressed: _zoomIn,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'zoomOut',
            onPressed: _zoomOut,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
