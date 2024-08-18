import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/Hotel_booking_card.dart';
import 'package:traveling/cards/car_booking_card.dart';
import 'package:traveling/cards/car_finished_booking_card.dart';
import 'package:traveling/cards/flight_booking_card.dart';
import 'package:traveling/cards/flight_finished_booking_card.dart';
import 'package:traveling/cards/hotel_finished_booking_card.dart';
import 'package:traveling/classes/car_bookings_class.dart';
import 'package:traveling/classes/flight_booking_class.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../../controllers/car_user_booking_controller.dart';
import '../../../controllers/flight_booking_controller.dart';
import '../../../controllers/hotel_bookings_controller.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

late User loggedinUser;

class BookingsView extends StatefulWidget {
  int? tabNumber;

  BookingsView({super.key, required this.tabNumber});
  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView>
    with SingleTickerProviderStateMixin {
  HotelBookingsController hotelbookingscontroller =
      Get.put(HotelBookingsController());
  FlightBookingsController flightbookingscontroller =
      Get.put(FlightBookingsController());
  ItemScrollController _scrollController = ItemScrollController();
  late TabController _tabController;
  String? _flightSorteBy = 'Upcoming';
  String? _hotelSorteBy = 'Upcoming';
  bool NewRoomBooking = false;
  bool NewRoomFlight = false;
  bool NewFlightBooking = false;

  // bool NewRoomBooking = false;
  bool NewCarBooking = false;
  CarBookingsController carBookingsController =
      Get.put(CarBookingsController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    setState(() {
      NewRoomBooking = hotelbookingscontroller.NewbookingRoom.value;
    });
    setState(() {
      NewCarBooking = carBookingsController.NewbookingRoom.value;
    });
    setState(() {
      NewFlightBooking = carBookingsController.NewbookingRoom.value;
    });
    if (widget.tabNumber != null)
      _tabController.animateTo(widget.tabNumber ?? 1);
    getCurrentUser();
  }

  void _scrollToIndex(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.scrollTo(
        index: index,
        duration: Duration(milliseconds: 5),
        curve: Curves.easeInOut,
      );
    });
    // setState(() {
    //   widget.newRoomBooking =d false;
    // });
  }

  final _auth = FirebaseAuth.instance;
  User? user;
  void getCurrentUser() async {
    try {
      user = await _auth.currentUser;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    hotelbookingscontroller.NewbookingRoom.value = false;
    // _scrollController = ItemScrollController();
    // flightbookingscontroller.NewbookingFlight.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [AppColors.lightBlue, AppColors.lightPurple],
          ),
        ),
        child: Stack(children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bookings',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 70,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: size.width - 30,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundgrayColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: AppColors.LightGrayColor,
                    indicatorColor: AppColors.darkBlue,
                    labelColor: AppColors.darkBlue,
                    unselectedLabelColor: AppColors.lightBlue,
                    tabs: const [
                      Tab(
                        text: 'Hotel',
                      ),
                      Tab(text: 'Flight'),
                      Tab(text: 'Car'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170, left: 15, right: 15),
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HotelBookings(context),
                      FlightBookings(context),
                      CarBookings(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      )),
    );
  }

  Widget HotelBookings(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // flightbookingscontroller.bookingsDetailsUpcoming.clear();
    hotelbookingscontroller.getUserBookingUpcoming();
    hotelbookingscontroller.getUserBookingFinished();

    flightbookingscontroller.getUserBookingUpcoming();
    flightbookingscontroller.getUserBookingFinished();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.purple,
                  autofocus: true,
                  value: 'Upcoming',
                  groupValue: _hotelSorteBy,
                  onChanged: (value) {
                    setState(
                      () {
                        _hotelSorteBy = value.toString();
                      },
                    );
                  },
                ),
                const Text(
                  'Upcoming',
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.purple,
                  value: 'Finished',
                  groupValue: _hotelSorteBy,
                  onChanged: (value) {
                    setState(
                      () {
                        _hotelSorteBy = value.toString();
                      },
                    );
                  },
                ),
                const Text(
                  'Finished',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _hotelSorteBy == 'Upcoming'
            ? Obx(() {
                if (hotelbookingscontroller.isLoading.value) {
                  return const CircularProgressIndicator(); // Show progress bar while loading
                } else if (hotelbookingscontroller
                    .bookingsDetailsUpcoming.isEmpty) {
                  return SizedBox.shrink(); // Show nothing if the list is empty
                } else if (NewRoomBooking == true &&
                    hotelbookingscontroller
                        .bookingsDetailsUpcoming.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToIndex(
                        hotelbookingscontroller.bookingsDetailsUpcoming.length);
                  });

                  return Expanded(
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: hotelbookingscontroller
                          .bookingsDetailsUpcoming.length,
                      itemBuilder: (context, index) => HotelBookingCard(
                        size: size,
                        itemIndex: index,
                        hotelBookingsDetails: hotelbookingscontroller
                            .bookingsDetailsUpcoming[index],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: hotelbookingscontroller
                          .bookingsDetailsUpcoming.length,
                      itemBuilder: (context, index) => HotelBookingCard(
                        size: size,
                        itemIndex: index,
                        hotelBookingsDetails: hotelbookingscontroller
                            .bookingsDetailsUpcoming[index],
                      ),
                    ),
                  );
                }
              })
            : Obx(() {
                NewRoomBooking = false;
                if (hotelbookingscontroller.isLoading.value) {
                  return const CircularProgressIndicator(); // Show progress bar while loading
                } else if (hotelbookingscontroller
                    .bookingsDetailsFinished.isEmpty) {
                  return SizedBox.shrink(); // Show nothing if the list is empty
                } else {
                  return Expanded(
                    child: ScrollablePositionedList.builder(
                      itemCount: hotelbookingscontroller
                          .bookingsDetailsFinished.length,
                      itemBuilder: (context, index) => HotelFinishedBookingCard(
                        size: size,
                        itemIndex: index,
                        hotelBookingsDetails: hotelbookingscontroller
                            .bookingsDetailsFinished[index],
                      ),
                    ),
                  );
                }
              }),
      ],
    );
  }

  Widget FlightBookings(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    flightbookingscontroller.getUserBookingUpcoming();
    flightbookingscontroller.getUserBookingFinished();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.darkBlue,
                  autofocus: true,
                  value: 'Upcoming',
                  groupValue: _flightSorteBy,
                  onChanged: (value) {
                    setState(() {
                      _flightSorteBy = value.toString();
                    });
                  },
                ),
                const Text('Upcoming'),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.darkBlue,
                  value: 'Finished',
                  groupValue: _flightSorteBy,
                  onChanged: (value) {
                    setState(() {
                      _flightSorteBy = value.toString();
                    });
                  },
                ),
                const Text('Finished'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        _flightSorteBy == 'Upcoming'
            ? (user?.uid.toString() == 'ANVXIztrfYatlwxF9P8LcgXPihQ2' ||
                    flightbookingscontroller.NewbookingFlight.value == true)
                ? Expanded(
                    child: ScrollablePositionedList.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) => FlightBookingCard(
                        flightBookingModel: flightbookingsDetails[index],
                      ),
                    ),
                  )
                : Expanded(
                    child: ScrollablePositionedList.builder(
                      itemCount: flightbookingscontroller
                          .bookingsDetailsUpcoming.length,
                      itemBuilder: (context, index) => FlightBookingCard(
                        flightBookingModel: flightbookingsDetails[index],
                      ),
                    ),
                  )
            : (user?.uid.toString() == 'ANVXIztrfYatlwxF9P8LcgXPihQ2')
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: flightbookingscontroller
                          .bookingsDetailsFinished.length,
                      itemBuilder: (context, index) =>
                          FlightFinishedBookingCard(
                        itemIndex: index,
                        flightBookingModel: flightbookingsDetails[index],
                      ),
                    ),
                  )
                : SizedBox(),
      ],
    );
  }

  Widget CarBookings(BuildContext context) {
    CarBookingsController carBookingsController =
        Get.put(CarBookingsController());
    carBookingsController.getUserBookingUpcoming();
    carBookingsController.getUserBookingFinished();
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.lightOrange,
                  autofocus: true,
                  value: 'Upcoming',
                  groupValue: _hotelSorteBy,
                  onChanged: (value) {
                    setState(
                      () {
                        _hotelSorteBy = value.toString();
                      },
                    );
                  },
                ),
                const Text(
                  'Upcoming',
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.lightOrange,
                  value: 'Finished',
                  groupValue: _hotelSorteBy,
                  onChanged: (value) {
                    setState(
                      () {
                        _hotelSorteBy = value.toString();
                      },
                    );
                  },
                ),
                const Text(
                  'Finished',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _hotelSorteBy == 'Upcoming'
            ? Obx(() {
                if (carBookingsController.isLoading.value) {
                  return const CircularProgressIndicator(); // Show progress bar while loading
                } else if (carBookingsController
                    .bookingsDetailsUpcoming.isEmpty) {
                  return SizedBox.shrink(); // Show nothing if the list is empty
                } else if (NewCarBooking == true &&
                    carBookingsController.bookingsDetailsUpcoming.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToIndex(
                        carBookingsController.bookingsDetailsUpcoming.length);
                  });

                  return Expanded(
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount:
                          carBookingsController.bookingsDetailsUpcoming.length,
                      itemBuilder: (context, index) => CarBookingCard(
                        size: size,
                        carBookingsDetails: carBookingsController
                            .bookingsDetailsUpcoming.value[index],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount:
                          carBookingsController.bookingsDetailsUpcoming.length,
                      itemBuilder: (context, index) => CarBookingCard(
                        size: size,
                        carBookingsDetails: carBookingsController
                            .bookingsDetailsUpcoming.value[index],
                      ),
                    ),
                  );
                }
              })
            : Obx(() {
                NewCarBooking = false;
                if (carBookingsController.isLoading.value) {
                  return const CircularProgressIndicator(); // Show progress bar while loading
                } else if (carBookingsController
                    .bookingsDetailsFinished.isEmpty) {
                  return SizedBox.shrink(); // Show nothing if the list is empty
                } else {
                  return Expanded(
                    child: ScrollablePositionedList.builder(
                      itemCount:
                          carBookingsController.bookingsDetailsFinished.length,
                      itemBuilder: (context, index) => CarFinishedBookingCard(
                        size: size,
                        itemIndex: index,
                        carBookingsDetails: carBookingsController
                            .bookingsDetailsFinished[index],
                      ),
                    ),
                  );
                }
              }),
        // Expanded(
        //     child: ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: HotelbookingsDetails.length,
        //       itemBuilder: (context, index) => CarFinishedBookingCard(
        //         size: size,
        //         itemIndex: index,
        //         carBookingsDetails: carBookingsDetails[index],
        //       ),
        //     ),
        //   )
        // ? Expanded(
        //     child: ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: carBookingsDetails.length,
        //       itemBuilder: (context, index) => CarBookingCard(
        //         size: size,
        //         // itemIndex: index,
        //         carBookingsDetails: carBookingsDetails[index],
        //       ),
        //     ),
        //   )
        // : Expanded(
        //     child: ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: carBookingsDetails.length,
        //       itemBuilder: (context, index) => CarFinishedBookingCard(
        //         size: size,
        //         itemIndex: index,
        //         carBookingsDetails: carBookingsDetails[index],
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
