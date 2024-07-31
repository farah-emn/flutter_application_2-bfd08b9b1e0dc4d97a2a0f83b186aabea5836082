import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_booking_details_view.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_details_view.dart';
import 'package:traveling/ui/views/traveller_side_views/room_view.dart';

class HotelFinishedBookingCard extends StatefulWidget {
  const HotelFinishedBookingCard({
    super.key,
    required this.size,
    required this.hotelBookingsDetails,
    required this.itemIndex,
  });

  final Size size;
  final HotelBookingsClass hotelBookingsDetails;
  final int itemIndex;

  @override
  State<HotelFinishedBookingCard> createState() =>
      _HotelFinishedBookingCardState();
}

class _HotelFinishedBookingCardState extends State<HotelFinishedBookingCard> {
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(
          HotelBookingDetailsView(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: decoration.copyWith(),
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'How was your stay?',
                        style: TextStyle(
                          fontSize: TextSize.header1,
                        ),
                      ),
                      Spacer(),
                      RatingBar(
                          initialRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30,
                          ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.gold,
                              ),
                              half: const Icon(
                                Icons.star_half_rounded,
                                color: AppColors.gold,
                              ),
                              empty: const Icon(
                                Icons.star_outline_rounded,
                                color: AppColors.gold,
                              )),
                          onRatingUpdate: (value) {
                            setState(() {
                              _ratingValue = value;
                            });
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
