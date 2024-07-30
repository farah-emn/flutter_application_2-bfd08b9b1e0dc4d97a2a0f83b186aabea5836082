import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/hotel_card.dart';
import 'package:traveling/cards/hotel_card2.dart';
import 'package:traveling/cards/hotel_info_home_view_card.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_servicetext.dart';
import 'package:traveling/ui/shared/text_size.dart';

import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/first_view.dart';
import 'package:traveling/ui/views/traveller_side_views/menu_view.dart';
import 'package:traveling/ui/views/traveller_side_views/welcome_view.dart';

import 'flights_view.dart';
import '../../../classes/hotel_info_class.dart';

late User loggedinUser;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // test();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
      if (_auth.currentUser == null) {
        Get.offAll(const FirstView());
      }
    } catch (e) {
      print(e);
    }
  }

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
                'Bookings',
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
                'Travellers',
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
            ListTile(
              leading: const Icon(
                Icons.headphones,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Contact us',
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
                Icons.help,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Help',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.to(d);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.LightBlueColor),
                            child: const Icon(
                              Icons.flight,
                              color: AppColors.BlueText,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Flight',
                            style: TextStyle(color: AppColors.BlueText),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.LightBlueColor),
                          child: const Icon(
                            Icons.hotel,
                            color: AppColors.BlueText,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth(30),
                        ),
                        const Text(
                          'Hotel',
                          style: TextStyle(color: AppColors.BlueText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.LightBlueColor),
                          child: const Icon(
                            Icons.local_taxi,
                            color: AppColors.BlueText,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth(30),
                        ),
                        const Text(
                          'Car',
                          style: TextStyle(color: AppColors.BlueText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width,
            toolbarHeight: 200,
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
            child: Container(
              color: AppColors.backgroundgrayColor,
              height: MediaQuery.sizeOf(context).height - 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                      left: 15,
                      right: 15,
                    ),
                    child: Container(
                        // decoration: BoxDecoration(boxShadow: List),

                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Top international hotels ',
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w500)),
                        // CustomTextGray(mainText: 'See All',)
                        Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.grayText),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 320,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: hotelInfo.length,
                      itemBuilder: (context, index) => HotelCard(
                        size: size,
                        itemIndex: index,
                        hotelDetails: hotel[index],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Offers',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: screenWidth(2),
                      ),
                      const Text(
                        'See All',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.grayText),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width - 30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
