// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
import 'package:traveling/classes/hotel_bookings_class1.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_booking_details_view.dart';

class HotelFinishedBookingCard extends StatefulWidget {
  const HotelFinishedBookingCard({
    super.key,
    required this.size,
    required this.hotelBookingsDetails,
    required this.itemIndex,
  });

  final Size size;
  final HotelBookingsClass1 hotelBookingsDetails;
  final int itemIndex;

  @override
  State<HotelFinishedBookingCard> createState() =>
      _HotelFinishedBookingCardState();
}

class _HotelFinishedBookingCardState extends State<HotelFinishedBookingCard> {
  final CurrencyController currencyController = Get.put(CurrencyController());

  double? _ratingValue;
  int? IdRatings_hotel;
  User? user;
  final _auth = FirebaseAuth.instance;
  var uid;
  var currentUser;
  var userid;
  @override
  void initState() {
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    userid = _auth.currentUser;

    final databaseReference = FirebaseDatabase.instance.reference();

    DatabaseReference idRatings_hotel = databaseReference.child('RatingsHotel');

    idRatings_hotel.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      print(event.snapshot.children.length);
      if (mounted) {
        setState(() {
          IdRatings_hotel = event.snapshot.children.length + 1;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\');
    print(widget.hotelBookingsDetails.RatingRoom);
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
                        image: NetworkImage(widget.hotelBookingsDetails.image !=
                                    null &&
                                widget.hotelBookingsDetails.image!.isNotEmpty
                            ? widget.hotelBookingsDetails.image
                            : ''),
                        fit: BoxFit.fill,
                      )),
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
                      Column(
                        children: [
                          Text(
                            'Per night',
                            style: TextStyle(
                              color: AppColors.grayText,
                            ),
                          ),
                          Text(
                            '${widget.hotelBookingsDetails.priceNight}\ ${currencyController.getCurrencySymbol(currencyController.selectedCurrency.value)}',
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
                        widget.hotelBookingsDetails.totalPrice.toString(),
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
                          initialRating:
                              widget.hotelBookingsDetails.RatingRoom ?? 1,
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
                              saveRating(
                                  value,
                                  widget.hotelBookingsDetails
                                      .RoomId); // Call the method to save the rating
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

  void saveRating(double rating, String roomId) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final hotelEvent = await ref.child('RatingsHotel').once();

    if (hotelEvent.snapshot.value != null) {
      if (hotelEvent.snapshot.value is Map) {
        Map<dynamic, dynamic> RatingRoom =
            Map<dynamic, dynamic>.from(hotelEvent.snapshot.value as Map);

        bool ratingUpdated = false;

        for (var bookingKey in RatingRoom.keys) {
          var value = RatingRoom[bookingKey];
          if (value != null &&
              value['RoomId'] != null &&
              value['UserId'] != null &&
              value['RoomId'] == roomId &&
              uid.toString() == value['UserId']) {
            await ref.child('RatingsHotel/$bookingKey').update(
                {"UserId": uid.toString(), "RoomId": roomId, "Rating": rating});
            ratingUpdated = true;
            break;
          }
        }

        if (!ratingUpdated) {
          await ref.child('RatingsHotel/$IdRatings_hotel').set(
              {"UserId": uid.toString(), "RoomId": roomId, "Rating": rating});
          setState(() {
            IdRatings_hotel = (IdRatings_hotel ?? 0) + 1;
          });
        }
      } else if (hotelEvent.snapshot.value is List) {
        List<dynamic> RatingRoom =
            List<dynamic>.from(hotelEvent.snapshot.value as List);

        bool ratingUpdated = false;

        for (int i = 0; i < RatingRoom.length; i++) {
          var value = RatingRoom[i];
          if (value != null &&
              value['RoomId'] != null &&
              value['UserId'] != null &&
              value['RoomId'] == roomId &&
              uid.toString() == value['UserId']) {
            await ref.child('RatingsHotel/$i').update(
                {"UserId": uid.toString(), "RoomId": roomId, "Rating": rating});
            ratingUpdated = true;
            break;
          }
        }

        if (!ratingUpdated) {
          await ref.child('RatingsHotel/$IdRatings_hotel').set(
              {"UserId": uid.toString(), "RoomId": roomId, "Rating": rating});
          setState(() {
            IdRatings_hotel = (IdRatings_hotel ?? 0) + 1;
          });
        }
      }
    } else {
      await ref
          .child('RatingsHotel/$IdRatings_hotel')
          .set({"UserId": uid.toString(), "RoomId": roomId, "Rating": rating});
      setState(() {
        IdRatings_hotel = (IdRatings_hotel ?? 0) + 1;
      });
    }
  }

  void rateTwoCards(
      double rating1, String roomId1, double rating2, String roomId2) async {
    saveRating(rating1, roomId1);
    saveRating(rating2, roomId2);
  }
}
