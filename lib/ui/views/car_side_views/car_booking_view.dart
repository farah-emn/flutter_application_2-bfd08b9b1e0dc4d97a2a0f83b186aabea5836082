import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveling/cards/car_side_upcoming_card.dart';

import 'package:traveling/cards/car_side_finished_card.dart';
import 'package:traveling/cards/hotel_side_upcoming_card.dart';
import 'package:traveling/classes/car_side_finished_class.dart';
import 'package:traveling/classes/car_side_upcoming_class.dart';
import 'package:traveling/classes/hotel_side_finished_class.dart';
import 'package:traveling/classes/hotel_side_upcoming_class.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class CarBookingView extends StatefulWidget {
  const CarBookingView({super.key});
  @override
  State<CarBookingView> createState() => _CarBookingViewState();
}

class _CarBookingViewState extends State<CarBookingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _flightSorteBy = 'Upcoming';
  String? _hotelSorteBy = 'Upcoming';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.lightOrange,
          body: SafeArea(
            child: Stack(children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                  top: 50,
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
                        indicatorColor: AppColors.orange,
                        labelColor: AppColors.orange,
                        unselectedLabelColor: AppColors.lightOrange,
                        tabs: const [
                          Tab(
                            text: 'Upcoming',
                          ),
                          Tab(text: 'Finished'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 170, left: 15, right: 15),
                    child: Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          upcoming(context),
                          finished(context),
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

  Widget upcoming(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: CarBookingsDetails.length,
            itemBuilder: (context, index) => CarSideUpcomingCard(
              size: size,
              itemIndex: index,
              carBookingsDetails: CarBookingsDetails[index],
            ),
          ),
        )
      ],
    );
  }

  Widget finished(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: carFinishedDetails.length,
            itemBuilder: (context, index) => CarSideFinishedCard(
              size: size,
              itemIndex: index,
              carBookingsDetails: carFinishedDetails[index],
            ),
          ),
        )
      ],
    );
  }
}
