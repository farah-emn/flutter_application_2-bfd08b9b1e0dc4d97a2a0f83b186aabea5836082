// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/car_side_views/car_booking_view.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_booking_view.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_welcome_view.dart';
import '../first_view.dart';
import 'car_currency.dart';

late User loggedinUser;

class CarHomeView extends StatefulWidget {
  const CarHomeView({super.key});

  @override
  State<CarHomeView> createState() => _CarHomeViewState();
}

class _CarHomeViewState extends State<CarHomeView> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late User loggedinUser;
  String CompanyName = '';
  late final User? user;
  late DatabaseReference ref;
  var Companyimage;
  String CarName = '';
  var CarPhoto;
  var CarId = '';
  var CompanyId = '';
  double incoming = 13350.0;
  int ReservedRooms = 22;
  final CurrencyController CarCurrency_Controller =
      Get.put(CurrencyController());
  ValueNotifier<List<RoomDetailsClass>> CarRooms =
      ValueNotifier<List<RoomDetailsClass>>([]);
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Car_Rental_Company');
    user = _auth.currentUser;
    getCurrentUser();
    getData();

    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
      if (_auth.currentUser == null) {
        Get.offAll(const HotelWelcomeView());
      }
    } catch (e) {}
  }

  void getData() async {
    CompanyId = user!.uid.toString();
    final event = await ref.child(CompanyId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    if (mounted) {
      setState(() {
        CompanyName = userData['car_name_company'];
        Companyimage = userData['image'];
      });
      print(userData['car_name_company']);
    }
    print(CompanyId);
    // getDataHoel().then((fetchedFlights) {});
  }

  // Future<void> getDataHoel() async {
  //   final ref = FirebaseDatabase.instance.reference().child('Room');
  //   final refhotel_booking =
  //       FirebaseDatabase.instance.reference().child('hotel_booking');

  //   final results = await Future.wait([ref.once(), refhotel_booking.once()]);

  //   final event = results[0];
  //   final event_hotel_booking = results[1];

  //   if (event.snapshot.exists) {
  //     var roomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
  //     var roomEntries = roomData.entries.toList();

  //     for (var entry in roomEntries) {
  //       if (entry.value['HotelId'] == user!.uid.toString()) {
  //         if (entry.value['is_reserved'] == true) {
  //           if (mounted) {
  //             setState(() {
  //               ReservedRooms += 1;
  //             });
  //           }
  //         }
  //         if (event_hotel_booking.snapshot.exists) {
  //           var hotel_booking = Map<dynamic, dynamic>.from(
  //               event_hotel_booking.snapshot.value as Map);
  //           for (var bookingRoom in hotel_booking.entries) {
  //             if (bookingRoom.value['RoomId'] == entry.key) {
  //               if (mounted) {
  //                 setState(() {
  //                   incoming += bookingRoom.value['TotalPrice'];
  //                 });
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(incoming);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColors.backgroundgrayColor,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: AppColors.lightGray),
                currentAccountPicture: (Companyimage != null)
                    ? CircleAvatar(backgroundImage: NetworkImage(Companyimage))
                    : const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/image/png/girlUser1.png')),
                accountName: Text('Company name'),
                accountEmail: Text('$CompanyName')),
            // ListTile(
            //   leading: const Icon(
            //     Icons.add,
            //     color: AppColors.darkGray,
            //   ),
            //   title: const Text(
            //     'Add Room',
            //     style: TextStyle(
            //       fontSize: TextSize.header2,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_outlined,
                color: AppColors.darkGray,
              ),
              title: const Text(
                'Bookings',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Get.to(CarBookingView());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.currency_exchange_rounded,
                color: AppColors.darkGray,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Currency',
                    style: TextStyle(
                      fontSize: TextSize.header2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Text(
                      CarCurrency_Controller.selectedCurrency.value,
                      style: TextStyle(
                        fontSize: 15,
                        // color: AppColors.grayText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Get.to(CurrencyPage());
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
                color: AppColors.darkGray,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: TextSize.header2,
                  fontWeight: FontWeight.w500,
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
            backgroundColor: AppColors.lightGray,
            elevation: 0,
            pinned: true,
            expandedHeight: 335,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: AppColors.lightGray,
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
                                          color: Colors.white,
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
                                          color: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Companyimage != null)
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(Companyimage),
                                ))
                          else
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/image/png/girlUser1.png'),
                                )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Company Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                CompanyName,
                                style: TextStyle(
                                  color: AppColors.backgroundgrayColor,
                                  fontSize: 15,
                                ),
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
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
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
                                      '\ ${CarCurrency_Controller.convert(CarCurrency_Controller.selectedCurrency.value, incoming)} ${CarCurrency_Controller.selectedCurrency.value}',
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
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Booking Cars',
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
                                      ReservedRooms.toString(),
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
