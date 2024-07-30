import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/Hotel_booking_card.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
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
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.StatusBarColor,
          body: SafeArea(
            child: Stack(children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bookings',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.backgroundgrayColor),
                    ),
                  ],
                ),
              ),
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
                        tabs: [
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
                    padding:
                        const EdgeInsets.only(top: 180, left: 15, right: 15),
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
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: HotelbookingsDetails.length,
        itemBuilder: (context, index) => HotelBookingCard(
          size: size,
          itemIndex: index,
          hotelBookingsDetails: HotelbookingsDetails[index],
        ),
      ),
    );
  }

  Widget FlightBookings(BuildContext context) {
    return Container();
  }

  Widget CarBookings(BuildContext context) {
    return Container();
  }
}
