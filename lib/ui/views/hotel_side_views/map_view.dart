// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_search_textfield.dart';
import 'package:geocoding/geocoding.dart';

class MapView extends StatefulWidget {
  final Function(String, String, String) onLocationSelected;

  const MapView({required this.onLocationSelected});
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  BitmapDescriptor? customIcon;
  Set<Marker>? markers;
  GoogleMapController? mapController;
  final TextEditingController _searchController = TextEditingController();
  MarkerId defaultMarkerId = MarkerId('default');

  @override
  void initState() {
    super.initState();
      markers = {
        Marker(
            markerId: defaultMarkerId,
            position: LatLng(28.383406363992062, 41.31760530173779),
            draggable: true, // Allow the marker to be moved
            onDragEnd: (newPosition) {
              _updateMarker(newPosition);
            })
      };
    }

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    var latLng = null;
    void _searchLocation() async {
      final query = _searchController.text;
      if (query.isNotEmpty) {
        try {
          final locations = await locationFromAddress(query);
          if (locations.isNotEmpty) {
            latLng = LatLng(locations.first.latitude, locations.first.longitude);
            mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 18));
            _updateMarker(latLng);
          } else {
            Fluttertoast.showToast(
              msg: "No results found for the supplied address",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Error occurred: $e",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Please enter a location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
    }
  }

  void _ConfirmLocation(LatLng newPosition) async {
    try {
      final placemarks = await placemarkFromCoordinates(
          newPosition.latitude, newPosition.longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        print('Latitude: ${newPosition.latitude}');
        print('Longitude: ${newPosition.longitude}');
        print('City: ${placemark.locality}');
        print('Address: ${placemark.street}');
        print('Country: ${placemark.country}');

        Navigator.pop(context);
        if (widget.onLocationSelected != null) {
          widget.onLocationSelected(
              placemark.locality!, placemark.street!, placemark.country!);
        }
      } else {
        Fluttertoast.showToast(
          msg: "No results found for the supplied coordinates",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void _updateMarker(LatLng newPosition) async {
    final placemarks = await placemarkFromCoordinates(
        newPosition.latitude, newPosition.longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      setState(() {
        markers!.removeWhere((m) => m.markerId == defaultMarkerId);
        markers!.add(
          Marker(
            markerId: defaultMarkerId,
            position: newPosition,
            draggable: true,
            onDragEnd: (newPosition) => _updateMarker(newPosition),
            infoWindow: InfoWindow(
              title:
                  '${_searchController.text.capitalizeFirst}, ${placemark.street}, ${placemark.locality}',
              snippet: '${placemark.country}',
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Expanded(
          child:
          GoogleMap(
            markers: markers!,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
                target: LatLng(28.383406363992062, 41.31760530173779),
                zoom: 1),
          ),
           ),
          Positioned(
            top: 50,
            left: 8,
            right: 8,
            child: SizedBox(
              height: 45,
              width: size.width - 30,
              child:
           TextField(

            controller: _searchController,
            onSubmitted: (value) => _searchLocation(),
            textAlignVertical: TextAlignVertical.bottom,
            decoration: searchTextFielDecoratiom.copyWith(
              hintText: "Search",
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.grayText,
              ),
            ),
          ),
          ),
            ),
          Positioned(
            bottom: 15,
            left: size.width / 4,
            child: InkWell(
                onTap: () {
                  if (latLng != null) {
                    _ConfirmLocation(latLng);
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please search for a location first",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
                child: CustomButton(
                  text: 'Confirm location',
                  textColor: AppColors.backgroundgrayColor,
                  backgroundColor: AppColors.purple,
                  widthPercent: size.width / 2,
                  heightPercent: 15,
                ),
                ),
          ),
        ],
      ),
    );
  }
}
