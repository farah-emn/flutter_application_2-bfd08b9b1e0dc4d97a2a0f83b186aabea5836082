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

class HotelAddView extends StatefulWidget {
  const HotelAddView({super.key});
  @override
  State<HotelAddView> createState() => _HotelAddViewState();
}

class _HotelAddViewState extends State<HotelAddView> {
  bool? isChecked = false;
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
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Room',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.purple),
                  ),
                  SizedBox(),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Room Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                decoration: textFielDecoratiom.copyWith(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.lightPurple,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.description_rounded,
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
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: textFielDecoratiom.copyWith(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.lightPurple,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                    ),
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.price_change,
                                      color: AppColors.purple,
                                    )),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Room number',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.door_back_door_rounded,
                                              color: AppColors.purple,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Number of available room',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.meeting_room,
                                              color: AppColors.purple,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Amenities',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.wifi_rounded,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Free wi-fi',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isChecked = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.pool_rounded,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Private pool',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isChecked = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.coffee,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Breakfast',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isChecked = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.bed,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Dobule bed',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                Spacer(),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isChecked = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit_rounded,
                                  color: AppColors.purple,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Ac',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                Spacer(),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isChecked = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Bedrooms',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 3 - 22,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.lightPurple,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18)),
                                          ),
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.bed,
                                            color: AppColors.purple,
                                          ),
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Bathrooms',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 3 - 22,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.lightPurple,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18)),
                                          ),
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.bathtub,
                                            color: AppColors.purple,
                                          ),
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Guests',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 3 - 22,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.lightPurple,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18)),
                                          ),
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.people_alt_rounded,
                                            color: AppColors.purple,
                                          ),
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          backgroundColor: AppColors.purple,
                          text: 'Add',
                          textColor: Colors.white,
                          widthPercent: size.width,
                          heightPercent: 50),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
