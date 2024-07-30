import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:traveling/cards/amenities_card.dart';
import 'package:traveling/cards/hotel_card2.dart';
import 'package:traveling/cards/image_card.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/image.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/tab_item.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';

import '../../../classes/hotel_room_details_class.dart';

class HotelDetailsView extends StatefulWidget {
  @override
  State<HotelDetailsView> createState() => _HotelDetailsViewState();
}

class _HotelDetailsViewState extends State<HotelDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightPurple,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/png/background1.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hotel Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.purple),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.share_rounded,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 100, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shangri-La Bosphorus, Istanbul',
                      style: TextStyle(
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: AppColors.gold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Shangri-La Bosphorus, Istanbul',
                          style: TextStyle(
                            fontSize: TextSize.header2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: const EdgeInsets.only(top: 170),
                  width: size.width - 30,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundgrayColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: AppColors.LightGrayColor,
                    indicatorColor: AppColors.purple,
                    labelColor: AppColors.purple,
                    unselectedLabelColor: AppColors.lightPurple,
                    tabs: [
                      Tab(
                        text: 'Hotel Details',
                      ),
                      Tab(text: 'Rooms'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230, left: 15, right: 15),
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HotelDetails(context),
                      SelectRoom(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget HotelDetails(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: TextSize.header1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Description Description Description Description Description Description Description',
              style: TextStyle(
                fontSize: TextSize.header2,
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
            const Text(
              'Gallery',
              style: TextStyle(
                fontSize: TextSize.header1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 200,
              width: size.width,
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: image.length,
                  itemBuilder: (context, index) => ImageCard(
                    itemIndex: index,
                    imageList: image[index],
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
            const Text(
              'Amenities',
              style: TextStyle(
                fontSize: TextSize.header1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
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
            const Text(
              'Rating and review',
              style: TextStyle(
                fontSize: TextSize.header1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      '4.5',
                      style: TextStyle(fontSize: 50),
                    ),
                    RatingBarIndicator(
                      itemSize: 25,
                      rating: 4.5,
                      itemBuilder: (_, __) => const Icon(
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
                        const Text('5'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: size.width / 2,
                            child: const LinearProgressIndicator(
                              minHeight: 15,
                              value: 0.8,
                              color: AppColors.purple,
                              backgroundColor: AppColors.lightPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('4'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: size.width / 2,
                            child: const LinearProgressIndicator(
                              minHeight: 15,
                              value: 0.7,
                              color: AppColors.purple,
                              backgroundColor: AppColors.lightPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('3'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: size.width / 2,
                            child: const LinearProgressIndicator(
                              minHeight: 15,
                              value: 0.8,
                              color: AppColors.purple,
                              backgroundColor: AppColors.lightPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('2'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: size.width / 2,
                            child: const LinearProgressIndicator(
                              minHeight: 15,
                              value: 0.5,
                              color: AppColors.purple,
                              backgroundColor: AppColors.lightPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('1'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: size.width / 2,
                          child: const LinearProgressIndicator(
                            minHeight: 15,
                            value: 0.2,
                            color: AppColors.purple,
                            backgroundColor: AppColors.lightPurple,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ],
    );
  }

  Widget SelectRoom(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: room.length,
        itemBuilder: (context, index) => HotelCard2(
          size: size,
          itemIndex: index,
          room: room[index],
        ),
      ),
    );
  }
}
