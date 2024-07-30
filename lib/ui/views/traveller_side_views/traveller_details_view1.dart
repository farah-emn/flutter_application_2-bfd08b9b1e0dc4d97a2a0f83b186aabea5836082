import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_search_comtainer.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view2.dart';

class TravellerDetailsView1 extends StatelessWidget {
  const TravellerDetailsView1({super.key});

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
                    ),
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
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: screenWidth(20),
                          start: screenWidth(12),
                          end: screenWidth(12)),
                      child: Image(
                          image: AssetImage(
                              'assets/image/png/progresssLinear.png')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomTextGray(mainText: 'Flight \nSummary'),
                        CustomTextGray(mainText: 'Traveller \n Details'),
                        CustomTextGray(mainText: 'Payments'),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: screenWidth(20), end: screenWidth(2.3)),
                      child: Text(
                        'Add traveller details',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    CustomTextField(
                      prefIcon: Icons.boy,
                      colorIcon: Color.fromARGB(255, 133, 251, 137),
                      hintText: 'Adult 1',
                      suffIcon: Icons.add_circle_outline_rounded,
                      suffColor: AppColors.IconBlueColor,
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    CustomTextField(
                      prefIcon: Icons.girl,
                      colorIcon: Color.fromARGB(255, 133, 251, 137),
                      hintText: 'Child 1',
                      suffIcon: Icons.add_circle_outline_rounded,
                      suffColor: AppColors.IconBlueColor,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: screenWidth(20),
                          end: screenWidth(1.8),
                          bottom: screenWidth(20)),
                      child: Text(
                        'Contact details',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth(20),
                        ),
                      ),
                    ),
                    CustomTextField(
                      prefIcon: Icons.person_2,
                      colorIcon: AppColors.pinkColor,
                      hintText: 'First name',
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    CustomTextField(
                      prefIcon: Icons.person_2,
                      colorIcon: AppColors.pinkColor,
                      hintText: 'Last name',
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    CustomTextField(
                      prefIcon: Icons.email,
                      colorIcon: AppColors.IconPurpleColor,
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    CustomTextField(
                      prefIcon: Icons.call,
                      colorIcon: Color.fromARGB(255, 133, 251, 137),
                      hintText: 'Mobile number',
                    ),
                    SizedBox(
                      height: screenWidth(7),
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(TravellerDetailsView2());
                        },
                        child: CustomButton(
                          backgroundColor: AppColors.darkBlue,

                            text: 'Continue',
                            textColor: AppColors.backgroundgrayColor,
                            widthPercent: 1.1,
                            heightPercent: 15))
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
