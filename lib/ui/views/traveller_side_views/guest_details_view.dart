// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';


class GuestDetailsView extends StatelessWidget {
  const GuestDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    top: screenWidth(18),
                    start: screenWidth(20),
                    end: screenWidth(3),
                    bottom: screenWidth(30)),
                child: Row(
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
                    SizedBox(
                      width: screenWidth(4.5),
                    ),
                    Text(
                      'Guest details',
                      style: TextStyle(
                          fontSize: screenWidth(24),
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
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: screenWidth(20),
                          start: screenWidth(10),
                          end: screenWidth(8)),
                      child: Image(
                          image: AssetImage(
                              'assets/image/png/progresssLinear.png')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomTextGray(mainText: 'Booking \nSummary'),
                        CustomTextGray(mainText: 'Guest\nDetails'),
                        CustomTextGray(mainText: 'Payments'),
                      ],
                    ),
                    SizedBox(
                      height: screenWidth(20),
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
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: screenWidth(20), end: screenWidth(2)),
                      child: Text(
                        ' Traveller details ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth(22),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenWidth(30),
                    ),
                    CustomTextField(
                      prefIcon: Icons.person_2,
                      colorIcon: const Color.fromARGB(255, 255, 181, 215),
                      hintText: 'First name',
                    ),
                    SizedBox(
                      height: screenWidth(30),
                    ),
                    CustomTextField(
                      prefIcon: Icons.person_2,
                      colorIcon: const Color.fromARGB(255, 255, 181, 215),
                      hintText: 'Last name',
                    ),
                    SizedBox(
                      height: screenWidth(30),
                    ),
                    CustomTextField(
                      prefIcon: Icons.email,
                      colorIcon: const Color.fromARGB(255, 175, 153, 255),
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: screenWidth(30),
                    ),
                    CustomTextField(
                      prefIcon: Icons.phone,
                      colorIcon: Color.fromARGB(255, 198, 237, 195),
                      hintText: 'Mobile Number',
                    ),
                    SizedBox(height: screenHeight(12)),
                    Container(
                        alignment: Alignment.bottomLeft,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: screenWidth(30), top: screenHeight(86)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight(40),
                                  ),
                                  Text(
                                    'Total to be paid:',
                                    style: TextStyle(
                                      fontSize: screenWidth(25),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '2231',
                                    style: TextStyle(
                                        fontSize: screenWidth(18),
                                        color: AppColors.mainColorBlue),
                                  ),
                                  Text(
                                    'SAR',
                                    style: TextStyle(
                                      fontSize: screenWidth(26),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight(80),
                              )
                            ],
                          ),
                        )),
                    SizedBox(height: screenWidth(650)),
                    Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.white,
                      child: InkWell(
                          onTap: () {
                            // Get.to(HotelPaymentsView());
                          },
                          child: Center(
                              child: CustomButton(
                          backgroundColor: AppColors.darkBlue,

                                  text: 'Confirm',
                                  textColor: AppColors.backgroundgrayColor,
                                  widthPercent: size.width,
                                  heightPercent: 19))),
                    )
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