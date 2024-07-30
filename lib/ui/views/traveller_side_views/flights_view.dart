// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/utils.dart';

import 'flight_details._view.dart';
import '../../../classes/flight_info_class.dart';

class FlightsView extends StatelessWidget {
  FlightsView({super.key});
  // List<FlightInfoClass> flightList = [
  //   FlightInfoClass('assets/image/png/flynas.png', 'Flynas', '522', '02h 25m',
  //       '09:30', '01:05'),
  //   FlightInfoClass('assets/image/png/flynas.png', 'Flynas', '522', '02h 25m',
  //       '09:30', '01:05'),
  //   FlightInfoClass('assets/image/png/flynas.png', 'Flynas', '522', '02h 25m',
  //       '09:30', '01:05'),
  //   FlightInfoClass('assets/image/png/flynas.png', 'Flynas', '522', '02h 25m',
  //       '09:30', '01:05'),
  //   FlightInfoClass('assets/image/png/flynas.png', 'Flynas', '522', '02h 25m',
  //       '09:30', '01:05'),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.LightBlueColor,
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Image.asset('assets/image/png/plane_white.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 80,
                  ),
                  child: Image.asset('assets/image/png/universe_icon.png'),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenHeight(10), start: screenWidth(12)),
                child: Column(
                  children: [
                    Text(
                      'CAI',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '26 DEC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenHeight(10), start: screenWidth(1.3)),
                child: Column(
                  children: [
                    Text(
                      'RUH',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '26 DEC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.only(top: 180),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/png/background1.png'),
                        fit: BoxFit.fill),
                  ),
                )),
            SizedBox(
              height: 150,
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.only(top: 150),
            //   child: SizedBox(
            //       child: ListView.builder(
            //     itemBuilder: _buildListItem,
            //     scrollDirection: Axis.vertical,
            //     itemCount: flightList.length,
            //   )),
            // )
          ],
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    // FlightInfoClass flight = flightList[index];
    return SizedBox(
      child: Card(
        margin: EdgeInsetsDirectional.only(
            bottom: screenHeight(80),
            start: screenHeight(80),
            end: screenHeight(80)),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 0.0,
        child: InkWell(
          onTap: () {
            Get.to(FlightDetailsView());
          },
          child: Padding(
            padding: EdgeInsetsDirectional.all(screenHeight(80)),
            child: Column(
              children: [
                Row(
                  children: [
                    // Image.asset(flight.imagePath),
                    SizedBox(width: screenWidth(80)),
                    // Text(
                    //   // flight.name,
                    //   style: TextStyle(
                    //       fontSize: screenWidth(24),
                    //       fontWeight: FontWeight.w500),
                    // )
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  children: [
                    // Text(
                    //   flight.lift,
                    //   style: TextStyle(
                    //       fontSize: screenWidth(22),
                    //       fontWeight: FontWeight.w500),
                    // ),
                    SizedBox(
                      width: 4,
                    ),
                    const Text('AM',
                        style: TextStyle(color: AppColors.TextgrayColor)),
                    const Spacer(),
                    Image.asset('assets/image/png/Line_.png'),
                    Image.asset('assets/image/png/blue plane.png'),
                    Image.asset('assets/image/png/arrow blue.png'),
                    const Spacer(),
                    // Text(
                    //   flight.arrive,
                    //   style: TextStyle(
                    //       fontSize: screenWidth(22),
                    //       fontWeight: FontWeight.w500),
                    // ),
                    SizedBox(
                      width: 4,
                    ),
                    const Text('PM',
                        style: TextStyle(color: AppColors.TextgrayColor)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/image/png/Direct_icon.png'),
                        SizedBox(
                          width: screenWidth(90),
                        ),
                        const Text(
                          'Direct',
                          style: TextStyle(color: AppColors.TextgrayColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset('assets/image/png/clock_icon.png'),
                        SizedBox(
                          width: screenWidth(80),
                        ),
                        // Text(
                        //   flight.time,
                        //   style:
                        //       const TextStyle(color: AppColors.TextgrayColor),
                        // ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        // Text(
                        //   flight.cost,
                        //   style: TextStyle(
                        //       color: const Color.fromARGB(255, 255, 181, 215),
                        //       fontSize: screenWidth(18),
                        //       fontWeight: FontWeight.bold),
                        // ),
                        const Text(
                          'SAR',
                          style: TextStyle(
                              color: AppColors.TextgrayColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
