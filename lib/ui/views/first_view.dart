import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/companies_type_view.dart';
import 'package:traveling/ui/views/flight_side_views/flight_home_screen.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_welcome_view.dart';

import '../shared/colors.dart';
import '../shared/custom_widgets/custom_button.dart';

late User loggedinUser;

class FirstView extends StatefulWidget {
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DatabaseReference ref;
  late final User? user;

  @override
  void initState() {
    super.initState();

    // test();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Stack(children: [
        Positioned(
          left: -50,
          top: 10,
          child: Container(
            height: size.height / 2,
            width: size.width - 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/png/splash7.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: 70,
          child: Container(
            height: size.height / 2,
            width: size.width - 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/png/splash6.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Positioned(
          top: 340,
          left: 0,
          child: Container(
            height: size.height / 2,
            width: size.width / 2 + 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/png/splash8.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              height: size.height / 4,
              decoration: BoxDecoration(
                color: AppColors.backgroundgrayColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const SignUpView());
                        },
                        child: Center(
                          child: CustomButton(
                            text: 'Start',
                            textColor: AppColors.backgroundgrayColor,
                            widthPercent: size.width,
                            backgroundColor: AppColors.Blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const CompaniesTypeView());
                        },
                        child: const Center(
                          child: Text(
                            'Contenue as a company',
                            style: TextStyle(
                                color: AppColors.grayText,
                                fontSize: TextSize.header2),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
