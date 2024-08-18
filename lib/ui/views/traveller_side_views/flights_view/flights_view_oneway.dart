// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_label, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_local_variable, unused_element

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/flight_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/booking_flight_summary._view.dart';
import 'dart:math' as math;

class FlightsView extends StatelessWidget {
  FlightsView();

  final SearchViewRoundTrip_Controller =
      Get.put(SearchViewRoundTripController());
  final searchViewOneWayController = Get.put(SearchViewOneWayController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LightBlueColor,
      body: Stack(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsetsDirectional.only(
          //       top: screenHeight(10), start: screenWidth(12)),
          //   child: Column(
          //     children: [
          //       Text(
          //         searchViewOneWayController
          //                 .flightsList.value[0].DepartureCity ??
          //             '',
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         searchViewOneWayController
          //                 .flightsList.value[0].DeparureDate ??
          //             '',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 16,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Padding(
          //     padding: EdgeInsetsDirectional.only(
          //         top: screenHeight(10), start: screenWidth(1.3)),
          //     child: Column(
          //       children: [
          //         Text(
          //           searchViewOneWayController
          //               .flightsList.value[0].ArrivalCity,
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold),
          //         ),
          //         Text(
          //           searchViewOneWayController
          //                   .flightsList.value[0].ArrivalDate ??
          //               '',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //           ),
          //         )
          //       ],
          //     )),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    )),
                Text(
                  searchViewOneWayController
                              .flightsList.value[0].DepartureCity +
                          ' to ' +
                          searchViewOneWayController
                              .flightsList.value[0].ArrivalCity ??
                      'Seatch',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 70),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => _buildListItem(
                            context,
                            searchViewOneWayController
                                .flightsList.value[index]),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            searchViewOneWayController.flightsList.value.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, FlightDetailsClass flight) {
    final CurrencyController controller = Get.put(CurrencyController());
    String _getFormattedCity(String City) {
      final List<String> parts = City.split(',');
      if (parts.length >= 2) {
        final String City = parts[0];

        return '$City';
      } else {
        return '';
      }
    }

    String _getFormattedDate(String date) {
      String day = '';
      final DateFormat inputFormat = DateFormat('d. M, yyyy');
      final DateFormat outputFormat = DateFormat('MMMM');
      final List<String> parts = date.split('.');
      if (parts.length >= 2) {
        day = parts[0];
      }

      DateTime dateTime;
      try {
        dateTime = inputFormat.parse(date);
      } catch (e) {
        return '';
      }

      String monthName = outputFormat.format(dateTime);
      return '${day}. ${monthName}';
    }

    _getFormattedDate(flight.DeparureDate);

    return InkWell(
      onTap: () {
        GlobalKey<FormState> globalFormKey1 = GlobalKey<FormState>();

        Get.to(
          BookingFlightSummaryView(
            type: 'oneway',
            flightdata: flight,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(flight.FlightCompanyLogo)),
                  ),
                  SizedBox(width: 10),
                  Text(
                    flight.FlightCompanyName,
                    style: TextStyle(
                        fontSize: TextSize.header1,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Deparure',
                            style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText,
                            ),
                          ),
                          Text(
                            getTime(flight.DeparureTime),
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: AppColors.Blue,
                          ),
                          Container(
                            color: AppColors.Blue,
                            height: 3.5,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            color: AppColors.Blue,
                            height: 3.5,
                            width: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Transform.rotate(
                            angle: math.pi / 2,
                            child: Icon(
                              Icons.flight,
                              size: 30,
                              color: AppColors.Blue,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            color: AppColors.Blue,
                            height: 3.5,
                            width: 20,
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 40,
                            color: AppColors.Blue,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Arrival',
                            style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText,
                            ),
                          ),
                          Text(
                            getTime(flight.ArrivalTime),
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Padding(
                  //   padding: EdgeInsetsDirectional.only(start: 1, end: 22),
                  //   child: Row(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text(_getFormattedCity(flight.DeparureCity)),
                  //           SizedBox(width: 2),
                  //           Text(
                  //             _getFormattedDate(flight.DeparureDate),
                  //             style: TextStyle(color: AppColors.grayText),
                  //           ),
                  //           // SizedBox(width: 110),
                  //         ],
                  //       ),
                  //       Spacer(),
                  //       Row(
                  //         children: [
                  //           Text(_getFormattedCity(flight.ArrivalCity)),
                  //           Text(
                  //             _getFormattedDate(flight.ArrivalDate),
                  //             style: TextStyle(color: AppColors.grayText),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 20,
                            color: AppColors.Blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            flight.FlightType ?? '',
                            style: TextStyle(color: AppColors.grayText),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 20,
                            color: AppColors.Blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            flight.Flight_Duration,
                            style: const TextStyle(color: AppColors.grayText),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${controller.convert(controller.selectedCurrency.value, flight.TicketAdultEconomyPrice)}',
                            style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.selectedCurrency.value,
                            style: TextStyle(
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedCity(String City) {
    final List<String> parts = City.split(',');
    if (parts.length >= 2) {
      final String City = parts[0];

      return '$City';
    } else {
      return '';
    }
  }

  String _getFormattedDate(String date) {
    String day = '';
    final DateFormat inputFormat = DateFormat('d. M, yyyy');
    final DateFormat outputFormat = DateFormat('MMMM');
    final List<String> parts = date.split('.');
    if (parts.length >= 2) {
      day = parts[0];
    }

    DateTime dateTime;
    try {
      dateTime = inputFormat.parse(date);
    } catch (e) {
      return '';
    }

    String monthName = outputFormat.format(dateTime);
    return '${day}. ${monthName}';
  }

  String getTime(String input) {
    return input.split(' ')[0];
  }

  String getTimePmAm(String input) {
    var parts = input.split(' ');
    if (parts.length > 1)
      return parts[1];
    else
      return '';
  }
}
