// ignore_for_file: unnecessary_import, unused_import, must_be_immutable, unused_element, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/ui/views/traveller_side_views/booking_flight_summary._view.dart';
import '../classes/flight_details_class.dart';
import '../ui/shared/colors.dart';
import '../ui/views/flight_side_views/flight_flight_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:traveling/cards/flight_details_card.dart';
import 'package:traveling/classes/flight_info_class.dart';
import '../../../classes/flight_details_class.dart';

class FlightDetailsCard extends StatefulWidget {
  final FlightDetailsClass flightsList;
  var itemIndex;

  FlightDetailsCard({
    super.key,
    required this.flightsList,
    required this.itemIndex,
  });

  @override
  State<FlightDetailsCard> createState() => _FlightDetailsCardState();
}

class _FlightDetailsCardState extends State<FlightDetailsCard> {
  var stopDurationsForFlight = [];
  var stopLocationsForFlight = [];
  @override
  void initState() {
    super.initState();
    fetchStoplocationsFlights();
  }

  Future<void> fetchStoplocationsFlights() async {
    stopDurationsForFlight.clear();
    stopLocationsForFlight.clear();

    FirebaseDatabase.instance
        .reference()
        .child('Stop_location')
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var stopLocationData =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        stopLocationData.forEach((Stopkey, value) {
          print('[object]');
          if (value['FlighID'] == widget.flightsList.FlightID) {
            print('object');
            int StopCount = 1;
            if (mounted) {
              setState(() {
                StopCount += 1;
                stopDurationsForFlight.add(value['StopDuration']);
                stopLocationsForFlight.add(value['StopLocation']);
                print(stopLocationsForFlight);
                print(',,,,,,,,,,jjjjjjjjjjj');
              });
            }
          } else {}
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.flightsList.FlightID);
    String getCityShortcut(String input) {
      if (input.length < 3) {
        return 'Input string must have at least three characters';
      } else {
        return input.substring(0, 3).toUpperCase();
      }
    }

    String getTime(String input) {
      return input.split(' ')[0];
    }

    String getTimePmAm(String input) {
      return input.split(' ')[1];
    }

    @override
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(FlightFlightDetailsView(
            flightDetails: widget.flightsList,
            ItemIndex: widget.flightsList.FlightID,
            stopLocationsForFlight: stopLocationsForFlight,
            stopDurationsForFlight: stopDurationsForFlight));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                getTime(widget.flightsList.DeparureTime),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                getTimePmAm(widget.flightsList.DeparureTime),
                                style: const TextStyle(
                                  color: AppColors.darkGray,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Text(
                          //   widget.flightsList.FlightType ?? '',
                          //   style: const TextStyle(
                          //     color: AppColors.darkGray,
                          //     fontSize: 12,
                          //   ),
                          // ),
                          Text(
                            widget.flightsList.Flight_Duration,
                            style: const TextStyle(
                              color: AppColors.darkGray,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                getTime(widget.flightsList.ArrivalTime),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                getTimePmAm(widget.flightsList.ArrivalTime),
                                style: const TextStyle(
                                  color: AppColors.darkGray,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        color: AppColors.Blue,
                        width: 1,
                        height: 130,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width / 2 + 30,
                            child: Text(
                              widget.flightsList.DepartureAirport,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                          ),
                          Text(
                            widget.flightsList.deparure_from,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: AppColors.darkGray,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: size.width / 2 + 30,
                            child: Text(
                              widget.flightsList.ArrivalAirport,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                          ),
                          Text(
                            widget.flightsList.deparure_to,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Depature Date:',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.flightsList.DeparureDate,
                            style:
                                const TextStyle(color: AppColors.TextgrayColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: size.width,
              padding: const EdgeInsets.only(right: 15),
              decoration: const BoxDecoration(
                color: AppColors.Blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'More Details',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
