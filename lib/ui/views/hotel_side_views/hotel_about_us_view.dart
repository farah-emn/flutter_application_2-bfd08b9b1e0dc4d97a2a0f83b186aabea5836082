import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class HotelAboutUsView extends StatefulWidget {
  const HotelAboutUsView({super.key});
  @override
  State<HotelAboutUsView> createState() => _HotelAboutUsViewState();
}

class _HotelAboutUsViewState extends State<HotelAboutUsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightPurple,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.save_as,
                    color: AppColors.lightPurple,
                  ),
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.purple),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.save_as,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage:
                            AssetImage('assets/image/png/girlUser1.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        boxShadow: List.filled(
                          10,
                          const BoxShadow(
                              color: AppColors.gray,
                              blurRadius: BorderSide.strokeAlignOutside,
                              blurStyle: BlurStyle.outer),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Company name',
                              style: TextStyle(
                                  fontSize: TextSize.header2,
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
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.business_outlined,
                                  color: AppColors.purple,
                                )),
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
                                  fontSize: TextSize.header2,
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
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: AppColors.purple,
                                )),
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
                                  fontSize: TextSize.header2,
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
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.call,
                                color: AppColors.purple,
                              ),
                            ),
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
                              'Location',
                              style: TextStyle(
                                  fontSize: TextSize.header2,
                                  color: AppColors.grayText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 45,
                          width: size.width,
                          child: TextField(
                            decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.location_on_rounded,
                                color: AppColors.purple,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
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
