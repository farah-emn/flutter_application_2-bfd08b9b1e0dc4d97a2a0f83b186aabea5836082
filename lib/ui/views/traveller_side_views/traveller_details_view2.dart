import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_search_comtainer.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view3.dart';

class TravellerDetailsView2 extends StatelessWidget {
  const TravellerDetailsView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
                width: screenWidth(1.1),
                height: screenWidth(3),
                decoration: BoxDecoration(
                    color: AppColors.babyblueColor,
                    borderRadius: BorderRadiusDirectional.circular(25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Use your passport or GCC National ID to \nquickly and securely auto-fill traveller\n details',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(96, 96, 96, 1),
                          fontSize: screenWidth(25)),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: screenWidth(1.3),
                      height: screenWidth(10),
                      decoration: BoxDecoration(
                          color: AppColors.backgroundgrayColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsetsDirectional.all(10),
                        child: Center(
                          child: Text(
                            'Scan ID to add traveller',
                            style: TextStyle(
                                color: AppColors.mainColorBlue,
                                fontSize: screenWidth(25)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              ' Traveller details ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              prefIcon: Icons.person_2,
              colorIcon: AppColors.pinkColor,
              hintText: 'First name',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              prefIcon: Icons.person_2,
              colorIcon: AppColors.pinkColor,
              hintText: 'Last name',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              prefIcon: Icons.public,
              colorIcon: AppColors.IconBlueColor,
              hintText: 'Nationalty',
              suffIcon: Icons.keyboard_arrow_down,
            ),
            SizedBox(
              height: 15,
            ),
            const CustomTextField(
              prefIcon: Icons.calendar_today,
              colorIcon: AppColors.IconPurpleColor,
              hintText: 'Date of Birth',
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              'Traveller details',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            const CustomTextField(
              prefIcon: Icons.email,
              colorIcon: Color.fromARGB(255, 133, 251, 137),
              hintText: 'Passport Number',
              suffIcon: Icons.keyboard_arrow_down,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              prefIcon: Icons.public,
              colorIcon: Color.fromARGB(255, 133, 251, 137),
              hintText: 'Issuing country',
              suffIcon: Icons.keyboard_arrow_down,
            ),
            SizedBox(
              height: screenWidth(20),
            ),
            CustomTextField(
              prefIcon: Icons.calendar_today,
              colorIcon: Color.fromARGB(255, 133, 251, 137),
              hintText: 'Expire date',
              suffIcon: Icons.keyboard_arrow_down,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ],
    );
  }
}
