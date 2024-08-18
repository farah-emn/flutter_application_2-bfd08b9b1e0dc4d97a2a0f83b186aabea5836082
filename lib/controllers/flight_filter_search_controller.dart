// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, avoid_function_literals_in_foreach_calls, unrelated_type_equality_checks, invalid_use_of_visible_for_testing_member

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/flight_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';

class FlightSearchController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CurrencyController flightCurrencyController =
      Get.find<CurrencyController>();
  RxMap<dynamic, dynamic> filteredFlightsData = <dynamic, dynamic>{}.obs;
  ValueNotifier<List<FlightDetailsClass>> flightsList =
      ValueNotifier<List<FlightDetailsClass>>([]);
  RxInt NumberOfResultFilteredflights = 0.obs;
  var lastFlightKey = ''.obs;
  var filteredEntries;
  User? airlineCompany;
  String airlineCompanyId = '';
  String airlineCompanyName = '';
  var sorteBy = ''.obs;
  var uid;
  var currentUser;
  var isCheckedDirect = false.obs;
  var isCheckedIndirect = false.obs;
  var currentRangeValues = RangeValues(0, 0).obs;
  var isloading = false.obs;
  FlightSearchController() {
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    airlineCompany = _auth.currentUser;
    airlineCompanyId = airlineCompany?.uid.toString() ?? '';
    getData();
  }
  void getData() async {
    try {
      final event = await FirebaseDatabase.instance
          .ref('Airline_company')
          .child(uid)
          .get();
      final airlineCompanyData = Map<dynamic, dynamic>.from(event.value as Map);
      airlineCompanyName = airlineCompanyData['AirlineCompanyName'];
      isloading.value = true;
      isloading.value = true;

      await fetchFlights();
      await fetchStoplocationsFlights();
      updateFlightsList();
    } catch (e) {}
  }

  Future<void> fetchFlights() async {
    var event =
        await FirebaseDatabase.instance.reference().child('Flight').once();
    if (event.snapshot.exists) {
      var flightsData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      lastFlightKey.value = flightsData.keys.last;

      for (var key in flightsData.keys) {
        var FlightData = Map<dynamic, dynamic>.from(flightsData[key]);
        if (FlightData['AirlinId'] == airlineCompanyId) {
          var stopLocationEvent = await FirebaseDatabase.instance
              .reference()
              .child('Stop_location')
              .once();
          var stopLocationData = Map<String, dynamic>.from(
              stopLocationEvent.snapshot.value as Map);
          int stopCount = 0; // Initialize stop count

          stopLocationData.forEach((Stopkey, value) {
            if (value['FlighID'] == key) {
              stopCount++; // Increment stop count for each matching flight ID
            }
          });

          var airportEvent = await FirebaseDatabase.instance
              .reference()
              .child('Airport')
              .once();
          var AirportData =
              Map<dynamic, dynamic>.from(airportEvent.snapshot.value as Map);

          var planeEvent =
              await FirebaseDatabase.instance.reference().child('Plane').once();
          var PlaneData =
              Map<dynamic, dynamic>.from(planeEvent.snapshot.value as Map);

          filteredFlightsData[key] = FlightData;
          filteredFlightsData[key]['FlightType'] =
              stopCount > 0 ? "$stopCount Stop" : "Direct";

          AirportData.forEach((AirportDatakey, AirportData) {
            if (AirportDatakey == flightsData[key]['DepartureAirportID']) {
              AirportData.forEach((departureAirportCode, departureAirportData) {
                filteredFlightsData[key]['DepartureAirportName'] =
                    departureAirportData['AirportName'];
                filteredFlightsData[key]['DepartureLocation'] =
                    departureAirportData['Location'];
              });
            }
            if (AirportDatakey == flightsData[key]['ArrivalAirportID']) {
              AirportData.forEach((ArrivalAirportCode, ArrivalAirportData) {
                var ArrivalAirportName = ArrivalAirportData['AirportName'];
                filteredFlightsData[key]['ArrivalAirportName'] =
                    ArrivalAirportName;
                filteredFlightsData[key]['ArrivalLocation'] =
                    ArrivalAirportData['Location'];
              });
            }
          });

          PlaneData.forEach((PlaneDatakey, Planedata) {
            if (PlaneDatakey == flightsData[key]['PlaneId']) {
              Planedata.forEach((PlaneCode, PlaneData) {
                filteredFlightsData[key]['PlaneID'] = PlaneCode;
                filteredFlightsData[key]['PlaneManufacturer'] =
                    PlaneData['Manufacturer'];
                filteredFlightsData[key]['PlaneModel'] = PlaneData['Model'];
              });
            }
          });
        }
      }
    }
    isloading.value = false;
  }

  var stopDurationsForFlight = [];
  var stopLocationsForFlight = [];
  Future<void> fetchStoplocationsFlights() async {
    stopDurationsForFlight.clear();
    stopLocationsForFlight.clear();
    var event = await FirebaseDatabase.instance
        .reference()
        .child('Stop_location')
        .once();
    if (event.snapshot.exists) {
      var stopLocationData =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      stopLocationData.forEach((Stopkey, value) {
        filteredFlightsData.entries.forEach((entry) {
          if (value['FlighID'] == entry.key) {
            stopDurationsForFlight.add(value['StopDuration']);
            stopLocationsForFlight.add(value['StopLocation']);
          }
        });
      });

      flightsList.value = filteredFlightsData.entries.map((entry) {
        return FlightDetailsClass.fromMap({
          "FlightID": entry.key,
          'DeparureDate': entry.value['DepartureDate'],
          'ArrivalDate': entry.value['ArrivalDate'],
          'DeparureTime': entry.value['DepartureTime'].toString(),
          'ArrivalTime': entry.value['ArrivalTime'].toString(),
          "Flight_Duration": entry.value['FlightDuration'],
          'DepartureAirport': entry.value['DepartureAirportName'],
          'ArrivalAirport': entry.value['ArrivalAirportName'],
          "TicketAdultEconomyPrice":
              entry.value['TicketAdultEconomyPrice'].toDouble(),
          "deparure_from": entry.value['DepartureLocation'],
          "deparure_to": entry.value['ArrivalLocation'],
          "NumberOfEconomySeats": entry.value['NumberOfEconomySeats'],
          "NumberOfFirstClassSeats": entry.value["NumberOfFirstClassSeats"],
          "TicketAdultFirstClassPrice":
              entry.value["TicketAdultFirstClassPrice"].toDouble(),
          "TicketChildEconomyPrice":
              entry.value["TicketChildEconomyPrice"].toDouble(),
          "TicketChildFirstClassPrice":
              entry.value["TicketChildFirstClassPrice"].toDouble(),
          "PlaneId": entry.value["PlaneID"],
          "PlaneManufacturer": entry.value["PlaneManufacturer"],
          "PlaneModel": entry.value["PlaneModel"],
          "FlightType": entry.value["FlightType"],
        });
      }).toList();
    }
    if (flightsList.value.isNotEmpty && lastFlightKey.value != '') {
      isloading.value = false;
    }
    print('fffffffffffffffffff');
    print(flightsList.value.length);
  }

  void updateFlightsList() {
    flightsList.value = filteredFlightsData.entries.map((entry) {
      return FlightDetailsClass.fromMap({
        "FlightID": entry.key,
        'DeparureDate': entry.value['DepartureDate'],
        'ArrivalDate': entry.value['ArrivalDate'],
        'DeparureTime': entry.value['DepartureTime'].toString(),
        'ArrivalTime': entry.value['ArrivalTime'].toString(),
        "Flight_Duration": entry.value['FlightDuration'],
        'DepartureAirport': entry.value['DepartureAirportName'],
        'ArrivalAirport': entry.value['ArrivalAirportName'],
        "TicketAdultEconomyPrice":
            entry.value['TicketAdultEconomyPrice'].toDouble(),
        "deparure_from": entry.value['DepartureLocation'],
        "deparure_to": entry.value['ArrivalLocation'],
        "NumberOfEconomySeats": entry.value['NumberOfEconomySeats'],
        "NumberOfFirstClassSeats": entry.value["NumberOfFirstClassSeats"],
        "TicketAdultFirstClassPrice":
            entry.value["TicketAdultFirstClassPrice"].toDouble(),
        "TicketChildEconomyPrice":
            entry.value["TicketChildEconomyPrice"].toDouble(),
        "TicketChildFirstClassPrice":
            entry.value["TicketChildFirstClassPrice"].toDouble(),
        "PlaneId": entry.value["PlaneID"],
        "PlaneManufacturer": entry.value["PlaneManufacturer"],
        "PlaneModel": entry.value["PlaneModel"],
        "FlightType": entry.value["FlightType"],
      });
    }).toList();
  }

  String getTime(String input) {
    return input.split(' ')[0];
  }

  void filterFlights(
      String fromAirport,
      String toAirport,
      bool isCheckedDirect,
      bool isCheckedIndirect,
      String sorteBy,
      int minPrice,
      int maxPrice,
      double lowPrice) {
    filteredEntries = filteredFlightsData.entries.where((flight) {
      bool matchesFrom = (fromAirport.isEmpty) ||
          (flight.value['DepartureAirportName'] == fromAirport);
      bool matchesTo = (toAirport.isEmpty) ||
          (flight.value['ArrivalAirportName'] == toAirport);

      bool matchesTypeDirect = (flight.value['FlightType'] == 'Direct') ||
          (isCheckedDirect == false);
      bool matchesTypeInDirect = (flight.value['FlightType'] != 'Direct') ||
          (isCheckedIndirect == false);
      var priceInSelectedCurrency = convert(
        'USD',
        flightCurrencyController.selectedCurrency.value,
        double.parse(flight.value['TicketAdultEconomyPrice'].toString()),
      );
      bool matchesLowestPrice =
          (priceInSelectedCurrency <= lowPrice) || (sorteBy != 'Lowest price');

      int durationInMinutes(String duration) {
        List<String> parts = duration.split('h');
        int hours = int.parse(parts[0].trim());
        String minutePart = parts[1].trim();
        int minutes = int.parse(minutePart.substring(0, minutePart.length - 1));

        return hours * 60 + minutes;
      }

      int FlightDuration = durationInMinutes(flight.value['FlightDuration']);
      int ShortestFlightDuration = durationInMinutes("02h 30m");
      bool matchesShortestDuration =
          (FlightDuration <= ShortestFlightDuration) ||
              (sorteBy != 'Shortest duration');

      bool matchesLatestduration = (FlightDuration > ShortestFlightDuration) ||
          (sorteBy != 'Shortest duration');
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('d. M, y');
      final String formattedNow = formatter.format(now);
      final entryDate = formatter.parse(flight.value['DepartureDate']);
      final String formattedEntryDate = formatter.format(entryDate);

      bool matchesEarliestDepature = (formattedEntryDate == formattedNow) ||
          (sorteBy != 'Earliest depature');
      var ticketPrice = convert(
          'USD',
          flightCurrencyController.selectedCurrency.value,
          double.parse(flight.value['TicketAdultEconomyPrice'].toString()));

      bool matchesPriceRange =
          (ticketPrice >= minPrice && ticketPrice <= maxPrice);
      return matchesFrom &&
          matchesTo &&
          matchesTypeDirect &&
          matchesTypeInDirect &&
          matchesLowestPrice &&
          matchesShortestDuration &&
          matchesLatestduration &&
          matchesEarliestDepature &&
          matchesPriceRange;
    });

    NumberOfResultFilteredflights.value = filteredEntries.length;
    filteredEntries = null;
  }

  double convert(String from, String to, double amount) {
    Map<String, double> rates = {
      'AED': 3.67,
      'KWD': 0.30,
      'BHD': 0.38,
      'EUR': 0.85,
      'GBP': 0.75,
      'USD': 1.00,
      'INR': 74.25,
      'OMR': 0.39,
    };
    double amountInUsd = amount / rates[from]!;
    double convertedAmount = amountInUsd * rates[to]!;
    String resultAsString = convertedAmount.toStringAsFixed(2);
    double finalResult = double.parse(resultAsString);
    return finalResult;
  }

  void Confirm(
      TextEditingController fromSearchController,
      TextEditingController toSearchController,
      double lowPrice,
      RangeValues rangeValues) async {
    sorteBy.value = sorteBy.value;
    isCheckedDirect.value = isCheckedDirect.value;
    isCheckedIndirect.value = isCheckedIndirect.value;
    currentRangeValues.value = rangeValues;
    var updatedList = filteredFlightsData.entries.where((entry) {
      bool matchesFrom = (fromSearchController.text.isEmpty) ||
          (entry.value['DepartureAirportName'] == fromSearchController.text) ||
          (fromSearchController.text == '');
      bool matchesTo = (toSearchController.text.isEmpty) ||
          (entry.value['ArrivalAirportName'] == toSearchController.text) ||
          (toSearchController.text == '');

      bool matchesTypeDirect =
          (entry.value['FlightType'] == 'Direct') || (isCheckedDirect == false);
      bool matchesTypeInDirect = (entry.value['FlightType'] != 'Direct') ||
          (isCheckedIndirect == false);
      var priceInSelectedCurrency = convert(
        'USD',
        flightCurrencyController.selectedCurrency.value,
        double.parse(entry.value['TicketAdultEconomyPrice'].toString()),
      );
      bool matchesLowestPrice =
          (priceInSelectedCurrency <= lowPrice) || (sorteBy != 'Lowest price');

      int durationInMinutes(String duration) {
        List<String> parts = duration.split('h');
        int hours = int.parse(parts[0].trim());
        String minutePart = parts[1].trim();
        int minutes = int.parse(minutePart.substring(0, minutePart.length - 1));

        return hours * 60 + minutes;
      }

      int FlightDuration = durationInMinutes(entry.value['FlightDuration']);
      int ShortestFlightDuration = durationInMinutes("02h 30m");
      bool matchesShortestDuration =
          (FlightDuration <= ShortestFlightDuration) ||
              (sorteBy != 'Shortest duration');

      bool matchesLatestduration = (FlightDuration > ShortestFlightDuration) ||
          (sorteBy != 'Shortest duration');
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('d. M, y');
      final String formattedNow = formatter.format(now);
      final entryDate = formatter.parse(entry.value['DepartureDate']);
      final String formattedEntryDate = formatter.format(entryDate);

      bool matchesEarliestDepature = (formattedEntryDate == formattedNow) ||
          (sorteBy != 'Earliest depature');
      var ticketPrice = convert(
          'USD',
          flightCurrencyController.selectedCurrency.value,
          double.parse(entry.value['TicketAdultEconomyPrice'].toString()));

      bool matchesPriceRange = (ticketPrice >= rangeValues.start.round() &&
          ticketPrice <= rangeValues.end.round());

      return matchesFrom &&
          matchesTo &&
          matchesTypeDirect &&
          matchesTypeInDirect &&
          matchesLowestPrice &&
          matchesShortestDuration &&
          matchesLatestduration &&
          matchesEarliestDepature &&
          matchesPriceRange;
    }).map((entry) {
      return FlightDetailsClass.fromMap({
        "FlightID": entry.key,
        'DeparureDate': entry.value['DepartureDate'],
        'ArrivalDate': entry.value['ArrivalDate'],
        'DeparureTime': entry.value['DepartureTime'].toString(),
        'ArrivalTime': entry.value['ArrivalTime'].toString(),
        "Flight_Duration": entry.value['FlightDuration'],
        'DepartureAirport': entry.value['DepartureAirportName'],
        'ArrivalAirport': entry.value['ArrivalAirportName'],
        "TicketAdultEconomyPrice":
            entry.value['TicketAdultEconomyPrice'].toDouble(),
        "deparure_from": entry.value['DepartureLocation'],
        "deparure_to": entry.value['ArrivalLocation'],
        "NumberOfEconomySeats": entry.value['NumberOfEconomySeats'],
        "NumberOfFirstClassSeats": entry.value["NumberOfFirstClassSeats"],
        "TicketAdultFirstClassPrice":
            entry.value["TicketAdultFirstClassPrice"].toDouble(),
        "TicketChildEconomyPrice":
            entry.value["TicketChildEconomyPrice"].toDouble(),
        "TicketChildFirstClassPrice":
            entry.value["TicketChildFirstClassPrice"].toDouble(),
        "PlaneId": entry.value["PlaneID"],
        "PlaneManufacturer": entry.value["PlaneManufacturer"],
        "PlaneModel": entry.value["PlaneModel"],
        "FlightType": entry.value["FlightType"],
      });
    }).toList();
    flightsList.value = updatedList;
    flightsList.notifyListeners();
    update();
  }
}
