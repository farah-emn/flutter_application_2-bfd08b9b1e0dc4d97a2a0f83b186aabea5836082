import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/hotel_splash_view.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/menu_view.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_welcome_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: AnimatedSplashScreen(
        backgroundColor: AppColors.darkBlue,
        splash: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // child: const Image(
              //   image: AssetImage('assets/image/png/Logo.png'),
              // ),
              child: Text('Travelling'),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     T ext(
            //       "T",
            //       style: TextStyle(
            //           fontSize: 60,
            //           fontWeight: FontWeight.w700,
            //           color: AppColors.mainColorBlue),
            //     ),
            //     Text(
            //       "ravell",
            //       style: TextStyle(
            //           fontSize: 60,
            //           fontWeight: FontWeight.w700,
            //           color: Color.fromARGB(255, 255, 170, 42)),
            //     ),
            //     Text(
            //       "ing",
            //       style: TextStyle(
            //           fontSize: 60,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.white),
            //     ),
            //   ],
            // ),
          ],
        ),
        nextScreen: Home(),
      ),
    );
  }
}
