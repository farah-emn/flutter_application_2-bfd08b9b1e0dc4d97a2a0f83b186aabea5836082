// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/amenities_card.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/car_class.dart';
import 'package:traveling/classes/car_class1.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_room_photos.dart';
import 'package:traveling/ui/views/traveller_side_views/booking_car_summary_view.dart';

import '../../../../classes/amenities_class.dart';
import '../../../../classes/amenities_class1.dart';
import '../car_details_Photos.dart';
import 'car_map_view.dart';

class CarDetailsView extends StatefulWidget {
  CarClass1 CarDeails;
  CarDetailsView({
    super.key,
    required this.CarDeails,
  });
  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  @override
  Widget build(BuildContext context) {
    print(widget.CarDeails.pickupLocation);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.lightGray,
              elevation: 0,
              pinned: true,
              expandedHeight: 350,
              toolbarHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      height: 350,
                      child: Image(
                        image: NetworkImage(widget.CarDeails.image!.first),
                        fit: BoxFit.fill,
                      ),
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
                        "   ${widget.CarDeails.company}-${widget.CarDeails.model}",
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
                    Row(
                      children: [
                        // Icon(
                        //   Icons.edit,
                        //   color: Colors.white,
                        //   size: 25,
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // Icon(
                        //   Icons.favorite_rounded,
                        //   color: Colors.white,
                        //   size: 25,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.backgroundgrayColor,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Stack(
                        children: [
                          (widget.CarDeails.image!.length >= 2)
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
                                            widget.CarDeails.image![1]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          (widget.CarDeails.image!.length >= 3)
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
                                            widget.CarDeails.image![2]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          (widget.CarDeails.image!.length >= 4)
                              ? Container(
                                  width: ((size.width / 2.2) / 2) - 5,
                                  height: ((size.width / 2.2) / 2) - 5,
                                  margin: EdgeInsets.only(
                                      left: (size.width / 2.2) + 10,
                                      top: ((size.width / 2.2) / 2) + 5),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.CarDeails.image![3]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          (widget.CarDeails.image!.length >= 5)
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
                                            widget.CarDeails.image![4]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          Stack(
                            children: [
                              (widget.CarDeails.image!.length >= 6)
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
                                        color:
                                            Color.fromARGB(88, 158, 158, 158),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.CarDeails.image![5]),
                                            fit: BoxFit.fill),
                                      ),
                                    )
                                  : SizedBox(),
                              (6 < widget.CarDeails.image!.length &&
                                      widget.CarDeails.image![6].isNotEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(
                                          CarPhotos(
                                            carPhotos: widget.CarDeails.image!
                                                .sublist(5),
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
                                          color:
                                              Color.fromARGB(178, 33, 33, 33),
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              (6 < widget.CarDeails.image!.length &&
                                      widget.CarDeails.image![6].isNotEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(
                                          HotelRoomPhotos(
                                            RoomPhotos: widget.CarDeails.image!
                                                .sublist(5),
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
                                          '+${widget.CarDeails.image!.sublist(5).length.toString()}',
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
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Car rental company: ',
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Text(
                              widget.CarDeails.companyRentailName,
                              style: TextStyle(
                                  fontSize: TextSize.header2,
                                  color: AppColors.grayText),
                            ),
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
                            'Plate number: ',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.CarDeails.plate,
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: size.width - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.speed,
                                  color: AppColors.darkGray,
                                  size: 35,
                                ),
                                Text(
                                  widget.CarDeails.topSpeed,
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.darkGray),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.color_lens_rounded,
                                  color: AppColors.darkGray,
                                  size: 35,
                                ),
                                Text(
                                  widget.CarDeails.color,
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.grayText),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.directions_car_rounded,
                                  color: AppColors.darkGray,
                                  size: 35,
                                ),
                                Text(
                                  widget.CarDeails.ger,
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.grayText),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.flight_class,
                                  color: AppColors.darkGray,
                                  size: 35,
                                ),
                                Text(
                                  widget.CarDeails.seats,
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.grayText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 15, left: 15),
                      //   child: SizedBox(
                      //     height: 70,
                      //     width: size.width,
                      //     child: Expanded(
                      //       child: ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         shrinkWrap: true,
                      //         itemCount: widget.Amenities.length,
                      //         itemBuilder: (context, index) => AmenitiesCard(
                      //           itemIndex: index,
                      //           amenitiesModel: widget.Amenities[index],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),

                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Rating and review',
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '4.5',
                                  style: TextStyle(fontSize: 50),
                                ),
                                RatingBarIndicator(
                                  itemSize: 25,
                                  rating: 4.5,
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: size.width / 2,
                                        child: LinearProgressIndicator(
                                          minHeight: 15,
                                          value: 0.8,
                                          color: AppColors.darkGray,
                                          backgroundColor: AppColors.lightGray,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('4'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: size.width / 2,
                                        child: LinearProgressIndicator(
                                          minHeight: 15,
                                          value: 0.7,
                                          color: AppColors.darkGray,
                                          backgroundColor: AppColors.lightGray,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('3'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: size.width / 2,
                                        child: LinearProgressIndicator(
                                          minHeight: 15,
                                          value: 0.8,
                                          color: AppColors.darkGray,
                                          backgroundColor: AppColors.lightGray,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('2'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: size.width / 2,
                                        child: LinearProgressIndicator(
                                          minHeight: 15,
                                          value: 0.5,
                                          color: AppColors.darkGray,
                                          backgroundColor: AppColors.lightGray,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('1'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: size.width / 2,
                                      child: LinearProgressIndicator(
                                        minHeight: 15,
                                        value: 0.2,
                                        color: AppColors.darkGray,
                                        backgroundColor: AppColors.lightGray,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: () {
                            Get.to(BookingCarSummaryView(
                                CarDeails: widget.CarDeails));
                          },
                          child: CustomButton(
                            text: 'Search',
                            textColor: AppColors.backgroundgrayColor,
                            backgroundColor: AppColors.darkGray,
                            widthPercent: size.width,
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(CarMapView(
                      //       Location: widget.CarDeails.pickupLocation,
                      //     ));
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
