import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/car_side_finished_card.dart';
import 'package:traveling/cards/hotel_side_finished_card.dart';
import 'package:traveling/cards/travellar_booking_card.dart';
import 'package:traveling/classes/hotel_side_finished_class.dart';
import 'package:traveling/classes/travellar_booking_class.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../../cards/travellar_datails_card.dart';
import '../../../classes/travellars_class.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightBookingDetailsView extends StatefulWidget {
  const FlightBookingDetailsView({super.key});
  @override
  State<FlightBookingDetailsView> createState() =>
      _FlightBookingDetailsViewState();
}

class _FlightBookingDetailsViewState extends State<FlightBookingDetailsView> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Booking details',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkBlue),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: decoration.copyWith(),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: AppColors.gold,
                            ),
                            Text(
                              'Total price:',
                              style: TextStyle(
                                color: AppColors.TextBlackColor,
                                fontSize: TextSize.header1,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '5000',
                              style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: decoration.copyWith(),
                        child: Column(
                          children: [
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
                                      height: 30,
                                    ),
                                    Text(
                                      'Depature Time',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: AppColors.grayText),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                      height: 30,
                                    ),
                                    Text(
                                      'Flight No',
                                      style: TextStyle(
                                          fontSize: TextSize.header1,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'MI0987',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: AppColors.grayText),
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
                                      height: 30,
                                    ),
                                    Text(
                                      'Arrival Time',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: AppColors.grayText),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                      height: 30,
                                    ),
                                    Text(
                                      'Gate',
                                      style: TextStyle(
                                          fontSize: TextSize.header1,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'C6',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: AppColors.grayText),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Travellars',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: travellarsDetails.length,
                          itemBuilder: (context, index) => TravellarDetailsCard(
                            itemIndex: index,
                            // size : size,
                            travellarsModel: travellarsDetails[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
