import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/hotel_info_home_view_card.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_servicetext.dart';

import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/menu_view.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_welcome_view.dart';

import '../first_view.dart';
import '../../../classes/hotel_info_class.dart';
import 'flight_search_view.dart';

late User loggedinUser;

class FlightHomeView extends StatefulWidget {
  const FlightHomeView({super.key});

  @override
  State<FlightHomeView> createState() => _FlightHomeViewState();
}

class _FlightHomeViewState extends State<FlightHomeView> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColors.backgroundgrayColor,
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.Blue),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/image/png/girlUser1.png'),
                ),
                accountName: Text('data'),
                accountEmail: Text('data@gmail.com')),
            ListTile(
              leading: const Icon(
                Icons.date_range_rounded,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Add airplane',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Clients',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 0.2,
              color: AppColors.TextgrayColor,
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.headphones,
            //     color: AppColors.Blue,
            //   ),
            //   title: const Text(
            //     'Clients',
            //     style: TextStyle(
            //       color: AppColors.BlueText,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.help,
            //     color: AppColors.Blue,
            //   ),
            //   title: const Text(
            //     'Help',
            //     style: TextStyle(
            //       color: AppColors.BlueText,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            Spacer(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.IconBlueColor,
            elevation: 0,
            pinned: true,
            expandedHeight: 335,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: AppColors.StatusBarColor,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                        ),
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.cloud,
                                  color: Color.fromARGB(76, 249, 249, 249),
                                  size: 60,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Let's Explore",
                                      style: TextStyle(
                                          color: AppColors.backgroundgrayColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.cloud,
                                      color: Color.fromARGB(76, 249, 249, 249),
                                      size: 50,
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "The World!",
                                      style: TextStyle(
                                          color: AppColors.backgroundgrayColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundgrayColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                // child: ,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Get.to(FlightsView());
                //       },
                //       child: Column(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(10),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 color: AppColors.LightBlueColor),
                //             child: const Icon(
                //               Icons.flight,
                //               color: AppColors.BlueText,
                //               size: 30,
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           const Text(
                //             'Flight',
                //             style: TextStyle(color: AppColors.BlueText),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Column(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(15),
                //               color: AppColors.LightBlueColor),
                //           child: const Icon(
                //             Icons.hotel,
                //             color: AppColors.BlueText,
                //             size: 30,
                //           ),
                //         ),
                //         SizedBox(
                //           height: screenWidth(30),
                //         ),
                //         const Text(
                //           'Hotel',
                //           style: TextStyle(color: AppColors.BlueText),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(15),
                //               color: AppColors.LightBlueColor),
                //           child: const Icon(
                //             Icons.local_taxi,
                //             color: AppColors.BlueText,
                //             size: 30,
                //           ),
                //         ),
                //         SizedBox(
                //           height: screenWidth(30),
                //         ),
                //         const Text(
                //           'Car',
                //           style: TextStyle(color: AppColors.BlueText),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width,
            toolbarHeight: 180,
            leading: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/image/png/girlUser1.png'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Name',
                                style: TextStyle(
                                    color: AppColors.backgroundgrayColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Username@gmail.com',
                                style:
                                    TextStyle(color: AppColors.LightGrayColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: AppColors.backgroundgrayColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width / 2 - 20,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Incoming',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$526561',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2 - 20,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Completed flights',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '251',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Your next flight',
                        style: TextStyle(
                            color: AppColors.TextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => const FlightSearchView(),
                      );
                    },
                    child: Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Des. 22, 2024',
                                      style: TextStyle(
                                          color: AppColors.TextgrayColor,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '01:12',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'AM',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'CAI',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '04:45',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'AM',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'RUH',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.Blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.airline_seat_recline_extra_rounded,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '35',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money_sharp,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '25514',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
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
            ),
          ),
        ],
      ),
    );
  }
}
