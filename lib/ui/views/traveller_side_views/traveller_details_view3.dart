import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_search_comtainer.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';

class TravellerDetailsView3 extends StatelessWidget {
  const TravellerDetailsView3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        Container(
          color: AppColors.LightBlueColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenWidth(15),
                    start: screenWidth(20),
                    end: screenWidth(3),
                    bottom: screenWidth(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth(10),
                      height: screenWidth(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.backgroundgrayColor),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.mainColorBlue,
                      ),
                    ),
                    Text(
                      'Traveller details',
                      style: TextStyle(
                          fontSize: screenWidth(18),
                          fontWeight: FontWeight.w700,
                          color: AppColors.backgroundgrayColor),
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth(1),
                // height: screenHeight(1.1),
                decoration: BoxDecoration(
                  color: AppColors.backgroundgrayColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenWidth(2),
                    ),
                    Text(
                      'Your regular travellers',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth(22),
                      ),
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    CustomTextGray(
                        mainText:
                            'Save your regular travellers details to\n     make bookings quick and easy.'),
                    SizedBox(
                      height: screenWidth(15),
                    ),
                    CustomButton(
                        backgroundColor: AppColors.darkBlue,
                        text: 'Add traveller',
                        textColor: AppColors.backgroundgrayColor,
                        widthPercent: 1.1,
                        heightPercent: 15)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
