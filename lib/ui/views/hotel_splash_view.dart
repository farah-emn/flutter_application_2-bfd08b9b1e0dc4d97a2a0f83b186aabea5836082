import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/companies_type_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_welcome_view.dart';
import 'package:traveling/ui/views/traveller_side_views/welcome_view.dart';

import '../shared/colors.dart';
import '../shared/custom_widgets/custom_button.dart';

class HotelSplashView extends StatelessWidget {
  const HotelSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height / 2 + 100,
                width: size.width,
                decoration: const BoxDecoration(
                  // borderRadius: const BorderRadius.only(
                  //   topLeft: Radius.circular(20),
                  //   bottomLeft: Radius.circular(20),
                  // ),
                  image: DecorationImage(
                    image: AssetImage('assets/image/png/hotel5.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: size.width - 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        'Booking Best Hotel',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Browse and book at more than 200 hotel around the world and save a lot though offers ',
                        style: TextStyle(
                          fontSize: TextSize.header1,
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => WelcomeView());
                        },
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              'See next ',
                              style: TextStyle(
                                  fontSize: TextSize.header1,
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.purple,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
