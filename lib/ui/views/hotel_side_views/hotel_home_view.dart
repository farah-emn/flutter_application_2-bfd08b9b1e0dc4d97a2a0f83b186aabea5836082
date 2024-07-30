import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/hotel_info_home_view_card.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_servicetext.dart';
import 'package:traveling/ui/shared/text_size.dart';

import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/flight_side_views/flight_search_view.dart';
import 'package:traveling/ui/views/traveller_side_views/menu_view.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_welcome_view.dart';

import '../first_view.dart';
import '../../../classes/hotel_info_class.dart';
import 'hotel_search_view.dart';

late User loggedinUser;

class HotelHomeView extends StatefulWidget {
  const HotelHomeView({super.key});

  @override
  State<HotelHomeView> createState() => _HotelHomeViewState();
}

class _HotelHomeViewState extends State<HotelHomeView> {
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
                decoration: BoxDecoration(color: AppColors.lightPurple),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/image/png/girlUser1.png'),
                ),
                accountName: Text('data'),
                accountEmail: Text('data@gmail.com')),
            ListTile(
              leading: const Icon(
                Icons.add,
                color: AppColors.purple,
              ),
              title: const Text(
                'Add Room',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.login,
                color: AppColors.purple,
              ),
              title: const Text(
                'Check in',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: AppColors.purple,
              ),
              title: const Text(
                'Check out',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: AppColors.purple,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
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
            Spacer(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.purple,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
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
            backgroundColor: AppColors.lightPurple,
            elevation: 0,
            pinned: true,
            expandedHeight: 335,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: AppColors.lightPurple,
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
                                          color: AppColors.purple,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
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
                                          color: AppColors.purple,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
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
                                    color: AppColors.purple,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Username@gmail.com',
                                style: TextStyle(color: AppColors.gray),
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
            child: Container(
              color: Colors.white,
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
                            color: AppColors.gold,
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
                            color: AppColors.gold,
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
                                      'Reserved rooms',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
