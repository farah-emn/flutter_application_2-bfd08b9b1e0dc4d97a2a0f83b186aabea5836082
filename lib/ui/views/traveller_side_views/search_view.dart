import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/search_flight_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_hotel/search_hotel_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.StatusBarColor,
      body: SafeArea(
          child: Stack(
        children: [
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
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(SearchFlightView());
                        },
                        child: Container(
                          width: size.width,
                          height: size.height / 5,
                          decoration:
                              decoration.copyWith(color: AppColors.lightBlue),
                          child: const Stack(
                            children: [
                              Positioned(
                                top: 30,
                                right: 20,
                                child: Icon(
                                  Icons.flight,
                                  color: Color.fromARGB(76, 249, 249, 249),
                                  size: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Flight',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.BlueText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to( SearchHotelView());
                        },
                        child: Container(
                          width: size.width,
                          height: size.height / 5,
                          decoration:
                              decoration.copyWith(color: AppColors.lightPurple),
                          child: const Stack(
                            children: [
                              Positioned(
                                top: 30,
                                right: 20,
                                child: Icon(
                                  Icons.home_rounded,
                                  color: Color.fromARGB(76, 249, 249, 249),
                                  size: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Hotel',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width,
                        height: size.height / 5,
                        decoration: decoration.copyWith(
                            color: Color.fromARGB(255, 210, 225, 211)),
                        child: const Stack(
                          children: [
                            Positioned(
                              top: 30,
                              right: 20,
                              child: Icon(
                                Icons.local_taxi,
                                color: Color.fromARGB(76, 249, 249, 249),
                                size: 100,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Car',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
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
              ),
            ],
          ),
        ],
      )),
    );
  }
}
