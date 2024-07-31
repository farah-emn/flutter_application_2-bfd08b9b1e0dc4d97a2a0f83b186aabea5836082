import 'package:flutter/material.dart';

class AmenitiesClass1 {
  IconData icon;
  String title;

  AmenitiesClass1({required this.icon, required this.title});
}

List<AmenitiesClass1> Amenities = [
  AmenitiesClass1(icon: Icons.wifi_rounded, title: 'Wi_Fi'),
  AmenitiesClass1(icon: Icons.bed, title: 'Dobule bed'),
  AmenitiesClass1(icon: Icons.pool_rounded, title: 'Internet'),
  AmenitiesClass1(icon: Icons.coffee, title: 'BreakFast'),
  AmenitiesClass1(icon: Icons.ac_unit_rounded, title: 'Ac'),
];
