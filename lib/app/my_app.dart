import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:traveling/core/data/repository/shared_prefrence_repository.dart';
import 'package:traveling/core/translation/app_translation.dart';
import '../controllers/my_app_controller.dart';
import '../ui/views/splash_view.dart';

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