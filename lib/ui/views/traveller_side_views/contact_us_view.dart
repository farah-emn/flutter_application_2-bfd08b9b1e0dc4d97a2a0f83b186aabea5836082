// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print, use_key_in_widget_constructors, body_might_complete_normally_nullable, must_be_immutable, non_constant_identifier_names, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/traveller_details_view1_controller.dart';
import 'package:traveling/controllers/flight_info_controller.dart';
import 'package:traveling/ui/shared/colors.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});
  @override
  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  var result;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Blue,
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Text(
                'Contact us',
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
          padding: const EdgeInsets.only(top: 70),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/png/background1.png'),
                  fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsetsDirectional.only(
                      start: 10, end: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 225, 223, 223),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: AppColors.Blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Travelling.emai.com'),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: AppColors.Blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('09251552245'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
