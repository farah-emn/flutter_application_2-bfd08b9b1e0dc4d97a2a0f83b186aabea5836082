// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, avoid_print, deprecated_member_use, prefer_final_fields, unnecessary_overrides

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_rountrip.dart';

class SearchViewRoundTripController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().obs;
  Rx<DateTime> ReturnDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
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

  Future<void> searchForFlights() async {
    String formattedDepartureDate = getFormattedDepartureDate();
    String formattedReturnDate = getFormattedReturnDate();
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    ref.child('flights').once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var flightsData =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        Map<dynamic, dynamic> filteredDepartureFlightsData = {};
        Map<dynamic, dynamic> filteredArrivalFlightsData = {};

        flightsData.forEach((key, value) {
          var flightData = Map<dynamic, dynamic>.from(value);
          //
          bool seatPassengersAdultCondition =
              flightData['Available_seat_passengers_Adult'] >= Adultcounter;
          bool seatPassengersChildrenCondition = Childcounter == 0 ||
              flightData['Available_seat_passengers_children'] >= Childcounter;
          //
          bool dateAndCityConditions =
              flightData['DeparureDate'] == formattedDepartureDate &&
                  flightData['ArrivalCity'] == _ArrivalCity.value &&
                  flightData['DeparureCity'] == _DepartureCity.value;
          //

          if (seatPassengersAdultCondition &&
              seatPassengersChildrenCondition &&
              dateAndCityConditions) {
            flightsData.forEach((key1, value1) {
              var returnFlightData = Map<dynamic, dynamic>.from(value1);
              bool dateAndCityConditionsReturn =
                  returnFlightData['DeparureDate'] == formattedReturnDate &&
                      returnFlightData['ArrivalCity'] == _DepartureCity.value &&
                      returnFlightData['DeparureCity'] == _ArrivalCity.value;
              //
              bool seatPassengersAdultCondition =
                  flightData['Available_seat_passengers_Adult'] >= Adultcounter;
              //
              bool seatPassengersChildrenCondition = Childcounter == 0 ||
                  flightData['Available_seat_passengers_children'] >=
                      Childcounter;

              if (dateAndCityConditionsReturn &&
                  flightData['DeparureCity'] ==
                      returnFlightData['ArrivalCity'] &&
                  flightData['ArrivalCity'] ==
                      returnFlightData['DeparureCity'] &&
                  seatPassengersAdultCondition &&
                  seatPassengersChildrenCondition) {
                if (filteredDepartureFlightsData[key] ==
                    filteredArrivalFlightsData[key1]) {
                  filteredDepartureFlightsData[key] = flightData;
                  filteredArrivalFlightsData[key1] = returnFlightData;
                  totalflightprice = flightData['ticket_price'] +
                      returnFlightData['ticket_price'];
                }
              }
            });
          }
        });

        if (filteredDepartureFlightsData.isNotEmpty &&
            filteredArrivalFlightsData.isNotEmpty) {
          Get.to(() => FlightsViewRound(
              DepartureflightData: filteredDepartureFlightsData,
              ReturnflightData: filteredArrivalFlightsData));
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
    update();
  }
}
