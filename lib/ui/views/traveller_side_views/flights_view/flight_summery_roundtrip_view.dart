// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/controllers/flight_info_controller.dart';
import 'package:traveling/ui/shared/colors.dart';

class FlightSummeryRoundTrip extends StatelessWidget {
  FlightInfoClass flightdata;
  FlightInfoClass? ReturnFlightData;
  final FlightInfoController controller = Get.put(FlightInfoController());
  FlightSummeryRoundTrip(
      {required this.flightdata, required this.ReturnFlightData});

  @override
  Widget build(BuildContext context) {
    controller.updateFlightInfo(flightdata);

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
                      Image.asset('assets/image/png/flynas.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        flightdata.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
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
                            flightdata.DeparureTime,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            'AM',
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
                        'Direct',
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
                            flightdata.ArrivalTime,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            'PM',
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
                          flightdata.airport_from,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      Text(
                        flightdata.DeparureCity,
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
                          flightdata.airport_to,
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
                      Image.asset('assets/image/png/flynas.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        ReturnFlightData?.name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
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
                            ReturnFlightData?.DeparureTime ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            'AM',
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
                        'Direct',
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
                            ReturnFlightData?.ArrivalTime ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text(
                            'PM',
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
                          ReturnFlightData?.airport_from ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      Text(
                        ReturnFlightData?.DeparureCity ?? '',
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
                          ReturnFlightData?.airport_to ?? '',
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
}
