// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison, must_be_immutable, prefer_typing_uninitialized_variables, unused_local_variable, deprecated_member_use, avoid_function_literals_in_foreach_calls, prefer_is_empty, unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/flight_side_bookings_card.dart';
import 'package:traveling/classes/contact_details_passenger_class.dart';
import 'package:traveling/classes/flight_details_class.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/custom_widgets/tab_item.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightFlightDetailsView extends StatefulWidget {
  FlightDetailsClass flightDetails;
  var ItemIndex;
  List stopLocationsForFlight;
  List stopDurationsForFlight;

  FlightFlightDetailsView(
      {super.key,
      required this.flightDetails,
      required this.ItemIndex,
      required this.stopLocationsForFlight,
      required this.stopDurationsForFlight});

  @override
  State<FlightFlightDetailsView> createState() =>
      _FlightFlightDetailsViewState();
}

class _FlightFlightDetailsViewState extends State<FlightFlightDetailsView> {
  final CurrencyController FlightCurrency_Controller =
      Get.put(CurrencyController());
  bool? isChecked = false;
  String? sorteBy;
  User? AirelineCompany;
  final _auth = FirebaseAuth.instance;
  var uid;
  var currentUser;
  var AirelineCompanyId = '';
  var AirelineCompanyName = '';
  Map<dynamic, dynamic> PassengerAdultData = {};
  List<FlightInfoClass> flightsList = [];
  List<FlightInfoClass> filteredFlights = [];
  List<ContactDetailsClass> ContactDetails = [];

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    setState(() {
      getData();
      AirelineCompany = _auth.currentUser;
      AirelineCompanyId = AirelineCompany?.uid.toString() ?? '';
    });
  }

  void getData() async {
    final event =
        await FirebaseDatabase.instance.ref('Airline_company').child(uid).get();
    final AirelineCompanyData = Map<dynamic, dynamic>.from(event.value as Map);
    AirelineCompanyName = AirelineCompanyData['AirlineCompanyName'];
    fetchFlights(widget.flightDetails.FlightID).then((fetchedFlights) {
      if (mounted) {
        setState(() {
          PassengerAdultData = fetchedFlights;
          flightsList = fetchedFlights.entries.map((entry) {
            var stringKeyedMap = Map<dynamic, dynamic>.from(entry.value);
            return FlightInfoClass.fromMap(stringKeyedMap);
          }).toList();
        });
      }
      // fetchStoplocationsFlights();
    });
  }

  Map<dynamic, dynamic> filteredFlightsData = {};
  Future<Map> fetchFlights(String specificFlightId) async {
    PassengerAdultData.clear();
    ContactDetails.clear();

    await FirebaseDatabase.instance
        .reference()
        .child('contact_details_passenger')
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var contact_details_data =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        contact_details_data.forEach((keyy, value) {
          var FlightData = Map<dynamic, dynamic>.from(value);
          FirebaseDatabase.instance
              .reference()
              .child('booking')
              .once()
              .then((DatabaseEvent eventt) {
            if (eventt.snapshot.exists) {
              var flightsData =
                  Map<dynamic, dynamic>.from(eventt.snapshot.value as Map);
              flightsData.forEach((key, value) {
                if (contact_details_data[keyy]['bookingId'] == key) {
                  FirebaseDatabase.instance
                      .reference()
                      .child('Flight')
                      .once()
                      .then((DatabaseEvent eventt) {
                    if (eventt.snapshot.exists) {
                      var flightsDataFlight = Map<dynamic, dynamic>.from(
                          eventt.snapshot.value as Map);
                      flightsDataFlight.forEach((Flightkey, value) {
                        if (Flightkey == specificFlightId &&
                            flightsData[key]['flightId'] == specificFlightId) {
                          if (mounted) {
                            setState(() {
                              PassengerAdultData[keyy] =
                                  contact_details_data[keyy];
                            });
                            ContactDetails.clear();
                            ContactDetails =
                                PassengerAdultData.entries.map((entry) {
                              int index = int.tryParse(key) ?? 0;
                              return ContactDetailsClass.fromMap({
                                'firstname':
                                    '${entry.value['firstname'].toString()}',
                                'Email': entry.value['Email'],
                                'mobilenumber':
                                    entry.value['mobilenumber'].toString(),
                                'bookingId':
                                    entry.value['bookingId'].toString(),
                                'lastname': entry.value['lastname'],
                              });
                            }).toList();
                          }
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        });
      }
    });
    return PassengerAdultData;
  }

  @override
  Widget build(BuildContext context) {
    final CurrencyController FlightCurrency_Controller =
        Get.put(CurrencyController());
    Size size = MediaQuery.of(context).size;
    print(widget.flightDetails.FlightID);
    print('.........,,,,,');
    print('mmmmmmmmmmmmmmmm');
    print(widget.ItemIndex);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.StatusBarColor,
          body: SafeArea(
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Flight Details',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.backgroundgrayColor),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/png/background1.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    width: size.width - 30,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.babyblueColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: AppColors.babyblueColor,
                      indicator: BoxDecoration(
                        color: AppColors.Blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.Blue,
                      tabs: [
                        TabItem(title: 'Details', count: 1),
                        TabItem(title: 'Bookings', count: 2),
                      ],
                    ),
                  ),
                ),
                (widget.stopLocationsForFlight != null &&
                        widget.flightDetails != null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 170),
                        child: Expanded(
                          child: TabBarView(
                            children: [
                              flightDetails(
                                  context,
                                  widget.flightDetails,
                                  widget.stopDurationsForFlight,
                                  widget.stopLocationsForFlight,
                                  widget.ItemIndex),
                              bookingsContact(context, ContactDetails),
                              // bookings(context),
                            ],
                          ),
                        ),
                      )
                    : CircularProgressIndicator()
              ],
            ),
          ),
        ));
  }
}

Widget flightDetails(BuildContext context, FlightDetailsClass flightDetails,
    List stopDurationsForFlight, List stopLocationsForFlight, var ItemIndex) {
  print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  print(ItemIndex);
  final CurrencyController FlightCurrency_Controller =
      Get.put(CurrencyController());
  String getCity(String input) {
    List<String> parts = input.split(',');
    return parts[0].trim();
  }

  String getCountry(String input) {
    List<String> parts = input.split(',');
    if (parts.length > 1) {
      return parts[1].trim();
    } else {
      return 'Country not found';
    }
  }

  List<TextEditingController> stopDurationscontrollers = [];
  List<TextEditingController> stopLocationscontrollers = [];

  stopDurationsForFlight.forEach((_) {
    stopDurationscontrollers.add(TextEditingController());
  });
  stopLocationsForFlight.forEach((_) {
    stopLocationscontrollers.add(TextEditingController());
  });

  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Plane Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Plane id',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  readOnly: true,
                  controller:
                      TextEditingController(text: flightDetails.PlaneId),
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Plane Model',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  readOnly: true,
                  controller:
                      TextEditingController(text: flightDetails.PlaneModel),
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Plane Manufacturer',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: flightDetails.PlaneManufacturer),
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Flight details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Departure Airport',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: flightDetails.DepartureAirport),
                  keyboardType: TextInputType.text,
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                ),
              ),
              SizedBox(
                height: 40,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Arrival Airport',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  readOnly: true,
                  controller:
                      TextEditingController(text: flightDetails.ArrivalAirport),
                  keyboardType: TextInputType.text,
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_land)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Depature City',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: getCity(flightDetails.deparure_from)),
                          keyboardType: TextInputType.text,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.public)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Departure country',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          controller: TextEditingController(
                              text: getCountry(flightDetails.deparure_from)),
                          keyboardType: TextInputType.text,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.public)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Arrival City',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: getCity(flightDetails.deparure_to)),
                          keyboardType: TextInputType.text,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.public)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Arrival country',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: getCountry(flightDetails.deparure_to)),
                          keyboardType: TextInputType.text,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.public)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // SizedBox(
              //   height: 45,
              //   width: size.width - 50,
              //   child: TextField(
              //     readOnly: true, // This makes the TextField read-only
              //     controller:
              //         TextEditingController(text: flightDetails.airport_from),
              //     keyboardType: TextInputType.phone,
              //     decoration: textFielDecoratiom.copyWith(
              //         fillColor: Colors.white,
              //         prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
              //     onChanged: (value) {},
              //   ),
              // ),
              // const SizedBox(
              //   height: 40,
              // ),
              // const Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Text(
              //       'To',
              //       style: TextStyle(
              //           fontSize: 13,
              //           color: AppColors.grayText,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 45,
              //   width: size.width - 50,
              //   child: TextField(
              //     readOnly: true,
              //     controller:
              //         TextEditingController(text: flightDetails.airport_to),
              //     decoration: textFielDecoratiom.copyWith(
              //         fillColor: Colors.white,
              //         prefixIcon: const Icon(Icons.flight_land)),
              //     onChanged: (value) {},
              //   ),
              // ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Depature Time',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: flightDetails.DeparureTime),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.access_time)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Arrival Time',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: flightDetails.ArrivalTime),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon:
                                  const Icon(Icons.access_time_outlined)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Depature Date',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: flightDetails.DeparureDate),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.date_range_rounded)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Return Date',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: flightDetails.ArrivalDate),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.date_range_rounded)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Tickets and Seats',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Number of economy seats',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: flightDetails.NumberOfEconomySeats
                                  .toString()),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                  Icons.airline_seat_recline_normal)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ticket Price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text:
                                '${FlightCurrency_Controller.convert(FlightCurrency_Controller.selectedCurrency.value, flightDetails.TicketAdultEconomyPrice.toDouble())} ${FlightCurrency_Controller.selectedCurrency.value}',
                          ),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon:
                                  const Icon(Icons.airplane_ticket_outlined)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Number of first class seats',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: flightDetails.NumberOfFirstClassSeats
                                  .toString()),
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                  Icons.airline_seat_recline_extra_rounded)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ticket Price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          controller: TextEditingController(
                            text:
                                '${FlightCurrency_Controller.convert(FlightCurrency_Controller.selectedCurrency.value, flightDetails.TicketAdultFirstClassPrice.toDouble())} ${FlightCurrency_Controller.selectedCurrency.value}',
                          ),
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon:
                                  const Icon(Icons.airplane_ticket_outlined)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Child economy ticket price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text:
                                '${FlightCurrency_Controller.convert(FlightCurrency_Controller.selectedCurrency.value, flightDetails.TicketChildEconomyPrice!.toDouble())} ${FlightCurrency_Controller.selectedCurrency.value}',
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.child_care)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Child first class ticket price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text:
                                '${FlightCurrency_Controller.convert(FlightCurrency_Controller.selectedCurrency.value, flightDetails.TicketChildFirstClassPrice!.toDouble())} ${FlightCurrency_Controller.selectedCurrency.value}',
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.child_care)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

Widget bookingsContact(
    BuildContext context, List<ContactDetailsClass> ContactPassengerDetails) {
  return (ContactPassengerDetails != null)
      ? Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: ContactPassengerDetails.length,
            itemBuilder: (context, index) {
              return BookingsCard(
                itemIndex: index,
                ContactDetailsPassengerData: ContactPassengerDetails[index],
              );
            },
          ),
        )
      : CircularProgressIndicator();
}
