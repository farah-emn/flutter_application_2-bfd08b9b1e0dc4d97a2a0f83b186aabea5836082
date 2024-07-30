import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter_application_2/constants.dart';
import '../../../cards/amenities_card.dart';
import '../../../classes/amenities_class.dart';
import '../../../classes/reviews_class.dart';
import '../../../cards/reviews_card.dart';
import '../../shared/colors.dart';
import 'hotel_details_view.dart';

class HotelInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
     child :SafeArea(
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/png/hotel.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 270,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    ImageIcon(
                      AssetImage('assets/image/png/favorite.png'),
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 165,
                ),
                Center(
                  child: Container(
                    width: size.width - 140,
                    height: 55,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(7),
                                    topLeft: Radius.circular(7)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/png/room1.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/png/room2.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/png/room3.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/png/room4.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(7),
                                    topRight: Radius.circular(7)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/png/room1.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                const Text(
                  'Shangri-La Bosphorus, Istanbul',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/image/png/location_icon.png'),
                          color: AppColors.mainColorBlue,
                        ),
                        Text(
                          '4 Star hotel - King fahd Rd',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.TextgrayColor,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          '7.1',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.TextgrayColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Amenities",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 85,
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
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Reviews",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: reviewsList.length,
                    itemBuilder: (context, index) => ReviewCard(
                      itemIndex: index,
                      reviewList: reviewsList[index],
                    ),
                  ),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {Get.to(HotelDetailsView());},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 50),
                        backgroundColor: AppColors.mainColorBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Select Room'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
  );
  }
}
