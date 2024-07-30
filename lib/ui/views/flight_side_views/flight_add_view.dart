import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightAddView extends StatefulWidget {
  const FlightAddView({super.key});
  @override
  State<FlightAddView> createState() => _FlightAddViewState();
}

class _FlightAddViewState extends State<FlightAddView> {
  bool? isChecked = false;
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
                    'Add Flight',
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Plane Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Plane id',
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
                                keyboardType: TextInputType.phone,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Plane Features',
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
                                keyboardType: TextInputType.phone,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {},
                              ),
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
                        'Flight details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'From',
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
                                keyboardType: TextInputType.phone,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'To',
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
                                keyboardType: TextInputType.phone,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(Icons.flight_land)),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Depature Time',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.access_time)),
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Return Time',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                                Icons.access_time_outlined)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Depature Date',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                                Icons.date_range_rounded)),
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Return Date',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                                Icons.date_range_rounded)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
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
                                const Text('Direct Flight'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Tickets and Seats',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Number of economy seats',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airline_seat_recline_normal)),
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Ticket Price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airplane_ticket_outlined)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Number of first class seats',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airline_seat_recline_extra_rounded)),
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Ticket Price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airplane_ticket_outlined)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Child economy ticket price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.child_care)),
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Child first class ticket price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.child_care)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
