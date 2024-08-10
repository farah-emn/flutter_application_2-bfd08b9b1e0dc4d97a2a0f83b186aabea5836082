// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/controllers/flight_info_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import '../../../../classes/flight_details_class.dart';
import '../../../../controllers/search_roundtrip_controller.dart';

class FlightSummeryRoundTrip extends StatelessWidget {
  FlightDetailsClass flightdata;
  FlightDetailsClass? ReturnFlightData;
  final FlightInfoController controller = Get.put(FlightInfoController());
  final searchViewRoundTripController =
      Get.put(SearchViewRoundTripController());
  FlightSummeryRoundTrip(
      {required this.flightdata, required this.ReturnFlightData});

  @override
  Widget build(BuildContext context) {
    // controller.updateFlightInfo(flightdata);

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(flightdata.FlightCompanyLogo)),
                        width: 26,
                        height: 26,
                      ),
                      SizedBox(width: 6),
                      Text(
                        flightdata.FlightCompanyName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        flightdata.DeparureDate,
                        style: TextStyle(color: AppColors.TextgrayColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            getTime(flightdata.DeparureTime),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            getTimePmAm(flightdata.DeparureTime),
                            style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        flightdata.FlightType ?? '',
                        style: TextStyle(
                          color: AppColors.TextgrayColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        flightdata.Flight_Duration,
                        style: TextStyle(
                          color: AppColors.TextgrayColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            getTime(flightdata.ArrivalTime),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            getTimePmAm(flightdata.ArrivalTime),
                            style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: const Color.fromARGB(255, 206, 206, 206),
                    width: 1,
                    height: 130,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2 + 30,
                        child: Text(
                          flightdata.DepartureAirport,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      Text(
                        flightdata.DepartureCity,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.TextgrayColor),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: size.width / 2 + 30,
                        child: Text(
                          flightdata.ArrivalAirport,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      Text(
                        flightdata.ArrivalCity,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.TextgrayColor),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                ReturnFlightData!.FlightCompanyLogo)),
                        width: 26,
                        height: 26,
                      ),
                      SizedBox(width: 6),
                      Text(
                        ReturnFlightData!.FlightCompanyName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        ReturnFlightData?.DeparureDate ?? '',
                        style: TextStyle(color: AppColors.TextgrayColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            getTime(ReturnFlightData!.DeparureTime) ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            getTimePmAm(ReturnFlightData!.DeparureTime),
                            style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        ReturnFlightData?.FlightType ?? '',
                        style: TextStyle(
                          color: AppColors.TextgrayColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        ReturnFlightData?.Flight_Duration ?? '',
                        style: TextStyle(
                          color: AppColors.TextgrayColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            getTime(ReturnFlightData!.ArrivalTime) ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            getTimePmAm(ReturnFlightData!.ArrivalTime),
                            style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    color: const Color.fromARGB(255, 206, 206, 206),
                    width: 1,
                    height: 130,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2 + 30,
                        child: Text(
                          ReturnFlightData?.DepartureAirport ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      Text(
                        ReturnFlightData?.DepartureCity ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.TextgrayColor),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: size.width / 2 + 30,
                        child: Text(
                          ReturnFlightData?.ArrivalAirport ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      Text(
                        ReturnFlightData?.ArrivalCity ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.TextgrayColor),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/image/png/Wifi_icon.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Wifi is available'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/image/png/Wifi_icon.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('in seat power & USB outlets'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/image/png/Wifi_icon.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('in seat power & USB outlets'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Baggage allowance',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/image/png/Wifi_icon.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Wifi is available'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/image/png/Wifi_icon.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('in seat power & USB outlets'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/image/png/Wifi_icon.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('in seat power & USB outlets '),
                ],
              ),
            ],
          ),
        ),
      ],
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
