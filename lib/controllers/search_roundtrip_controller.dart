// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, avoid_print, deprecated_member_use, prefer_final_fields, unnecessary_overrides, unused_local_variable, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/flight_details_class.dart';

import '../ui/views/traveller_side_views/flights_view/flights_view_rountrip.dart';
// import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_rountrip.dart';

enum FlightTypeRoundTrip { Economy, FirstClass }

class SearchViewRoundTripController extends GetxController {
  var isLoadingRoundTrip = false;
  var _flightType = ''.obs;
  get TypeFlight => _flightType;
  RxMap<dynamic, dynamic> filteredFlightsData = <dynamic, dynamic>{}.obs;
  RxMap<dynamic, dynamic> filteredReturnFlightsData = <dynamic, dynamic>{}.obs;
  ValueNotifier<List<FlightDetailsClass>> departureFlightsList =
      ValueNotifier<List<FlightDetailsClass>>([]);
  ValueNotifier<List<FlightDetailsClass>> returnFlightsList =
      ValueNotifier<List<FlightDetailsClass>>([]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ValueNotifier<List<FlightDetailsClass>> flightsList =
      ValueNotifier<List<FlightDetailsClass>>([]);
  Rx<DateTime> departureDate = DateTime.now().obs;
  Rx<DateTime> ReturnDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  int _Adultcounter = 1;
  int _Childcounter = 0;
  int get Adultcounter => _Adultcounter;
  int get Childcounter => _Childcounter;
  double totalflightprice = 0;
  var DepartureCityRoundTrip = ''.obs;
  var ArrivalCityRoundTrip = ''.obs;

  var isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
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
                  flightData['ArrivalCity'] == ArrivalCityRoundTrip.value &&
                  flightData['DeparureCity'] == DepartureCityRoundTrip.value;
          //

          if (seatPassengersAdultCondition &&
              seatPassengersChildrenCondition &&
              dateAndCityConditions) {
            flightsData.forEach((key1, value1) {
              var returnFlightData = Map<dynamic, dynamic>.from(value1);
              bool dateAndCityConditionsReturn =
                  returnFlightData['DeparureDate'] == formattedReturnDate &&
                      returnFlightData['ArrivalCity'] ==
                          DepartureCityRoundTrip.value &&
                      returnFlightData['DeparureCity'] ==
                          ArrivalCityRoundTrip.value;
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
          // Get.to(() => FlightsViewRound(
          //     DepartureflightData: filteredDepartureFlightsData,
          //     ReturnflightData: filteredArrivalFlightsData));
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

  Future<void> fetchFlights() async {
    print('ooirririri');
    Map<dynamic, dynamic> filteredDepartureFlightsData = {};
    Map<dynamic, dynamic> filteredArrivalFlightsData = {};
    bool airportConditionDeparture = false;
    bool airportConditionArrival = false;
    bool airportConditionDepartureReturn = false;
    bool airportConditionArrivalReturn = false;
    String DepartureAirport = '';
    String ArrivalAirport = '';
    String DepartureCity = '';
    String ArrivalCity = '';
    String DepartureCountry = '';
    String ArrivalCountry = '';
    String DepartureAirportReturnFlight = '';
    String ArrivalAirportReturnFlight = '';
    String DepartureCityReturnFlight = '';
    String ArrivalCityReturnFlight = '';
    String DepartureCountryReturnFlight = '';
    String ArrivalCountryReturnFlight = '';
    var keysToModify = [];
    String formattedDepartureDate = getFormattedDepartureDate();
    String formattedReturnDate = getFormattedReturnDate();
    var event =
        await FirebaseDatabase.instance.reference().child('Flight').once();
    if (event.snapshot.exists) {
      var flightsData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      for (var key in flightsData.keys) {
        var flightData = Map<dynamic, dynamic>.from(flightsData[key]);
        for (var key1 in flightsData.keys) {
          var ReturnflightData = Map<dynamic, dynamic>.from(flightsData[key1]);

          var airportEvent = await FirebaseDatabase.instance
              .reference()
              .child('Airport')
              .once();
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

          bool seatPassengersAdultCondition1 =
              int.parse(flightsData[key1]['NumberOfEconomySeats'].toString()) >=
                  Adultcounter;
          bool seatPassengersChildrenCondition1 = Childcounter == 0 ||
              int.parse(flightsData[key1]['NumberOfEconomySeats'].toString()) >=
                  Childcounter;
          bool dateAndCityConditions1 =
              flightsData[key1]['DepartureDate'] == formattedReturnDate;

          airportConditionDeparture = false;
          airportConditionArrival = false;
          airportData.forEach((airportDataKey, airportDataValue) {
            if (airportDataKey == flightsData[key]['DepartureAirportID']) {
              airportDataValue
                  .forEach((departureAirportCode, departureAirportData) {
                if (departureAirportData['Location'] ==
                    DepartureCityRoundTrip.value) {
                  DepartureAirport = departureAirportData['AirportName'];
                  DepartureCountry = departureAirportData['Location'];
                  DepartureCity = departureAirportCode;
                  airportConditionDeparture = true;
                }
              });
            }
            if (airportDataKey == flightsData[key]['ArrivalAirportID']) {
              airportDataValue
                  .forEach((arrivalAirportCode, arrivalAirportData) {
                if (arrivalAirportData['Location'] ==
                    ArrivalCityRoundTrip.value) {
                  ArrivalAirport = arrivalAirportData['AirportName'];
                  ArrivalCity = arrivalAirportCode;
                  ArrivalCountry = arrivalAirportData['Location'];
                  airportConditionArrival = true;
                }
              });
            }
            if (airportDataKey == flightsData[key]['DepartureAirportID']) {
              airportDataValue
                  .forEach((departureAirportCode, departureAirportData) {
                if (departureAirportData['Location'] ==
                    ArrivalCityRoundTrip.value) {
                  DepartureAirportReturnFlight =
                      departureAirportData['AirportName'];
                  DepartureCountryReturnFlight =
                      departureAirportData['Location'];
                  DepartureCityReturnFlight = departureAirportCode;
                  airportConditionDepartureReturn = true;
                }
              });
            }
            if (airportDataKey == flightsData[key]['ArrivalAirportID']) {
              airportDataValue
                  .forEach((arrivalAirportCode, arrivalAirportData) {
                if (arrivalAirportData['Location'] ==
                    DepartureCityRoundTrip.value) {
                  ArrivalAirportReturnFlight =
                      arrivalAirportData['AirportName'];
                  ArrivalCityReturnFlight = arrivalAirportCode;
                  ArrivalCountryReturnFlight = arrivalAirportData['Location'];
                  airportConditionArrivalReturn = true;
                }
              });
            }
          });
          bool dateAndCityConditionsReturn =
              ReturnflightData['DepartureDate'] == formattedReturnDate;
          // ReturnflightData['ArrivalCity'] == DepartureCityRoundTrip.value &&
          // ReturnflightData['DeparureCity'] == ArrivalCityRoundTrip.value;
          if (airportConditionArrivalReturn &&
              airportConditionDepartureReturn &&
              // dateAndCityConditionsReturn &&
              flightData['DeparureCity'] == ReturnflightData['ArrivalCity'] &&
              flightData['ArrivalCity'] == ReturnflightData['DeparureCity'] &&
              airportConditionDeparture &&
              airportConditionArrival &&
              seatPassengersAdultCondition &&
              seatPassengersChildrenCondition &&
              seatPassengersAdultCondition1 &&
              dateAndCityConditions1 &&
              dateAndCityConditions &&
              seatPassengersChildrenCondition1) {
            var stopLocationEvent = await FirebaseDatabase.instance
                .reference()
                .child('Stop_location')
                .once();
            var flightCompany = await FirebaseDatabase.instance
                .reference()
                .child('Airline_company')
                .once();

            if (filteredDepartureFlightsData[key] ==
                filteredArrivalFlightsData[key1]) {
              filteredDepartureFlightsData[key] = flightData;
              filteredArrivalFlightsData[key1] = ReturnflightData;
            }
          }

          if (airportConditionDeparture &&
              airportConditionArrival &&
              seatPassengersAdultCondition &&
              seatPassengersChildrenCondition &&
              dateAndCityConditions &&
              airportConditionArrivalReturn &&
              airportConditionDepartureReturn &&
              seatPassengersChildrenCondition1) {
            fetchStoplocationsFlights(
              DepartureAirport,
              ArrivalAirport,
              DepartureCountry,
              ArrivalCountry,
              DepartureCity,
              ArrivalCity,
              DepartureAirportReturnFlight,
              ArrivalAirportReturnFlight,
              DepartureCountryReturnFlight,
              ArrivalCountryReturnFlight,
              DepartureCityReturnFlight,
              ArrivalCityReturnFlight,
              filteredDepartureFlightsData,
              filteredArrivalFlightsData,
            );
            keysToModify.add(key);
          }
        }
      }
    }
  }

  var stopDurationsForDepartureFlight = [];
  var stopLocationsForDepartureFlight = [];
  var stopDurationsForReturnFlight = [];
  var stopLocationsForReturnFlight = [];
  Future<void> fetchStoplocationsFlights(
      String departureAirport,
      String arrivalAirport,
      String departureCountry,
      String arrivalCountry,
      String departureCity,
      String arrivalCity,
      String departureAirportReturnFlight,
      String arrivalAirportReturnFlight,
      String departureCountryReturnFlight,
      String arrivalCountryReturnFlight,
      String departureCityReturnFlight,
      String arrivalCityReturnFlight,
      Map<dynamic, dynamic> filteredDepartureFlightsData,
      Map<dynamic, dynamic> filteredReturnFlightsData) async {
    stopDurationsForDepartureFlight.clear();
    stopLocationsForDepartureFlight.clear();
    stopDurationsForReturnFlight.clear();
    stopLocationsForReturnFlight.clear();
    int stopCountDepartureFlight = 0;
    int stopCountReturnFlight = 0;

    var event = await FirebaseDatabase.instance
        .reference()
        .child('Stop_location')
        .once();
    var flightCompany = await FirebaseDatabase.instance
        .reference()
        .child('Airline_company')
        .once();
    if (flightCompany.snapshot.exists) {
      // print(flightCompanyDetails[]['']);
    }
    if (event.snapshot.exists) {
      var stopLocationData =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      stopLocationData.forEach((stopKey, value) {
        filteredDepartureFlightsData.entries.forEach((entry) {
          if (value['FlighID'] == entry.key) {
            stopCountDepartureFlight++;
            stopDurationsForDepartureFlight.add(value['StopDuration']);
            stopLocationsForDepartureFlight.add(value['StopLocation']);
          }
        });
      });
      stopLocationData.forEach((stopKey, value) {
        filteredReturnFlightsData.entries.forEach((entry) {
          if (value['FlighID'] == entry.key) {
            stopCountReturnFlight++;
            stopDurationsForReturnFlight.add(value['StopDuration']);
            stopLocationsForReturnFlight.add(value['StopLocation']);
          }
        });
      });
      departureFlightsList.value =
          filteredDepartureFlightsData.entries.map((entry) {
        var flightCompanyDetails =
            Map<dynamic, dynamic>.from(flightCompany.snapshot.value as Map);

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
          "FlightType": stopCountDepartureFlight > 0
              ? '${stopCountDepartureFlight} Stop'
              : 'Direct',
          "DepartureCity": departureCity,
          "ArrivalCity": arrivalCity,
          "FlightCompanyName": flightCompanyDetails[entry.value['AirlinId']]
              ['AirlineCompanyName'],
          "FlightCompanyLogo": flightCompanyDetails[entry.value['AirlinId']]
              ['logo']
        });
      }).toList();
      stopCountDepartureFlight = 0;

      returnFlightsList.value = filteredReturnFlightsData.entries.map((entry) {
        var flightCompanyDetails =
            Map<dynamic, dynamic>.from(flightCompany.snapshot.value as Map);
        return FlightDetailsClass.fromMap({
          "FlightID": entry.key,
          'DeparureDate': entry.value['DepartureDate'],
          'ArrivalDate': entry.value['ArrivalDate'],
          'DeparureTime': entry.value['DepartureTime'].toString(),
          'ArrivalTime': entry.value['ArrivalTime'].toString(),
          "Flight_Duration": entry.value['FlightDuration'],
          'DepartureAirport': departureAirportReturnFlight,
          'ArrivalAirport': arrivalAirportReturnFlight,
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
          "FlightType": stopCountReturnFlight > 0
              ? '${stopCountReturnFlight} Stop'
              : 'Direct',
          "DepartureCity": departureCityReturnFlight,
          "ArrivalCity": arrivalCityReturnFlight,
          "FlightCompanyName": flightCompanyDetails[entry.value['AirlinId']]
              ['AirlineCompanyName'],
          "FlightCompanyLogo": flightCompanyDetails[entry.value['AirlinId']]
              ['logo']
        });
      }).toList();
      stopCountReturnFlight = 0;

      if (returnFlightsList.value.isNotEmpty) {
        Get.to(() => FlightsViewRound());
      }
      isloading.value = false;
    }
    // if (returnFlightsList.value.isEmpty && departureFlightsList.value.isEmpty) {
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

  void updateFlightsList() {
    departureFlightsList.value = filteredFlightsData.entries.map((entry) {
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
    update();
  }
}
