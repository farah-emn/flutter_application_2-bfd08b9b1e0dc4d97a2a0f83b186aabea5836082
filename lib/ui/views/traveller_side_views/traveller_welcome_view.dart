import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';

import '../../shared/colors.dart';

class TravellerWelcomeView extends StatelessWidget {
  const TravellerWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Column(children: [
        const SizedBox(
          height: 100,
        ),
        InkWell(
          onTap: () {
            Get.to(() => const SignUpView());
          },
          child: Center(
            child: CustomButton(
                          backgroundColor: AppColors.darkBlue,

              text: 'Sign up',
              textColor: AppColors.backgroundgrayColor,
              widthPercent: size.width,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Get.to(() => const SignInView());
          },
          child: const Center(
            child: Text(
              'Sign in',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ]),
    );
  }
}
