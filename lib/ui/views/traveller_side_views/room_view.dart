// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/amenities_card.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_summary_view.dart';

class RoomView extends StatefulWidget {
  const RoomView({super.key});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
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
                      image: AssetImage('assets/image/png/room2.png'),
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
                      'Deluxe Room - 2 Twin Beds ',
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
                        Container(
                          width: size.width / 2.2,
                          height: size.width / 2.2,
                          // margin: EdgeInsets.only(top: 370),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            image: DecorationImage(
                                image: AssetImage('assets/image/png/room1.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          width: ((size.width / 2.2) / 2) - 5,
                          height: ((size.width / 2.2) / 2) - 5,
                          margin: EdgeInsets.only(
                            left: (size.width / 2.2) + 10,
                            //  top: 370
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/png/room2.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          width: ((size.width / 2.2) / 2) - 5,
                          height: ((size.width / 2.2) / 2) - 5,
                          margin: EdgeInsets.only(
                              left: (size.width / 2.2) + 10,
                              top: ((size.width / 2.2) / 2) + 5),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/png/room3.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          width: ((size.width / 2.2) / 2) - 5,
                          height: ((size.width / 2.2) / 2) - 5,
                          margin: EdgeInsets.only(
                            left: (size.width / 2.2) +
                                10 +
                                ((size.width / 2.2) / 2) +
                                5,
                            // top: 370
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                            ),
                            image: DecorationImage(
                                image: AssetImage('assets/image/png/room4.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: ((size.width / 2.2) / 2) - 5,
                              height: ((size.width / 2.2) / 2) - 5,
                              margin: EdgeInsets.only(
                                  left: (size.width / 2.2) +
                                      10 +
                                      ((size.width / 2.2) / 2) +
                                      5,
                                  top: ((size.width / 2.2) / 2) + 5),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(88, 158, 158, 158),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/png/room5.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: (size.width / 2.2) +
                                      10 +
                                      ((size.width / 2.2) / 2) +
                                      25,
                                  top: ((size.width / 2.2) / 2) + 35),
                              child: Text(
                                '+10',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: size.width - 50,
                          height: 1,
                          color: AppColors.LightGrayColor,
                        ),
                      ],
                    ),
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
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Container(
                        height: 60,
                        width: size.width,
                        child: Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: Amenities.length,
                            itemBuilder: (context, index) => AmenitiesCard(
                              itemIndex: index,
                              amenitiesModel: Amenities[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: size.width - 50,
                          height: 1,
                          color: AppColors.LightGrayColor,
                        ),
                      ],
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
                              fontWeight: FontWeight.w500),
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
                                        color: AppColors.purple,
                                        backgroundColor: AppColors.lightPurple,
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
                                        color: AppColors.purple,
                                        backgroundColor: AppColors.lightPurple,
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
                                        color: AppColors.purple,
                                        backgroundColor: AppColors.lightPurple,
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
                                        color: AppColors.purple,
                                        backgroundColor: AppColors.lightPurple,
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
                                      color: AppColors.purple,
                                      backgroundColor: AppColors.lightPurple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          HotelSummartView(),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                            text: 'Booking Now',
                            textColor: Colors.white,
                            widthPercent: size.width,
                            heightPercent: 50,
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
}
