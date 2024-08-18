import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/hotel_card.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';

import 'package:traveling/classes/car_class.dart';

import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/first_view.dart';
import 'package:traveling/ui/views/car_splash_view.dart';
import 'package:traveling/ui/views/hotel_splash_view.dart';
import 'package:traveling/ui/views/traveller_side_views/contact_us_view.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/traveller_details_view2.dart';

import '../../../cards/car_card_home.dart';
import '../../../classes/hotel_info_class.dart';
import '../../../controllers/currency_controller.dart';
import 'currency_display.dart';

late User loggedinUser;

class HomeView extends StatefulWidget {
  int? tabNumber;
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CurrencyController currencyController = Get.put(CurrencyController());

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
        Get.offAll(const HotelSplashView());
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
                accountName: Text('Farah'),
                accountEmail: Text('farah@gmail.com')),
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
                Get.to(ContactUsView());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.currency_exchange_rounded,
                color: AppColors.Blue,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Currency',
                    style: TextStyle(
                      color: AppColors.BlueText,
                      fontSize: TextSize.header2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Text(
                      currencyController.selectedCurrency.value,
                      style: TextStyle(
                        color: AppColors.BlueText,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                Get.to(CurrencyPage());
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
                _auth.signOut();
                Get.offAll(() => const FirstView());
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
                  color: AppColors.Blue,
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
                                color: AppColors.lightBlue),
                            child: const Icon(
                              Icons.flight,
                              color: AppColors.darkBlue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Flight',
                            style: TextStyle(color: AppColors.darkBlue),
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
                              color: AppColors.lightPurple),
                          child: const Icon(
                            Icons.hotel,
                            color: AppColors.purple,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth(30),
                        ),
                        const Text(
                          'Hotel',
                          style: TextStyle(color: AppColors.purple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.lightGray),
                          child: const Icon(
                            Icons.local_taxi,
                            color: AppColors.darkGray,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth(30),
                        ),
                        const Text(
                          'Car',
                          style: TextStyle(color: AppColors.darkGray),
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
                                'Farah',
                                style: TextStyle(
                                    color: AppColors.backgroundgrayColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Farah@gmail.com',
                                style: TextStyle(
                                    color: AppColors.backgroundgrayColor),
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
                              fontSize: 14, color: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 324,
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
                      const Text('Cars',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: screenWidth(2),
                      ),
                      const Text(
                        'See All',
                        style:
                            TextStyle(fontSize: 14, color: Colors.transparent),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 325,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: cars.length,
                      itemBuilder: (context, index) => CarCardHome(
                        size: size,
                        itemIndex: index,
                        carDetails: cars[index],
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
