import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/text_size.dart';

import '../classes/travellars_class.dart';
import '../ui/shared/colors.dart';
import '../ui/views/flight_side_views/flight_booking_details_view.dart';

class TravellarDetailsCard extends StatefulWidget {
  TravellarDetailsCard(
      {super.key, required this.travellarsModel, required this.itemIndex});

  TravellarsClass travellarsModel;
  int itemIndex;

  @override
  State<TravellarDetailsCard> createState() => _TravellarDetailsCardState();
}

class _TravellarDetailsCardState extends State<TravellarDetailsCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(),
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Farah',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.book,
                          color: AppColors.gold,
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
                    Row(
                      children: [
                        Icon(
                          Icons.padding,
                          color: AppColors.gold,
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
                          color: AppColors.gold,
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
                          color: AppColors.gold,
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
                          color: AppColors.gold,
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
            ],
          ),
        ),
      ],
    );
  }
}
