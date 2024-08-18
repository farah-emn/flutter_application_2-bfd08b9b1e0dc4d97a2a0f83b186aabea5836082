import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/flight_side_views/flight_welcome_view.dart';
import 'package:traveling/ui/views/traveller_side_views/currency_display.dart';

import '../../shared/custom_widgets/custom_textfield2.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

String? email;

class _MenuViewState extends State<MenuView> {
  late User loggedinUser;

  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final User? user;
  late DatabaseReference ref;
  String CompanyName = '';
  var Companylogo;
  var CompanyId = '';

  double incoming = 0.0;
  int completedFlight = 0;
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Airline_company');
    user = _auth.currentUser;
    getCurrentUser();
    getData();

    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
      if (_auth.currentUser == null) {
        Get.offAll(const FlightWelcomeView());
      }
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    CompanyId = user!.uid.toString();
    final event = await ref.child(CompanyId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    setState(() {
      CompanyName = userData['AirlineCompanyName'];
      Companylogo = userData['logo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.StatusBarColor,
        body: SafeArea(
          child: Stack(children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Menu',
                      style: TextStyle(
                          fontSize: screenWidth(18),
                          fontWeight: FontWeight.w700,
                          color: AppColors.backgroundgrayColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 48,
                      backgroundImage:
                          AssetImage('assets/image/png/girlUser1.png'),
                    ),
                    TextField(
                      enabled: false,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.grayText, fontSize: 15),
                      // controller: _emailController,
                      decoration: textFielDecoratiom.copyWith(
                        fillColor: AppColors.backgroundgrayColor,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.backgroundgrayColor,
                          ),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: AppColors.backgroundgrayColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          // Border radius
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: screenHeight(25),
                                ),
                                const Icon(
                                  Icons.date_range_rounded,
                                  color: AppColors.Blue,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Bookings',
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                    color: AppColors.TextgrayColor,
                                  ),
                                ),
                                const Spacer(),
                                const Image(
                                  image: AssetImage(
                                      'assets/image/png/arrow icon.png'),
                                )
                              ],
                            ),
                            const Divider(
                              // Add a horizontal line here
                              color: Color.fromARGB(255, 229, 229, 229),
                              thickness: 1,
                              height: 15,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: screenHeight(30),
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: AppColors.Blue,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  'Favourites',
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                    color: AppColors.TextgrayColor,
                                  ),
                                ),
                                const Spacer(),
                                const Image(
                                  image: AssetImage(
                                      'assets/image/png/arrow icon.png'),
                                )
                              ],
                            ),
                            const Divider(
                              // Add a horizontal line here
                              color: Color.fromARGB(255, 229, 229, 229),
                              thickness: 1,
                              height: 15,
                              indent: 10,
                              endIndent: 10,
                            ),
                            InkWell(
                              onTap: () {
                                // Get.to(() => const ProfileView());
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight(30),
                                  ),
                                  const Icon(
                                    Icons.person,
                                    color: AppColors.Blue,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Profile',
                                    style: TextStyle(
                                      fontSize: screenWidth(24),
                                      color: AppColors.TextgrayColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Image(
                                    image: AssetImage(
                                        'assets/image/png/arrow icon.png'),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              // Add a horizontal line here
                              color: Color.fromARGB(255, 229, 229, 229),
                              thickness: 1,
                              height: 15,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: screenHeight(30),
                                ),
                                const Icon(
                                  Icons.people,
                                  color: AppColors.Blue,
                                ),
                                const SizedBox(
                                  width: 17,
                                ),
                                Text(
                                  'Travellers',
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                    color: AppColors.TextgrayColor,
                                  ),
                                ),
                                const Spacer(),
                                const Image(
                                  image: AssetImage(
                                      'assets/image/png/arrow icon.png'),
                                )
                              ],
                            ),
                            const Divider(
                              // Add a horizontal line here
                              color: Color.fromARGB(255, 229, 229, 229),
                              thickness: 1,
                              height: 15,
                              indent: 10,
                              endIndent: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => CurrencyDisplay());
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight(30),
                                  ),
                                  const Icon(
                                    Icons.person,
                                    color: AppColors.Blue,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Settings',
                                    style: TextStyle(
                                      fontSize: screenWidth(24),
                                      color: AppColors.TextgrayColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Image(
                                    image: AssetImage(
                                        'assets/image/png/arrow icon.png'),
                                  )
                                ],
                              ),
                            ),

                            // Row(
                            //   children: [
                            //     SizedBox(
                            //       height: screenHeight(30),
                            //     ),
                            //     const Icon(
                            //       Icons.settings,
                            //       color: AppColors.Blue,
                            //     ),
                            //     const SizedBox(
                            //       width: 20,
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           'Settings',
                            //           style: TextStyle(
                            //             fontSize: screenWidth(24),
                            //             color: AppColors.TextgrayColor,
                            //           ),
                            //         ),
                            //         const Spacer(),
                            //         // InkWell(
                            //         //   onTap: () {
                            //         //     Get.to(() => const CurrencyDisplay());
                            //         //   },
                            //         //   child:
                            //         const Image(
                            //             image: AssetImage(
                            //                 'assets/image/png/arrow icon.png'),
                            //           ),
                            //         //),
                            //         SizedBox(
                            //           height: screenHeight(25),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ],
                        )),
                    SizedBox(
                      height: screenHeight(30),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        // Border radius
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: screenHeight(25),
                              ),
                              const Icon(
                                Icons.headphones,
                                color: AppColors.Blue,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Contact us',
                                style: TextStyle(
                                  fontSize: screenWidth(24),
                                  color: AppColors.TextgrayColor,
                                ),
                              ),
                              const Spacer(),
                              const Image(
                                image: AssetImage(
                                    'assets/image/png/arrow icon.png'),
                              )
                            ],
                          ),
                          const Divider(
                            // Add a horizontal line here
                            color: Color.fromARGB(255, 229, 229, 229),
                            thickness: 1,
                            height: 10,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: screenHeight(30),
                              ),
                              const Icon(
                                Icons.help,
                                color: AppColors.Blue,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Help',
                                style: TextStyle(
                                  fontSize: screenWidth(24),
                                  color: AppColors.TextgrayColor,
                                ),
                              ),
                              const Spacer(),
                              const Image(
                                image: AssetImage(
                                    'assets/image/png/arrow icon.png'),
                              ),
                              SizedBox(
                                height: screenHeight(25),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(30),
                    ),
                    InkWell(
                      // onTap: () {
                      //   _auth.signOut();
                      //   Get.offAll(() => const TravellerWelcomeView());
                      // },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          // Border radius
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: screenHeight(25),
                                ),
                                const Icon(
                                  Icons.logout,
                                  color: AppColors.Blue,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                    color: AppColors.TextgrayColor,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ]),
        ));
  }
}
