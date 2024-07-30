import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_details._view.dart';

import '../classes/flight_details_class.dart';
import '../ui/shared/colors.dart';
import '../ui/views/flight_side_views/flight_flight_details_view.dart';

class FlightDetailsCard extends StatefulWidget {
  FlightDetailsCard(
      {super.key, required this.flightModel, required this.itemIndex});
  FlightDetailsClass flightModel;
  int itemIndex;

  @override
  State<FlightDetailsCard> createState() => _FlightDetailsCardState();
}

class _FlightDetailsCardState extends State<FlightDetailsCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(const FlightFlightDetailsView());
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
                                widget.flightModel.deparureTime,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const Text(
                                'AM',
                                style: TextStyle(
                                  color: AppColors.TextgrayColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Direct',
                            style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontSize: 12,
                            ),
                          ),
                          const Text(
                            '02h 25m',
                            style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.flightModel.arrivalTime,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const Text(
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
                              widget.flightModel.fromAirport,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                          ),
                          Text(
                            widget.flightModel.fromCity,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppColors.TextgrayColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: size.width / 2 + 30,
                            child: Text(
                              widget.flightModel.toAirport,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                          ),
                          Text(
                            widget.flightModel.toCity,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppColors.TextgrayColor),
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
                            widget.flightModel.depatureDate,
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
      ),
    );
  }
}
