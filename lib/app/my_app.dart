import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/home_view.dart';
import 'package:traveling/ui/views/traveller_side_views/menu_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:traveling/core/data/repository/shared_prefrence_repository.dart';
import 'package:traveling/core/services/connectivity_service.dart';
import 'package:traveling/core/translation/app_translation.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view2.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view3.dart';
import 'package:traveling/ui/views/traveller_side_views/welcome_view.dart';

import '../controllers/my_app_controller.dart';
import '../ui/views/splash_view.dart';
import '../ui/views/traveller_side_views/booking_summary_view.dart';
import '../ui/views/traveller_side_views/traveller_details_view1.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  MyAppController controller = Get.put(MyAppController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: getLocal(),
      translations: AppTranslation(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}

Locale getLocal() {
  String langCode = SharedPrefrenceRepository().getAppLanguge();

  if (langCode == 'ar')
    return Locale('ar', 'SA');
  else if (langCode == 'en')
    return Locale('en', 'US');
  else
    return Locale('fr', 'FR');
}



//Get.toNamed('/details');