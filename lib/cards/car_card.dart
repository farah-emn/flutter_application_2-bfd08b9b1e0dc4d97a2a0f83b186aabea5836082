import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/car_class.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/car_side_views/car_details_view.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_details_view.dart';

class CarCard extends StatefulWidget {
  const CarCard({
    super.key,
    required this.size,
    required this.carDetails,
    required this.itemIndex,
  });

  final Size size;
  final CarClass carDetails;
  final int itemIndex;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          CarDetailsView(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: List.filled(
            10,
            const BoxShadow(
                color: AppColors.gray,
                blurRadius: BorderSide.strokeAlignOutside,
                blurStyle: BlurStyle.outer),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: widget.size.width - 30,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  width: widget.size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(widget.carDetails.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            child: Text(
                              widget.carDetails.company +
                                  ' - ' +
                                  widget.carDetails.model,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: TextSize.header1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.directions_car_rounded,
                                color: AppColors.darkGray,
                                size: 20,
                              ),
                              Text(
                                widget.carDetails.model,
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.flight_class_rounded,
                                color: AppColors.darkGray,
                                size: 20,
                              ),
                              Text(
                                widget.carDetails.seats,
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.speed,
                                color: AppColors.darkGray,
                                size: 20,
                              ),
                              Text(
                                widget.carDetails.topSpeed,
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_half_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Column(
                    children: [
                      Text(
                        'Per day:',
                        style: TextStyle(
                          color: AppColors.grayText,
                        ),
                      ),
                      Text(
                        '500\$',
                        style: TextStyle(
                            color: AppColors.darkGray,
                            fontSize: TextSize.header1,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
