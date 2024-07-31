import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/classes/travellar_booking_class.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view3.dart';

import '../classes/travellars_class.dart';
import '../ui/shared/colors.dart';


class TravellarBookingCard extends StatefulWidget {
  TravellarBookingCard(
      {super.key,
      required this.travellarsBookingModel,
      required this.itemIndex});

  TravellarBookingClass travellarsBookingModel;
  int itemIndex;

  @override
  State<TravellarBookingCard> createState() => _TravellarBookingCardState();
}

class _TravellarBookingCardState extends State<TravellarBookingCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: size.width,
      decoration: decoration.copyWith(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.travellarsBookingModel.name,
                  style: const TextStyle(
                      color: AppColors.TextBlackColor,
                      fontSize: TextSize.header1,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.gold,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Claas:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.travellarsBookingModel.classType,
                      style: const TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.airline_seat_recline_extra_rounded,
                      color: AppColors.gold,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Seat Number:',
                      style: TextStyle(
                          color: AppColors.TextBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.travellarsBookingModel.seatNumber,
                      style: const TextStyle(
                        color: AppColors.TextBlackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
           InkWell(
            onTap: () {
              Get.to(const TravellerDetailsView3());
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
