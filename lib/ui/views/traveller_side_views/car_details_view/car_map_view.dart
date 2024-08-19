import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarMapView extends StatefulWidget {
  String Location;
  CarMapView({required this.Location});
  @override
  _CarMapViewState createState() => _CarMapViewState();
}

class _CarMapViewState extends State<CarMapView> {
  GoogleMapController? mapController;
  LatLng _center = LatLng(0, 0);
  Set<Marker> _markers = {};
  MarkerId? markerId;

  @override
  void initState() {
    super.initState();
    _getLatLngFromAddress('${widget.Location}');
    print('ttyyyyy');
  }

  void _getLatLngFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    markerId = MarkerId(address);

    setState(() {
      _center = LatLng(30.0385, 31.2278);
      _markers.add(
        Marker(
          markerId: markerId!,
          position: _center,
          infoWindow: InfoWindow(
            title: address,
          ),
        ),
      );
      if (mapController != null) {
        mapController!.animateCamera(CameraUpdate.newLatLngZoom(_center, 18));
        Future.delayed(Duration(seconds: 1), () {
          mapController!.showMarkerInfoWindow(markerId!); // Add delay here
          ;
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_center.latitude != 0 && _center.longitude != 0) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(_center, 50));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
          target: LatLng(28.383406363992062, 41.31760530173779), zoom: 1),
      markers: _markers,
    );
  }
}
