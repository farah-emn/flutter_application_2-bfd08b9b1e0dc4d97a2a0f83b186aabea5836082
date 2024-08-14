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
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _flightSorteBy = 'Upcoming';
  String? _hotelSorteBy = 'Upcoming';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.lightPurple,
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
                  activeColor: AppColors.lightPurple,
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
          height: 10,
        ),
        _hotelSorteBy == 'Upcoming'
            ? Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: HotelbookingsDetails.length,
                  itemBuilder: (context, index) => HotelBookingCard(
                    size: size,
                    itemIndex: index,
                    hotelBookingsDetails: HotelbookingsDetails[index],
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: HotelbookingsDetails.length,
                  itemBuilder: (context, index) => HotelFinishedBookingCard(
                    size: size,
                    itemIndex: index,
                    hotelBookingsDetails: HotelbookingsDetails[index],
                  ),
                ),
              )
      ],
    );
  }

  Widget FlightBookings(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    setState(
                      () {
                        _flightSorteBy = value.toString();
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
                  activeColor: AppColors.darkBlue,
                  value: 'Finished',
                  groupValue: _flightSorteBy,
                  onChanged: (value) {
                    setState(
                      () {
                        _flightSorteBy = value.toString();
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
          height: 10,
        ),
        _flightSorteBy == 'Upcoming'
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: flightbookingsDetails.length,
                  itemBuilder: (context, index) => FlightBookingCard(
                    itemIndex: index,
                    flightBookingModel: flightbookingsDetails[index],
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: flightbookingsDetails.length,
                  itemBuilder: (context, index) => FlightFinishedBookingCard(
                    itemIndex: index,
                    flightBookingModel: flightbookingsDetails[index],
                  ),
                ),
              )
      ],
    );
  }

  Widget CarBookings(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.lightGray,
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
                  activeColor: AppColors.lightGray,
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
          height: 10,
        ),
        _hotelSorteBy == 'Upcoming'
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: carBookingsDetails.length,
                  itemBuilder: (context, index) => CarBookingCard(
                    size: size,
                    // itemIndex: index,
                    carBookingsDetails: carBookingsDetails[index],
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: carBookingsDetails.length,
                  itemBuilder: (context, index) => CarFinishedBookingCard(
                    size: size,
                    itemIndex: index,
                    carBookingsDetails: carBookingsDetails[index],
                  ),
                ),
              )
      ],
    );
  }
}
