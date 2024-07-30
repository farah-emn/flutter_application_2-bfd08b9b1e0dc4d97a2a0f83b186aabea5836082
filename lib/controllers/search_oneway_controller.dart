// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_final_fields, avoid_print, deprecated_member_use, unnecessary_overrides

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_oneway.dart';

class SearchViewOneWayController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().obs;
  Rx<DateTime> ReturnDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  int _Adultcounter = 1;
  int _Childcounter = 0;
  int get Adultcounter => _Adultcounter;
  int get Childcounter => _Childcounter;
  var _DepartureCity = ''.obs;
  var _ArrivalCity = ''.obs;
  get DepartureCity => _DepartureCity;
  double totalpriceflight = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void setArrivalCity(String city) {
    _ArrivalCity.value = city;
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

  void setDepartureCity(String city) {
    _DepartureCity.value = city;
  }

  Future<void> searchForFlights() async {
    String formattedDepartureDate = getFormattedDepartureDate();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('flights').once().then((DatabaseEvent event) {
      print('sssssssssssss');
      if (event.snapshot.exists) {
        print('aaaaaaaaaaaaaa');
        var flightsData =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        Map<dynamic, dynamic> filteredFlightsData = {};
        flightsData.forEach((key, value) {
          var FlightData = Map<dynamic, dynamic>.from(value);
          //
          bool seat_passengers_Adult_Condition =
              FlightData['Available_seat_passengers_Adult'] >= Adultcounter;
          //
          bool seat_passengers_Children_Condition = Childcounter == 0 ||
              FlightData['Available_seat_passengers_children'] >= Childcounter;
          //
          bool DateAndCityConditions =
              FlightData['DeparureDate'] == formattedDepartureDate &&
                  FlightData['ArrivalCity'] == _ArrivalCity.value &&
                  FlightData['DeparureCity'] == _DepartureCity.value;
          //
          if (seat_passengers_Adult_Condition &&
              seat_passengers_Children_Condition &&
              DateAndCityConditions) {
            filteredFlightsData[key] = FlightData;
            totalpriceflight = FlightData['ticket_price'];
          }
        });
        if (filteredFlightsData.isNotEmpty) {
          Get.to(() => FlightsView(flightData: filteredFlightsData));
        } else {
          Fluttertoast.showToast(
              msg: "No flights found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
  }

  void clearData() {
    departureDate.value = DateTime.now();
    ReturnDate.value = DateTime.now();
    selectedDate.value = '${DateTime.now().month}/${DateTime.now().day}';
    _Adultcounter = 1;
    _Childcounter = 0;
    _DepartureCity.value = '';
    _ArrivalCity.value = '';
    totalpriceflight = 0;
    update();
  }
}
