import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightAboutUsView extends StatefulWidget {
  const FlightAboutUsView({super.key});
  @override
  State<FlightAboutUsView> createState() => _FlightAboutUsViewState();
}

class _FlightAboutUsViewState extends State<FlightAboutUsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, right: 15, left: 15),
              child: Column(
                children: [
                  const Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage:
                              AssetImage('assets/image/png/girlUser1.png'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Company name',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grayText,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    width: size.width,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: textFielDecoratiom.copyWith(
                          prefixIcon: const Icon(Icons.business_outlined)),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grayText,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    width: size.width,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: textFielDecoratiom.copyWith(
                          prefixIcon: const Icon(Icons.email)),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Mobile number',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grayText,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    width: size.width,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: textFielDecoratiom.copyWith(
                          prefixIcon: const Icon(Icons.call)),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
