// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_final_fields, avoid_print, deprecated_member_use, unnecessary_overrides, unused_import

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FlightAddController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().obs;
  Rx<DateTime> ReturnDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  DateTime? newDepartureDate;
  DateTime? newReturnDate;

  int _Adultcounter = 1;
  int _Childcounter = 0;
  var _DepartureCity = ''.obs;
  var _ArrivalCity = ''.obs;
  get DepartureCity => _DepartureCity;
  int get Adultcounter => _Adultcounter;
  int get Childcounter => _Childcounter;
  double totalflightprice = 0;
  @override
  void onInit() {
    super.onInit();
  }

  void setDepartureCity(String city) {
    _DepartureCity.value = city;
    print('Departure City set to: ${_DepartureCity.value}');
  }

  void setArrivalCity(String city) {
    _ArrivalCity.value = city;
    print('Arrival City set to: ${_ArrivalCity.value}');
  }

  void incrementAdult() {
    _Adultcounter++;
    update();
  }

  void decrementAdult() {
    if (Adultcounter > 1) {
      _Adultcounter--;
      update();
    }
  }

  void incrementChild() {
    _Childcounter++;
    update();
  }

  void decrementChild() {
    if (Childcounter > 0) {
      _Childcounter--;
      update();
    }
  }

  void updateSelectedDate() {
    selectedDate.value =
        '${DateTime.now().day}. ${DateTime.now().month}, ${DateTime.now().year}';
  }

  String getFormattedDepartureDate() {
    return _formatDate(departureDate.value);
  }

  String _formatDate(DateTime date) {
    return '${date.day}. ${date.month}, ${date.year}';
  }

  String getFormattedReturnDate() {
    return _formatDate(ReturnDate.value);
  }

  void clearData() {
    departureDate.value = DateTime.now();
    ReturnDate.value = DateTime.now();
    selectedDate.value = '${DateTime.now().month}/${DateTime.now().day}';

    update();
  }
}
