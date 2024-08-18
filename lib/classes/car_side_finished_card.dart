import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../classes/car_side_upcoming_class1.dart';
import '../controllers/currency_controller.dart';

class CarSideFinishedCard extends StatefulWidget {
  const CarSideFinishedCard({
    super.key,
    required this.size,
    required this.carBookingsDetails,
    required this.itemIndex,
  });

  final Size size;
  final carSideBookingsClass1 carBookingsDetails;
  final int itemIndex;

  @override
  State<CarSideFinishedCard> createState() => _CarSideFinishedCardState();
}

class _CarSideFinishedCardState extends State<CarSideFinishedCard> {
  CurrencyController currencyController = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
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
                    image: NetworkImage(
                        widget.carBookingsDetails.image != null &&
                                widget.carBookingsDetails.image.isNotEmpty
                            ? widget.carBookingsDetails.image
                            : ''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                widget.carBookingsDetails.customerName ?? '',
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
                          children: [
                            const Icon(
                              Icons.email_rounded,
                              color: AppColors.gold,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.carBookingsDetails.email ?? '',
                              style: const TextStyle(
                                  color: AppColors.grayText,
                                  fontSize: TextSize.header2),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                        vertical: 10,
                      ),
                      width: size.width - 60,
                      height: 1,
                      color: AppColors.LightGrayColor,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width / 2 - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pick up date',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText),
                          ),
                          Text(
                            widget.carBookingsDetails.pickupDate,
                            style: const TextStyle(
                                fontSize: TextSize.header2,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width / 2 - 40,
                      child: Row(
                        children: [
                          Container(
                            width: 1,
                            height: 40,
                            color: AppColors.LightGrayColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Drop off date',
                                style: TextStyle(
                                    fontSize: TextSize.header2,
                                    color: AppColors.grayText),
                              ),
                              Text(
                                widget.carBookingsDetails.dropoffDate,
                                style: const TextStyle(
                                    fontSize: TextSize.header2,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      width: size.width - 60,
                      height: 1,
                      color: AppColors.LightGrayColor,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                          color: AppColors.grayText,
                          fontSize: TextSize.header2),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${currencyController.convert(currencyController.selectedCurrency.value, widget.carBookingsDetails.totalPrice.toDouble())} ${currencyController.selectedCurrency.value}',
                      style: const TextStyle(
                          color: AppColors.orange,
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View tenant details",
                      style: TextStyle(
                          color: AppColors.grayText,
                          fontSize: TextSize.header2),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.LightGrayColor,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View car details",
                      style: TextStyle(
                        color: AppColors.grayText,
                        fontSize: TextSize.header2,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.LightGrayColor,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'Customer Rating',
                  style: TextStyle(
                    fontSize: TextSize.header2,
                  ),
                ),
                Spacer(),
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
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
