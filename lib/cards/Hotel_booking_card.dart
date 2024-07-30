import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_details_view.dart';
import 'package:traveling/ui/views/traveller_side_views/room_view.dart';

class HotelBookingCard extends StatefulWidget {
  const HotelBookingCard({
    super.key,
    required this.size,
    required this.hotelBookingsDetails,
    required this.itemIndex,
  });

  final Size size;
  final HotelBookingsClass hotelBookingsDetails;
  final int itemIndex;

  @override
  State<HotelBookingCard> createState() => _HotelBookingCardState();
}

class _HotelBookingCardState extends State<HotelBookingCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(
          RoomView(),
        );
      },
      child: Container(
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
                      image: AssetImage(widget.hotelBookingsDetails.image),
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
                                  widget.hotelBookingsDetails.hotelName,
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
                                Icons.location_on,
                                color: AppColors.gold,
                                size: 20,
                              ),
                              Text(
                                widget.hotelBookingsDetails.location,
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
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
                            'Per night',
                            style: TextStyle(
                              color: AppColors.grayText,
                            ),
                          ),
                          Text(
                            '100\$',
                            style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
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
                              'Check In',
                              style: TextStyle(
                                  fontSize: TextSize.header2,
                                  color: AppColors.grayText),
                            ),
                            Text(
                              widget.hotelBookingsDetails.checkinDate,
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
                                  'Check Out',
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.grayText),
                                ),
                                Text(
                                  widget.hotelBookingsDetails.checkoutDate,
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
                        "Room Number:",
                        style: TextStyle(
                            color: AppColors.grayText,
                            fontSize: TextSize.header2),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.hotelBookingsDetails.roomNumber,
                        style: const TextStyle(
                            fontSize: TextSize.header2,
                            fontWeight: FontWeight.w500),
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
                        widget.hotelBookingsDetails.totalPrice,
                        style: const TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: TextSize.header1,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomButton(
                          text: 'Edit Booking',
                          textColor: Colors.white,
                          widthPercent: size.width / 2 - 30,
                          heightPercent: 50,
                          backgroundColor: AppColors.darkBlue),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                          text: 'Delete Booking',
                          textColor: Colors.black,
                          widthPercent: size.width / 2 - 30,
                          heightPercent: 50,
                          backgroundColor: AppColors.LightGrayColor),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
