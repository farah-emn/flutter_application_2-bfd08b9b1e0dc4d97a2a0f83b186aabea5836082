// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/amenities_card.dart';
import 'package:traveling/cards/image_card.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/image.dart';
import 'package:traveling/controllers/hotel_controller.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/controllers/hotel_search_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../../../cards/hotel_card2.dart';
import '../../../../classes/hotel1.dart';
import 'hotel_map_view.dart';

class HotelDetailsView extends StatefulWidget {
  HotelClass1? Hotel;

  HotelDetailsView({super.key, this.Hotel});
  @override
  State<HotelDetailsView> createState() => _HotelDetailsViewState();
}

class _HotelDetailsViewState extends State<HotelDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SearchHotelController hotelscontroller =
      Get.put(SearchHotelController());
  final HotelController Hotel_Controller = Get.put(HotelController());
  final HotelRoomsController hotelRoomsController =
      Get.put(HotelRoomsController());
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    hotelRoomsController.getAllRoomRatings(widget.Hotel!.Id ?? '');
    final HotelRoomsController controller = Get.put(HotelRoomsController());

    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightPurple,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 70,
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
              padding: EdgeInsets.only(top: 35),
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
              padding: EdgeInsets.only(left: 15, right: 15, top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.purple,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.Hotel!.Name ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(HotelMapView(
                          Location:
                              '${widget.Hotel!.Name}, ${widget.Hotel!.location}, ${widget.Hotel!.address}'));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      width: size.width / 2 + 50,
                      decoration: BoxDecoration(
                        color: AppColors.LightGrayColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: AppColors.purple,
                          ),
                          Text(
                            ' Show location on map',
                            style: TextStyle(
                              fontSize: TextSize.header2,
                              color: AppColors.purple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
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
              padding: const EdgeInsets.only(top: 220, left: 15, right: 15),
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
    );
  }

  Widget HotelDetails(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: AppColors.purple,
                    ),
                    Text(
                      '${widget.Hotel!.location} - ${widget.Hotel!.address}',
                      style: TextStyle(
                        fontSize: TextSize.header2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: AppColors.purple,
                    ),
                    Text(
                      '${widget.Hotel!.email}',
                      style: TextStyle(
                        fontSize: TextSize.header2,
                      ),
                    ),
                  ],
                )
              ],
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
                    (hotelRoomsController.HotelaverageRating.value < 1)
                        ? Text(
                            ' 1',
                            style: TextStyle(fontSize: 50),
                          )
                        : Text(
                            hotelRoomsController.HotelaverageRating.value
                                .toString(),
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
                            child: LinearProgressIndicator(
                              minHeight: 15,
                              value: hotelRoomsController
                                          .HotelaverageRating.value >=
                                      5
                                  ? 1
                                  : (5 -
                                              hotelRoomsController
                                                  .HotelaverageRating.value <
                                          1
                                      ? 5 -
                                          hotelRoomsController
                                              .HotelaverageRating.value
                                      : 0),
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
                            child: LinearProgressIndicator(
                              minHeight: 15,
                              value: hotelRoomsController
                                          .HotelaverageRating.value >=
                                      4
                                  ? 1
                                  : (4 -
                                              hotelRoomsController
                                                  .HotelaverageRating.value <
                                          1
                                      ? 4 -
                                          hotelRoomsController
                                              .HotelaverageRating.value
                                      : 0),
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
                            child: LinearProgressIndicator(
                              minHeight: 15,
                              value: hotelRoomsController
                                          .HotelaverageRating.value >=
                                      3
                                  ? 1
                                  : (3 -
                                              hotelRoomsController
                                                  .HotelaverageRating.value <
                                          1
                                      ? 3 -
                                          hotelRoomsController
                                              .HotelaverageRating.value
                                      : 0),
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
                            child: LinearProgressIndicator(
                              minHeight: 15,
                              value: hotelRoomsController
                                          .HotelaverageRating.value >=
                                      2
                                  ? 1
                                  : (2 -
                                              hotelRoomsController
                                                  .HotelaverageRating.value <
                                          1
                                      ? 2 -
                                          hotelRoomsController
                                              .HotelaverageRating.value
                                      : 0),
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
                          child: LinearProgressIndicator(
                            minHeight: 15,
                            value:
                                hotelRoomsController.HotelaverageRating.value >=
                                        1
                                    ? 1
                                    : (1 -
                                                hotelRoomsController
                                                    .HotelaverageRating.value <
                                            1
                                        ? 1
                                        : 0),
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
    final HotelRoomsController controller = Get.put(HotelRoomsController());
    print(controller.hotelRooms.length);
    print('wertyuiolknbv');
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return (controller.hotelRooms.isEmpty)
          ? const CircularProgressIndicator()
          : Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.hotelRooms.length,
                itemBuilder: (context, index) => HotelCard2(
                  size: size,
                  HotelId: controller.hotelRooms[index].id,
                  room: controller.hotelRooms[index],
                ),
              ),
            );
    });
  }
}
