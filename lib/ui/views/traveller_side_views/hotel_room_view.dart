// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, must_be_immutable, non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/amenities_card.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_room_photos.dart';

import 'hotel_booking_summary_view.dart';

class RoomView extends StatefulWidget {
  List<AmenitiesClass>? Amenities = [];
  RoomDetailsClass Room;
  String HotelId;

  RoomView(
      {super.key, this.Amenities, required this.Room, required this.HotelId});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  final CurrencyController currencycontroller = Get.put(CurrencyController());
  final HotelRoomsController hotelRoomsController =
      Get.put(HotelRoomsController());
  double? RoomRating = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      hotelRoomsController.getRoomRating(widget.Room.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.lightPurple,
            elevation: 0,
            pinned: true,
            expandedHeight: 300,
            toolbarHeight: 100,
            collapsedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: 300,
                    child: Image(
                        image: NetworkImage(widget.Room.RoomPhoto![0]),
                        fit: BoxFit.fill),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundgrayColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.Room.Overview,
                      style: TextStyle(
                        fontSize: TextSize.header1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leadingWidth: size.width,
            leading: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.backgroundgrayColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Stack(
                      children: [
                        (widget.Room.RoomPhoto!.length >= 2)
                            ? Container(
                                width: size.width / 2.2,
                                height: size.width / 2.2,
                                // margin: EdgeInsets.only(top: 370),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.Room.RoomPhoto![1]),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : SizedBox(),
                        (widget.Room.RoomPhoto!.length >= 3)
                            ? Container(
                                width: ((size.width / 2.2) / 2) - 5,
                                height: ((size.width / 2.2) / 2) - 5,
                                margin: EdgeInsets.only(
                                  left: (size.width / 2.2) + 10,
                                  //  top: 370
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.Room.RoomPhoto![2]),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : SizedBox(),
                        (widget.Room.RoomPhoto!.length >= 4)
                            ? Container(
                                width: ((size.width / 2.2) / 2) - 5,
                                height: ((size.width / 2.2) / 2) - 5,
                                margin: EdgeInsets.only(
                                    left: (size.width / 2.2) + 10,
                                    top: ((size.width / 2.2) / 2) + 5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.Room.RoomPhoto![3]),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : SizedBox(),
                        (widget.Room.RoomPhoto!.length >= 5)
                            ? Container(
                                width: ((size.width / 2.2) / 2) - 5,
                                height: ((size.width / 2.2) / 2) - 5,
                                margin: EdgeInsets.only(
                                  left: (size.width / 2.2) +
                                      10 +
                                      ((size.width / 2.2) / 2) +
                                      5,
                                  // top: 370
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.Room.RoomPhoto![4]),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : SizedBox(),
                        Stack(
                          children: [
                            (widget.Room.RoomPhoto!.length >= 6)
                                ? Container(
                                    width: ((size.width / 2.2) / 2) - 5,
                                    height: ((size.width / 2.2) / 2) - 5,
                                    margin: EdgeInsets.only(
                                        left: (size.width / 2.2) +
                                            10 +
                                            ((size.width / 2.2) / 2) +
                                            5,
                                        top: ((size.width / 2.2) / 2) + 5),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(88, 158, 158, 158),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.Room.RoomPhoto![5]),
                                          fit: BoxFit.fill),
                                    ),
                                  )
                                : SizedBox(),
                            (6 < widget.Room.RoomPhoto!.length &&
                                    widget.Room.RoomPhoto![6].isNotEmpty)
                                ? InkWell(
                                    onTap: () {
                                      Get.to(
                                        HotelRoomPhotos(
                                          RoomPhotos:
                                              widget.Room.RoomPhoto!.sublist(5),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: ((size.width / 2.2) / 2) - 5,
                                      height: ((size.width / 2.2) / 2) - 5,
                                      margin: EdgeInsets.only(
                                          left: (size.width / 2.2) +
                                              10 +
                                              ((size.width / 2.2) / 2) +
                                              5,
                                          top: ((size.width / 2.2) / 2) + 5),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(178, 33, 33, 33),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            (6 < widget.Room.RoomPhoto!.length &&
                                    widget.Room.RoomPhoto![6].isNotEmpty)
                                ? InkWell(
                                    onTap: () {
                                      Get.to(
                                        HotelRoomPhotos(
                                          RoomPhotos:
                                              widget.Room.RoomPhoto!.sublist(5),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: (size.width / 2.2) +
                                              10 +
                                              ((size.width / 2.2) / 2) +
                                              25,
                                          top: ((size.width / 2.2) / 2) + 35),
                                      child: Text(
                                        '+${widget.Room.RoomPhoto!.sublist(5).length.toString()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'About Room',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.window,
                                    color: AppColors.purple,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Partial Sea View',
                                    style: const TextStyle(
                                        color: AppColors.grayText,
                                        fontSize: TextSize.header2),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.space_bar,
                                    color: AppColors.purple,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '200 m',
                                    style: const TextStyle(
                                        color: AppColors.grayText,
                                        fontSize: TextSize.header2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.bed,
                                    color: AppColors.purple,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '2 Beds',
                                    style: const TextStyle(
                                        color: AppColors.grayText,
                                        fontSize: TextSize.header2),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.attach_money,
                                    color: AppColors.purple,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '200 /per night',
                                    style: const TextStyle(
                                        color: AppColors.grayText,
                                        fontSize: TextSize.header2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //    Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    //   child: Row(
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               const Icon(
                    //                 Icons.window,
                    //                 color: AppColors.purple,
                    //                 size: 20,
                    //               ),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 '${widget.Room.NumberOfRooms} Rooms',
                    //                 style: const TextStyle(
                    //                     color: AppColors.grayText,
                    //                     fontSize: TextSize.header2),
                    //               ),
                    //             ],
                    //           ),
                    //           Row(
                    //             children: [
                    //               const Icon(
                    //                 Icons.space_bar,
                    //                 color: AppColors.purple,
                    //                 size: 20,
                    //               ),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 '${widget.Room.NumberOfBedrooms.toString()} Bed rooms',
                    //                 style: const TextStyle(
                    //                     color: AppColors.grayText,
                    //                     fontSize: TextSize.header2),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         width: 50,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               const Icon(
                    //                 Icons.bed,
                    //                 color: AppColors.purple,
                    //                 size: 20,
                    //               ),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 '${widget.Room.NumberOfBeds} Beds',
                    //                 style: const TextStyle(
                    //                     color: AppColors.grayText,
                    //                     fontSize: TextSize.header2),
                    //               ),
                    //             ],
                    //           ),
                    //           Row(
                    //             children: [
                    //               const Icon(
                    //                 Icons.attach_money,
                    //                 color: AppColors.purple,
                    //                 size: 20,
                    //               ),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 '${currencycontroller.convert(currencycontroller.selectedCurrency.value, widget.Room.Price.toDouble())} /per night',
                    //                 style: const TextStyle(
                    //                     color: AppColors.grayText,
                    //                     fontSize: TextSize.header2),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       margin: const EdgeInsets.symmetric(vertical: 20),
                    //       width: size.width - 50,
                    //       height: 1,
                    //       color: AppColors.LightGrayColor,
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Amenities',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (hotelRoomsController.averageRating.value < 1)
                                  ? Text(
                                      '1',
                                      style: TextStyle(fontSize: 50),
                                    )
                                  : Text(
                                      hotelRoomsController.averageRating.value
                                          .toString(),
                                      style: TextStyle(fontSize: 50),
                                    ),
                              RatingBarIndicator(
                                itemSize: 25,
                                rating: (hotelRoomsController
                                            .averageRating.value <
                                        1)
                                    ? 1
                                    : hotelRoomsController.averageRating.value,
                                itemBuilder: (_, __) => Icon(
                                  Icons.star_rounded,
                                  color: AppColors.gold,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('5'),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: size.width / 2,
                                    child: LinearProgressIndicator(
                                      minHeight: 15,
                                      value: hotelRoomsController
                                                  .averageRating.value >=
                                              5
                                          ? 1
                                          : (5 -
                                                      hotelRoomsController
                                                          .averageRating.value <
                                                  1
                                              ? 5 -
                                                  hotelRoomsController
                                                      .averageRating.value
                                              : 0),
                                      color: AppColors.purple,
                                      backgroundColor: AppColors.lightPurple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('4'),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: size.width / 2,
                                    child: LinearProgressIndicator(
                                      minHeight: 15,
                                      value: hotelRoomsController
                                                  .averageRating.value >=
                                              4
                                          ? 1
                                          : (4 -
                                                      hotelRoomsController
                                                          .averageRating.value <
                                                  1
                                              ? 4 -
                                                  hotelRoomsController
                                                      .averageRating.value
                                              : 0),
                                      color: AppColors.purple,
                                      backgroundColor: AppColors.lightPurple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('3'),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: size.width / 2,
                                    child: LinearProgressIndicator(
                                      minHeight: 15,
                                      value: hotelRoomsController
                                                  .averageRating.value >=
                                              3
                                          ? 1
                                          : (3 -
                                                      hotelRoomsController
                                                          .averageRating.value <
                                                  1
                                              ? 3 -
                                                  hotelRoomsController
                                                      .averageRating.value
                                              : 0),
                                      color: AppColors.purple,
                                      backgroundColor: AppColors.lightPurple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('2'),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: size.width / 2,
                                    child: LinearProgressIndicator(
                                      minHeight: 15,
                                      value: hotelRoomsController
                                                  .averageRating.value >=
                                              2
                                          ? 1
                                          : (2 -
                                                      hotelRoomsController
                                                          .HotelaverageRating
                                                          .value <
                                                  1
                                              ? 2 -
                                                  hotelRoomsController
                                                      .HotelaverageRating.value
                                              : 0),
                                      color: AppColors.purple,
                                      backgroundColor: AppColors.lightPurple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('1'),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: size.width / 2,
                                    child: LinearProgressIndicator(
                                      minHeight: 15,
                                      value: hotelRoomsController
                                                  .averageRating.value >=
                                              1
                                          ? 1
                                          : (1 -
                                                      hotelRoomsController
                                                          .averageRating.value <
                                                  1
                                              ? 1
                                              : 0),
                                      color: AppColors.purple,
                                      backgroundColor: AppColors.lightPurple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          BookingSummaryView(
                              Room: widget.Room, Hotel: widget.HotelId),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                            text: 'Booking Now',
                            textColor: Colors.white,
                            widthPercent: size.width,
                            backgroundColor: AppColors.purple),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateModulus(String Num1, String Num2) {
    double result = 0;
    final double num1 = double.parse(Num1);
    final double num2 = double.parse(Num2);
    if (num1 < num2) {
      setState(() {
        result = 0;
      });
    } else if (num1 > num2) {
      setState(() {
        result = num1 - num2;
      });
    }
    return result;
  }
}
