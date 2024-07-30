import 'package:flutter/material.dart';

class AmenitiesClass {
  IconData icon;
  String title;

  AmenitiesClass({required this.icon, required this.title});
}

List<AmenitiesClass> Amenities = [
  AmenitiesClass(icon: Icons.wifi_rounded, title: 'Wi_Fi'),
  AmenitiesClass(icon: Icons.bed, title: 'Dobule bed'),
  AmenitiesClass(icon: Icons.pool_rounded, title: 'Internet'),
  AmenitiesClass(icon: Icons.coffee, title: 'BreakFast'),
  AmenitiesClass(icon: Icons.ac_unit_rounded, title: 'Ac'),
];
