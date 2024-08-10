// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_final_fields, avoid_print, deprecated_member_use, unnecessary_overrides

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/flight_details_class.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_oneway.dart';

enum FlightType { Economy, FirstClass }

class SearchViewOneWayController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().obs;
  Rx<DateTime> ReturnDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  var isLoadingOneWay = false;
  var _flightType = ''.obs;
  get TypeFlight => _flightType;
  int _Adultcounter = 1;
  int _Childcounter = 0;
  int get Adultcounter => _Adultcounter;
  int get Childcounter => _Childcounter;
  // var _DepartureCity = ''.obs;
  // var _ArrivalCity = ''.obs;
  // get DepartureCity => _DepartureCity;
  double totalpriceflight = 0;
  RxMap<dynamic, dynamic> filteredFlightsData = <dynamic, dynamic>{}.obs;
  ValueNotifier<List<FlightDetailsClass>> flightsList =
      ValueNotifier<List<FlightDetailsClass>>([]);
  var deoarturecityone = ''.obs;
  var Arrivalcityone = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // void setArrivalCity(String city) {
  //   _ArrivalCity.value = city;
  // }

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

  void setFlightType(String value) {
    if (value == 'F') {
      _flightType.value = 'FirstClass';
    } else if (value == 'E') {
      _flightType.value = 'Economy';
    } else {
      _flightType.value = 'Flight type';
    }

    update();
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

  // void setDepartureCity(String city) {
  //   _DepartureCity.value = city;
  // }

  Future<void> searchForFlights() async {
    String formattedDepartureDate = getFormattedDepartureDate();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('flights').once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
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
                  FlightData['ArrivalCity'] == Arrivalcityone.value &&
                  FlightData['DeparureCity'] == deoarturecityone.value;
          //
          if (seat_passengers_Adult_Condition &&
              seat_passengers_Children_Condition &&
              DateAndCityConditions) {
            filteredFlightsData[key] = FlightData;
            totalpriceflight = FlightData['ticket_price'];
          }
        });
        if (filteredFlightsData.isNotEmpty) {
          Get.to(() => FlightsView());
        } else {
          // Fluttertoast.showToast(
          //     msg: "No flights found",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.grey,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
        }
      }
    });
  }

  Future<void> fetchFlights() async {
    bool airportConditionDeparture = false;
    bool airportConditionArrival = false;
    String DepartureAirport = '';
    String ArrivalAirport = '';
    String DepartureCity = '';
    String ArrivalCity = '';
    String DepartureCountry = '';
    String ArrivalCountry = '';
    var keysToModify = [];
    String formattedDepartureDate = getFormattedDepartureDate();
    var event =
        await FirebaseDatabase.instance.reference().child('Flight').once();
    if (event.snapshot.exists) {
      var flightsData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      for (var key in flightsData.keys) {
        var flightData = Map<dynamic, dynamic>.from(flightsData[key]);
        var stopLocationEvent = await FirebaseDatabase.instance
            .reference()
            .child('Stop_location')
            .once();
        var stopLocationData =
            Map<String, dynamic>.from(stopLocationEvent.snapshot.value as Map);
        int stopCount = 0;

        stopLocationData.forEach((stopKey, value) {
          if (value['FlightID'] == key) {
            stopCount++;
          }
        });

        var airportEvent =
            await FirebaseDatabase.instance.reference().child('Airport').once();
        var airportData =
            Map<dynamic, dynamic>.from(airportEvent.snapshot.value as Map);

        var planeEvent =
            await FirebaseDatabase.instance.reference().child('Plane').once();
        var planeData =
            Map<dynamic, dynamic>.from(planeEvent.snapshot.value as Map);

        bool seatPassengersAdultCondition =
            int.parse(flightsData[key]['NumberOfEconomySeats'].toString()) >=
                Adultcounter;
        bool seatPassengersChildrenCondition = Childcounter == 0 ||
            int.parse(flightsData[key]['NumberOfEconomySeats'].toString()) >=
                Childcounter;
        bool dateAndCityConditions =
            flightsData[key]['DepartureDate'] == formattedDepartureDate;

        airportConditionDeparture = false;
        airportConditionArrival = false;

        airportData.forEach((airportDataKey, airportDataValue) {
          if (airportDataKey == flightsData[key]['DepartureAirportID']) {
            airportDataValue
                .forEach((departureAirportCode, departureAirportData) {
              if (departureAirportData['Location'] == deoarturecityone.value) {
                DepartureAirport = departureAirportData['AirportName'];
                DepartureCountry = departureAirportData['Location'];
                DepartureCity = departureAirportCode;
                print(departureAirportData['Location']);
                airportConditionDeparture = true;
              }
            });
          }
          if (airportDataKey == flightsData[key]['ArrivalAirportID']) {
            airportDataValue.forEach((arrivalAirportCode, arrivalAirportData) {
              if (arrivalAirportData['Location'] == Arrivalcityone.value) {
                ArrivalAirport = arrivalAirportData['AirportName'];
                ArrivalCity = arrivalAirportCode;
                ArrivalCountry = arrivalAirportData['Location'];
                airportConditionArrival = true;
              }
            });
          }
        });

        if (airportConditionDeparture &&
            airportConditionArrival &&
            seatPassengersAdultCondition &&
            seatPassengersChildrenCondition &&
            dateAndCityConditions) {
          fetchStoplocationsFlights(DepartureAirport, ArrivalAirport,
              DepartureCountry, ArrivalCountry, DepartureCity, ArrivalCity);

          keysToModify.add(key);
          filteredFlightsData[key] = flightData;
          // filteredFlightsData[key]['FlightType'] =
          //     stopCount > 0 ? "$stopCount Stop" : "Direct";

          planeData.forEach((planeDataKey, planeDataValue) {
            if (planeDataKey == flightsData[key]['PlaneId']) {
              planeDataValue.forEach((planeCode, planeDataDetails) {
                filteredFlightsData[key]['PlaneID'] = planeCode;
                filteredFlightsData[key]['PlaneManufacturer'] =
                    planeDataDetails['Manufacturer'];
                filteredFlightsData[key]['PlaneModel'] =
                    planeDataDetails['Model'];
              });
            }
          });
        }
        // if (filteredFlightsData.value.length == 0) {
        //   Fluttertoast.showToast(
        //       msg: "No flights found",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.grey,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
      }
    }
  }

  var stopDurationsForFlight = [];
  var stopLocationsForFlight = [];
  Future<void> fetchStoplocationsFlights(
      String departureAirport,
      String arrivalAirport,
      String departureCountry,
      String arrivalCountry,
      String departureCity,
      String arrivalCity) async {
    int stopCount = 0;
    stopDurationsForFlight.clear();
    stopLocationsForFlight.clear();
    var flightCompany = await FirebaseDatabase.instance
        .reference()
        .child('Airline_company')
        .once();
    var event = await FirebaseDatabase.instance
        .reference()
        .child('Stop_location')
        .once();
    if (event.snapshot.exists) {
      var stopLocationData =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      stopLocationData.forEach((stopKey, value) {
        filteredFlightsData.entries.forEach((entry) {
          print(entry.key);
          print('bbbbbbbbbbb');

          if (value['FlighID'] == entry.key) {
            print('ertyuj');
            stopCount++;
            stopDurationsForFlight.add(value['StopDuration']);
            stopLocationsForFlight.add(value['StopLocation']);
          }
        });
      });

      flightsList.value = filteredFlightsData.entries.map((entry) {
        var flightCompanyDetails =
            Map<dynamic, dynamic>.from(flightCompany.snapshot.value as Map);
        print(entry.value);
        return FlightDetailsClass.fromMap({
          "FlightID": entry.key,
          'DeparureDate': entry.value['DepartureDate'],
          'ArrivalDate': entry.value['ArrivalDate'],
          'DeparureTime': entry.value['DepartureTime'].toString(),
          'ArrivalTime': entry.value['ArrivalTime'].toString(),
          "Flight_Duration": entry.value['FlightDuration'],
          'DepartureAirport': departureAirport,
          'ArrivalAirport': arrivalAirport,
          "TicketAdultEconomyPrice":
              entry.value['TicketAdultEconomyPrice'].toDouble(),
          "departure_from": entry.value['DepartureLocation'],
          "departure_to": entry.value['ArrivalLocation'],
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
          "FlightType": stopCount > 0 ? '${stopCount} Stop' : 'Direct',
          "DepartureCity": departureCity,
          "ArrivalCity": arrivalCity,
          "FlightCompanyName": flightCompanyDetails[entry.value['AirlinId']]
              ['AirlineCompanyName'],
          "FlightCompanyLogo": flightCompanyDetails[entry.value['AirlinId']]
              ['logo']
        });
      }).toList();

      print(flightsList.value[0].DepartureAirport);
      print('lllllllllllllllllllllll');

      if (filteredFlightsData.isNotEmpty) {
        Get.to(() => FlightsView());
      } else {
        // Fluttertoast.showToast(
        //     msg: "No flights found",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.grey,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
    }
  }

  void updateFlightsList() {
    flightsList.value = filteredFlightsData.entries.map((entry) {
      return FlightDetailsClass.fromMap({
        "FlightID": entry.key,
        'DepartureDate': entry.value['DepartureDate'],
        'ArrivalDate': entry.value['ArrivalDate'],
        'DepartureTime': entry.value['DepartureTime'].toString(),
        'ArrivalTime': entry.value['ArrivalTime'].toString(),
        "Flight_Duration": entry.value['FlightDuration'],
        'DepartureAirport': entry.value['DepartureAirportName'],
        'ArrivalAirport': entry.value['ArrivalAirportName'],
        "TicketAdultEconomyPrice":
            entry.value['TicketAdultEconomyPrice'].toDouble(),
        "departure_from": entry.value['DepartureLocation'],
        "departure_to": entry.value['ArrivalLocation'],
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

  void clearData() {
    departureDate.value = DateTime.now();
    ReturnDate.value = DateTime.now();
    selectedDate.value = '${DateTime.now().month}/${DateTime.now().day}';
    _Adultcounter = 1;
    _Childcounter = 0;
    // _DepartureCity.value = '';
    // _ArrivalCity.value = '';
    totalpriceflight = 0;
    update();
  }
}
