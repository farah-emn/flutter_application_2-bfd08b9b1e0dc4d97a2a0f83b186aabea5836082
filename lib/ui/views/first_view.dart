import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/views/companies_type_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_welcome_view.dart';

import '../shared/colors.dart';
import '../shared/custom_widgets/custom_button.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Stack(children: [
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
              child: Column(children: [
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const TravellerWelcomeView());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: CustomButton(
                          backgroundColor: AppColors.darkBlue,

                      text: 'Start',
                      textColor: AppColors.backgroundgrayColor,
                      heightPercent: 15,
                      widthPercent: size.width,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const CompaniesTypeView());
                  },
                  child: const Center(
                    child: Text(
                      'Contenue as a company',
                      style: TextStyle(color: AppColors.Blue, fontSize: 18),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ]),
    );
  }
}
