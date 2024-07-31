import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/classes/flight_booking_class.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_booking_details_view.dart';

import '../classes/flight_details_class.dart';
import '../ui/shared/colors.dart';

class FlightBookingCard extends StatefulWidget {
  FlightBookingCard(
      {super.key, required this.flightBookingModel, required this.itemIndex});
  FlightBookings flightBookingModel;
  int itemIndex;

  @override
  State<FlightBookingCard> createState() => _FlightBookingCardState();
}

class _FlightBookingCardState extends State<FlightBookingCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: size.width,
      decoration: decoration.copyWith(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage(widget.flightBookingModel.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Text(
                      'Flynas',
                      style: TextStyle(
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      children: [
                        Text(
                          'CDG',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Paris',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Transform.rotate(
                      angle: 90 * pi / 180,
                      child: const Icon(
                        Icons.airplanemode_on_rounded,
                        size: 30,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Column(
                      children: [
                        Text(
                          'PEK',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'China',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      width: size.width - 72,
                      height: 1,
                      color: AppColors.LightGrayColor,
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passenger Number',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Depature Time',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '09:00',
                              style: TextStyle(
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'AM',
                              style: TextStyle(
                                  fontSize: TextSize.header2,
                                  color: AppColors.grayText),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Flight No',
                         
                              style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                        Text(
                          'MI0987',
                           style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                        Text(
                          '22/5/2024',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Arrival Time',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '01:00',
                              style: TextStyle(
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'PM',
                              style: TextStyle(
                                  fontSize: TextSize.header2,
                                  color: AppColors.grayText),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Gate',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.grayText),
                        ),
                        Text(
                          'C6',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                          
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(const FlightBookingDetailsView());
            },
            child: Container(
              height: 40,
              width: size.width,
              padding: EdgeInsets.only(right: 15),
              decoration: const BoxDecoration(
                color: AppColors.darkBlue,
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
          ),
        ],
      ),
    );
  }
}
