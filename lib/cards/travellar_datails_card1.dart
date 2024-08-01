import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/classes/travellars_class1.dart';

import '../classes/travellars_class.dart';
import '../ui/shared/colors.dart';
import '../ui/views/flight_side_views/flight_booking_details_view.dart';

class TravellarDetailsCard1 extends StatefulWidget {
  TravellarDetailsCard1(
      {super.key, required this.travellarsModel, required this.itemIndex});

  TravellarsClass1 travellarsModel;
  int itemIndex;

  @override
  State<TravellarDetailsCard1> createState() => _TravellarDetailsCard1State();
}

class _TravellarDetailsCard1State extends State<TravellarDetailsCard1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Farah',
                  style: TextStyle(
                      color: AppColors.TextBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.padding,
                      color: AppColors.darkBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Nationality:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Syria',
                      style: TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: AppColors.darkBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Date of birth:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '2001',
                      style: TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: AppColors.darkBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Passboard number:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '05549148855',
                      style: TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: AppColors.darkBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Issuing country:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Syria',
                      style: TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: AppColors.darkBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Expert date:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '2025',
                      style: TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: size.width,
            padding: EdgeInsets.only(right: 15),
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
    );
  }
}
