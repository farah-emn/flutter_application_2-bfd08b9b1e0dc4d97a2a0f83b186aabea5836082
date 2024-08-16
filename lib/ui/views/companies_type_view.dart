import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/car_side_views/car_signup_view.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signin_view.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_signup_view.dart';

class CompaniesTypeView extends StatelessWidget {
  const CompaniesTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: Stack(
        children: [
          Positioned(
            left: -50,
            top: -40,
            child: Container(
              height: size.height / 2,
              width: size.width - 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/png/splash7.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            top: 190,
            left: 70,
            child: Container(
              height: size.height / 2,
              width: size.width - 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/png/splash6.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            top: 290,
            left: 0,
            child: Container(
              height: size.height / 2,
              width: size.width / 2 + 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/png/splash8.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: size.width,
                height: size.height / 3,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundgrayColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'What yourcompany type?',
                          style: TextStyle(fontSize: TextSize.header1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => FlightSignInView());
                      },
                      child: Container(
                        width: size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.Blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Flight',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const HoteltSignUpView());
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hotel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const CarSignUpView());
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: AppColors.lightGray,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Car',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
