import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel_info_class.dart';

import '../ui/shared/colors.dart';
import '../ui/views/traveller_side_views/hotel_info_view.dart';

class HotelInfoHomeViewCard extends StatelessWidget {
  const HotelInfoHomeViewCard(
      {super.key, required this.itemIndex, required this.hotelInfo});
  final int itemIndex;
  final HotelInfoClass hotelInfo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          HotelInfoView(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15),
        child: Stack(
          children: [
            // Image(
            //   image: AssetImage('assets/image/png/Hotel.png'),
            // ),
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(hotelInfo.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 160,
                ),
                Container(
                  width: 190,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    hotelInfo.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 190,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    hotelInfo.stars + ' Stars Hotel',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.favorite,
                color: AppColors.LightGrayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
