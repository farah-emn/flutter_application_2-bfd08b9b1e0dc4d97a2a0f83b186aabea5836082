import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signin_view.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signup_view.dart';
import '../../shared/colors.dart';

class HotelWelcomeView extends StatelessWidget {
  const HotelWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Stack(children: [
        // Image.asset('assets/image/png/flight_background.jpg'),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              height: size.height / 3,
              decoration: const BoxDecoration(
                color: AppColors.backgroundgrayColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30),
                  right: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const FlightSignUpView());
                    },
                    child: Center(
                      child: CustomButton(
                        backgroundColor: AppColors.darkBlue,
                        text: 'Sign up',
                        textColor: AppColors.backgroundgrayColor,
                        widthPercent: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const FlightSignInView());
                    },
                    child: const Center(
                      child: Text(
                        'Sign in',
                        style:
                            TextStyle(color: AppColors.grayText, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
