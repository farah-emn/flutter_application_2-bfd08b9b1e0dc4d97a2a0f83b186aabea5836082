import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/first_view.dart';
import 'package:traveling/ui/views/flight_side_views/flight_home_screen.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _auth = FirebaseAuth.instance;
  User? loggedinUser;
  User? user;
  late DatabaseReference ref;
  var CompanyId = '';
  double incoming = 0.0;
  int completedFlight = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<Widget> getData() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
      if (_auth.currentUser == null) {
        return FirstView();
      }
    } catch (e) {
      print(e);
    }
    final Hotel = await FirebaseDatabase.instance
        .ref('Hotel')
        .child(loggedinUser!.uid.toString())
        .get();
    final Traveller = await FirebaseDatabase.instance
        .ref('user')
        .child(loggedinUser!.uid.toString())
        .get();
    final Flight = await FirebaseDatabase.instance
        .ref('Airline_company')
        .child(loggedinUser!.uid.toString())
        .get();

    final TravellerData = Traveller.value != null
        ? Map<dynamic, dynamic>.from(Traveller.value as Map)
        : {};
    final HotelData = Hotel.value != null
        ? Map<dynamic, dynamic>.from(Hotel.value as Map)
        : {};
    final FlightData = Flight.value != null
        ? Map<dynamic, dynamic>.from(Flight.value as Map)
        : {};

    if (HotelData.isNotEmpty) {
      return const HoteltHome();
    }
    if (TravellerData.isNotEmpty) {
      return const Home();
    }
    if (FlightData.isNotEmpty) {
      return const FlightHome();
    }

    return const FirstView();
  }

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
              child: Text('Travelling'),
            ),
          ],
        ),
        nextScreen: FutureBuilder<Widget>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Travelling...');
              // CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.data ?? SizedBox();
              }
            }
          },
        ),
      ),
    );
  }
}

    //  Scaffold(
    //   backgroundColor: AppColors.darkBlue,
    //   body: AnimatedSplashScreen(
    //     backgroundColor: AppColors.darkBlue,
    //     splash: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Container(
    //           // child: const Image(
    //           //   image: AssetImage('assets/image/png/Logo.png'),
    //           // ),
    //           child: Text('Travelling'),
    //         ),
    //         // Row(
    //         //   mainAxisAlignment: MainAxisAlignment.center,
    //         //   children: [
    //         //     T ext(
    //         //       "T",
    //         //       style: TextStyle(
    //         //           fontSize: 60,
    //         //           fontWeight: FontWeight.w700,
    //         //           color: AppColors.mainColorBlue),
    //         //     ),
    //         //     Text(
    //         //       "ravell",
    //         //       style: TextStyle(
    //         //           fontSize: 60,
    //         //           fontWeight: FontWeight.w700,
    //         //           color: Color.fromARGB(255, 255, 170, 42)),
    //         //     ),
    //         //     Text(
    //         //       "ing",
    //         //       style: TextStyle(
    //         //           fontSize: 60,
    //         //           fontWeight: FontWeight.w700,
    //         //           color: Colors.white),
    //         //     ),
    //         //   ],
    //         // ),
    //       ],
    //     ),
    //     nextScreen: Home(),
    //   ),
    // );
  