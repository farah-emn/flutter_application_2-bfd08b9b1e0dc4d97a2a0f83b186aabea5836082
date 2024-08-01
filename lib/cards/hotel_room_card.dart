// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, deprecated_member_use, unused_field, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_room_view.dart';
import '../classes/hotel_room_details_class.dart';

class RoomCardHotel extends StatefulWidget {
  RoomCardHotel({
    super.key,
    required this.size,
    required this.room,
    required this.itemIndex,
  });

  final Size size;
  final RoomDetailsClass room;
  final int itemIndex;
  @override
  State<RoomCardHotel> createState() => _RoomCardHotelState();
}

class _RoomCardHotelState extends State<RoomCardHotel> {
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());
  late User loggedinUser;
  final _auth = FirebaseAuth.instance;
  Map<dynamic, dynamic> RoomData = {};
  List<RoomDetailsClass> HotelRoom = [];
  List<AmenitiesClass> Amenities = [];
  double incoming = 0.0;
  int completedFlight = 0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (mounted) {
      fetchAmenities().then((fetchAmenities) {});
    }
  }

  Future<Map> fetchAmenities() async {
    FirebaseDatabase.instance
        .reference()
        .child('Room')
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var RoomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        RoomData.forEach((Roomkey, value) {
          if (Roomkey == widget.room.id) {
            Amenities.clear(); // Clear the Amenities list here
            if (mounted) {
              setState(() {
                if (value['isCheckedFreeWifi']) {
                  Amenities.add(AmenitiesClass(
                      icon: Icons.wifi_rounded, title: 'Free Wifi'));
                }

                if (value['isCheckedFoodAnddrink']) {
                  Amenities.add(AmenitiesClass(
                      icon: Icons.coffee, title: 'Food & drink'));
                }

                if (value['isCheckedPrivatePool']) {
                  Amenities.add(
                      AmenitiesClass(icon: Icons.pool, title: 'Private Pool'));
                }
                if (value['isCheckedPrivateParking']) {
                  Amenities.add(AmenitiesClass(
                      icon: Icons.local_parking_rounded,
                      title: 'Private parking'));
                }

                if (value['isCheckedCleaningServices']) {
                  Amenities.add(AmenitiesClass(
                      icon: Icons.cleaning_services_rounded,
                      title: 'Cleaning services'));
                }
              });
            }
          }
        });
      }
    });

    return RoomData;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.room.is_reserved);
    return InkWell(
      onTap: () {
        Get.to(
          HotelRoomView(Room: widget.room, Amenities: Amenities),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
        width: widget.size.width,
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
                      image: NetworkImage(widget.room.RoomPhoto != null &&
                              widget.room.RoomPhoto!.isNotEmpty
                          ? widget.room.RoomPhoto!.first
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
                      SizedBox(
                        child: Text(
                          widget.room.Overview,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: TextSize.header1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.purple,
                                size: 20,
                              ),
                              (widget.room.is_reserved == true)
                                  ? Text(
                                      'Reserved',
                                      style: TextStyle(
                                          color: AppColors.grayText,
                                          fontSize: TextSize.header2),
                                    )
                                  : Text(
                                      'Not reserved',
                                      style: TextStyle(
                                          color: AppColors.grayText,
                                          fontSize: TextSize.header2),
                                    ),
                            ],
                          ),
                          Row(
                            children: const [
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
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${HotelCurrency_Controller.convert('USD', HotelCurrency_Controller.selectedCurrency.value, widget.room.Price.toDouble())} ${HotelCurrency_Controller.selectedCurrency.value}',
                            style: const TextStyle(
                                color: AppColors.purple,
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
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
