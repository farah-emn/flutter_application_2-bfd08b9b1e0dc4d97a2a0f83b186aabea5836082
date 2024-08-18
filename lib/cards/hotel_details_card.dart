// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel1.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../ui/views/traveller_side_views/hotel_details_view/hotel_details_view.dart';

class HotelDetailsCard extends StatefulWidget {
  HotelDetailsCard({
    super.key,
    required this.size,
    required this.hotelDetails,
    required this.itemIndex,
  });

  final Size size;
  final HotelClass1 hotelDetails;
  final int itemIndex;

  @override
  State<HotelDetailsCard> createState() => _HotelDetailsCardState();
}

class _HotelDetailsCardState extends State<HotelDetailsCard> {
  final HotelRoomsController controller = Get.put(HotelRoomsController());
  CurrencyController currencyController = Get.put(CurrencyController());
  final HotelRoomsController hotelRoomsController =
      Get.put(HotelRoomsController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hotelRoomsController.getAllRoomRatings(widget.hotelDetails.Id ?? '');
    print(hotelRoomsController.HotelaverageRating.value.toDouble());
    return InkWell(
      onTap: () {
        controller.SpecificHotelRooms(widget.hotelDetails.Id);
        Get.to(HotelDetailsView(
          Hotel: widget.hotelDetails,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, right: 15),
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
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.hotelDetails.Image != null &&
                              widget.hotelDetails.Image.isNotEmpty
                          ? widget.hotelDetails.Image
                          : ''),
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
                              widget.hotelDetails.Name,
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
                            color: AppColors.purple,
                            size: 20,
                          ),
                          Text(
                            widget.hotelDetails.location,
                            style: const TextStyle(
                                color: AppColors.grayText,
                                fontSize: TextSize.header2),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBarIndicator(
                            itemSize: 25,
                            rating: ((hotelRoomsController
                                                .HotelaverageRating.value
                                                .toDouble() >
                                            0 ||
                                        hotelRoomsController
                                                .HotelaverageRating.value
                                                .toDouble() ==
                                            0.0) &&
                                    hotelRoomsController
                                            .HotelaverageRating.value
                                            .toDouble() <
                                        1)
                                ? 1
                                : hotelRoomsController.HotelaverageRating.value
                                    .toDouble(),
                            itemBuilder: (_, __) => const Icon(
                              Icons.star_rounded,
                              color: AppColors.gold,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        'Start from:',
                        style: TextStyle(
                          color: AppColors.grayText,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${currencyController.convert(currencyController.selectedCurrency.value, widget.hotelDetails.StartPrice.toDouble())} ',
                            style: TextStyle(
                                color: AppColors.purple,
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            currencyController.selectedCurrency.value,
                            style: TextStyle(
                                color: AppColors.purple,
                                fontSize: TextSize.header2,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
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
