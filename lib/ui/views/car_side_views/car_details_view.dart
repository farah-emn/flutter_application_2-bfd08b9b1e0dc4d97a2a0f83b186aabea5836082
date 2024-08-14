// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/car_class1.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'car_photos.dart';

class CarDetailsView extends StatefulWidget {
  CarClass1 carDetails;
  CarDetailsView({
    super.key,
    required this.carDetails,
  });
  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  @override
  Widget build(BuildContext context) {
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
                        image: NetworkImage(widget.carDetails.image!.first),
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
                        '${widget.carDetails.company} - ${widget.carDetails.model}',
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
                          (widget.carDetails.image!.length >= 2)
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
                                            widget.carDetails.image![1]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          (widget.carDetails.image!.length >= 3)
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
                                            widget.carDetails.image![2]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          (widget.carDetails.image!.length >= 4)
                              ? Container(
                                  width: ((size.width / 2.2) / 2) - 5,
                                  height: ((size.width / 2.2) / 2) - 5,
                                  margin: EdgeInsets.only(
                                      left: (size.width / 2.2) + 10,
                                      top: ((size.width / 2.2) / 2) + 5),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.carDetails.image![3]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          (widget.carDetails.image!.length >= 5)
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
                                            widget.carDetails.image![4]),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : SizedBox(),
                          Stack(
                            children: [
                              (widget.carDetails.image!.length >= 6)
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
                                                widget.carDetails.image![5]),
                                            fit: BoxFit.fill),
                                      ),
                                    )
                                  : SizedBox(),
                              (6 < widget.carDetails.image!.length &&
                                      widget.carDetails.image![6].isNotEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(
                                          CarPhotos(
                                            carPhotos: widget.carDetails.image!
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
                              (6 < widget.carDetails.image!.length &&
                                      widget.carDetails.image![6].isNotEmpty)
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(
                                          CarPhotos(
                                            carPhotos: widget.carDetails.image!
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
                                          '+${widget.carDetails.image!.sublist(5).length.toString()}',
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
                            'Car rental company:  ',
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Text(
                              widget.carDetails.companyRentailName,
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
                            '1152',
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
                                  '280',
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.grayText),
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
                                  'Red',
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
                                  'Automatic',
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
                                  '4 Seats',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //     body: SafeArea(
      //   child: Stack(
      //     children: [
      //       Image(
      //         image: AssetImage('assets/image/png/hotelRoom.png'),
      //         fit: BoxFit.fill,
      //         width: screenWidth(1),
      //       ),
      //       Padding(
      //           padding: EdgeInsets.only(top: 20, left: 15, right: 15),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Icon(Icons.arrow_back_ios,
      //                       color: Color.fromARGB(255, 255, 255, 255)),
      //                   ImageIcon(
      //                     AssetImage('assets/image/png/favorite.png'),
      //                     color: Colors.white,
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: 260,
      //               ),
      //               Text(
      //                 'Deluxe Room - 2 Twin Beds ',
      //                 style: TextStyle(
      //                   fontSize: screenWidth(21),
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ],
      //           )),

      //       Padding(
      //         padding: EdgeInsetsDirectional.only(top: screenWidth(1.2)),
      //         child: Image.asset(
      //           'assets/image/png/background1.png',
      //           width: screenWidth(1),
      //           fit: BoxFit.fill,
      //         ),
      //       ),
      //       // SizedBox(
      //       //   height: 500,
      //       // ),
      // Padding(
      //   padding: const EdgeInsets.only(top: 370),
      //   child: ListView(children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 15),
      //           child: Stack(
      //             children: [
      //               Container(
      //                 width: size.width / 2.2,
      //                 height: size.width / 2.2,
      //                 // margin: EdgeInsets.only(top: 370),
      //                 decoration: const BoxDecoration(
      //                   borderRadius: BorderRadius.only(
      //                       topLeft: Radius.circular(15),
      //                       bottomLeft: Radius.circular(15)),
      //                   image: DecorationImage(
      //                       image: AssetImage('assets/image/png/room1.png'),
      //                       fit: BoxFit.fill),
      //                 ),
      //               ),
      //               Container(
      //                 width: ((size.width / 2.2) / 2) - 5,
      //                 height: ((size.width / 2.2) / 2) - 5,
      //                 margin: EdgeInsets.only(
      //                   left: (size.width / 2.2) + 10,
      //                   //  top: 370
      //                 ),
      //                 decoration: const BoxDecoration(
      //                   image: DecorationImage(
      //                       image: AssetImage('assets/image/png/room2.png'),
      //                       fit: BoxFit.fill),
      //                 ),
      //               ),
      //               Container(
      //                 width: ((size.width / 2.2) / 2) - 5,
      //                 height: ((size.width / 2.2) / 2) - 5,
      //                 margin: EdgeInsets.only(
      //                     left: (size.width / 2.2) + 10,
      //                     top: ((size.width / 2.2) / 2) + 5),
      //                 decoration: const BoxDecoration(
      //                   image: DecorationImage(
      //                       image: AssetImage('assets/image/png/room3.png'),
      //                       fit: BoxFit.fill),
      //                 ),
      //               ),
      //               Container(
      //                 width: ((size.width / 2.2) / 2) - 5,
      //                 height: ((size.width / 2.2) / 2) - 5,
      //                 margin: EdgeInsets.only(
      //                   left: (size.width / 2.2) +
      //                       10 +
      //                       ((size.width / 2.2) / 2) +
      //                       5,
      //                   // top: 370
      //                 ),
      //                 decoration: const BoxDecoration(
      //                   borderRadius: BorderRadius.only(
      //                     topRight: Radius.circular(15),
      //                   ),
      //                   image: DecorationImage(
      //                       image: AssetImage('assets/image/png/room4.png'),
      //                       fit: BoxFit.fill),
      //                 ),
      //               ),
      //               Stack(
      //                 children: [
      //                   Container(
      //                     width: ((size.width / 2.2) / 2) - 5,
      //                     height: ((size.width / 2.2) / 2) - 5,
      //                     margin: EdgeInsets.only(
      //                         left: (size.width / 2.2) +
      //                             10 +
      //                             ((size.width / 2.2) / 2) +
      //                             5,
      //                         top: ((size.width / 2.2) / 2) + 5),
      //                     decoration: const BoxDecoration(
      //                       color: Color.fromARGB(88, 158, 158, 158),
      //                       borderRadius: BorderRadius.only(
      //                         bottomRight: Radius.circular(15),
      //                       ),
      //                       image: DecorationImage(
      //                           image: AssetImage(
      //                               'assets/image/png/room5.png'),
      //                           fit: BoxFit.fill),
      //                     ),
      //                   ),
      //                   Container(
      //                     width: ((size.width / 2.2) / 2) - 5,
      //                     height: ((size.width / 2.2) / 2) - 5,
      //                     margin: EdgeInsets.only(
      //                         left: (size.width / 2.2) +
      //                             10 +
      //                             ((size.width / 2.2) / 2) +
      //                             5,
      //                         top: ((size.width / 2.2) / 2) + 5),
      //                     decoration: const BoxDecoration(
      //                       color: Color.fromARGB(178, 33, 33, 33),
      //                       borderRadius: BorderRadius.only(
      //                         bottomRight: Radius.circular(15),
      //                       ),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.only(
      //                         left: (size.width / 2.2) +
      //                             10 +
      //                             ((size.width / 2.2) / 2) +
      //                             25,
      //                         top: ((size.width / 2.2) / 2) + 35),
      //                     child: Text(
      //                       '+10',
      //                       style: TextStyle(
      //                           color: Colors.white,
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.w500),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               Row(
      //                 children: [
      //                   SizedBox(
      //                     width: 15,
      //                   ),
      //                   Text(
      //                     'About',
      //                     style: TextStyle(
      //                         fontSize: screenWidth(23),
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ],
      //               ),
      //               Padding(
      //                   padding: EdgeInsetsDirectional.only(
      //                       top: 15, start: screenWidth(100)),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: [
      //                       Column(
      //                         children: [
      //                           Image(
      //                               image: AssetImage(
      //                                   'assets/image/png/seaview_icon.png')),
      //                           SizedBox(height: screenHeight(80)),
      //                           Text(
      //                             "Partial Sea view",
      //                           )
      //                         ],
      //                       ),
      //                       Column(
      //                         children: [
      //                           Image(
      //                               image: AssetImage(
      //                                   'assets/image/png/icon_50m.png')),
      //                           SizedBox(height: screenHeight(80)),
      //                           Text(
      //                             "50m",
      //                           )
      //                         ],
      //                       ),
      //                       Column(
      //                         children: [
      //                           Image(
      //                               image: AssetImage(
      //                                   'assets/image/png/bed_icon.png')),
      //                           SizedBox(height: screenHeight(80)),
      //                           Text(
      //                             " 2 Twin Beds",
      //                           )
      //                         ],
      //                       ),
      //                     ],
      //                   )),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Row(
      //                 children: [
      //                   SizedBox(
      //                     width: 15,
      //                   ),
      //                   Text(
      //                     'Amenities',
      //                     style: TextStyle(
      //                         fontSize: screenWidth(23),
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ],
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.only(
      //                   top: 10,
      //                   left: 15,
      //                 ),
      //                 child: Row(
      //                   children: [
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Text(
      //                               '- ',
      //                               style: TextStyle(fontWeight: FontWeight.w500),
      //                             ),
      //                             Text(
      //                               'Barbeque',
      //                               style: TextStyle(fontSize: screenWidth(26)),
      //                             ),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text(
      //                               '- ',
      //                               style: TextStyle(fontWeight: FontWeight.w500),
      //                             ),
      //                             Text(
      //                               'Air Conditioning',
      //                               style: TextStyle(fontSize: screenWidth(26)),
      //                             ),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text(
      //                               '- ',
      //                               style: TextStyle(fontWeight: FontWeight.w500),
      //                             ),
      //                             Text(
      //                               'Dryer',
      //                               style: TextStyle(fontSize: screenWidth(26)),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       width: screenWidth(4),
      //                     ),
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Text(
      //                               '- ',
      //                               style: TextStyle(fontWeight: FontWeight.w500),
      //                             ),
      //                             Text(
      //                               'Laundry',
      //                               style: TextStyle(fontSize: screenWidth(26)),
      //                             ),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text(
      //                               '- ',
      //                               style: TextStyle(fontWeight: FontWeight.w500),
      //                             ),
      //                             Text(
      //                               'Window Coverings',
      //                               style: TextStyle(fontSize: screenWidth(26)),
      //                             ),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text(
      //                               '- ',
      //                               style: TextStyle(fontWeight: FontWeight.w500),
      //                             ),
      //                             Text(
      //                               'Refrigerator',
      //                               style: TextStyle(fontSize: screenWidth(26)),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),

      //               SizedBox(
      //                 height: 100,
      //               ),
      //             ],
      //           ),
      //         ]),
      //       ),

      //       Center(
      //         child: Padding(
      //           padding: EdgeInsetsDirectional.only(top: screenHeight(1.16)),
      //           child: InkWell(
      //               // onTap: () {
      //               //   Get.to();
      //               // },
      //               child:
      // CustomButton(
      //                   text: 'save',
      //                   textColor: AppColors.backgroundgrayColor,
      //                   widthPercent: 1.1,
      //                   heightPercent: 18)),
      //         ),
      //       )
      //     ],
      //   ),
      // )
    );
  }
}
