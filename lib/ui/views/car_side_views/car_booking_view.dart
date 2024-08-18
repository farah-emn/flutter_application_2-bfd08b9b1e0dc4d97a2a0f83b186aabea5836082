import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/car_side_upcoming_card.dart';
import 'package:traveling/cards/car_side_finished_card.dart';
import 'package:traveling/classes/car_side_finished_class.dart';
import 'package:traveling/classes/car_side_upcoming_class.dart';
import '../../../controllers/car_side_booking_controller.dart';
import '../../shared/colors.dart';

class CarBookingView extends StatefulWidget {
  const CarBookingView({super.key});
  @override
  State<CarBookingView> createState() => _CarBookingViewState();
}

class _CarBookingViewState extends State<CarBookingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CarSideBookingsController carSideBookingsController =
      Get.put(CarSideBookingsController());
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
          backgroundColor: AppColors.lightGray,
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
                        indicatorColor: AppColors.darkGray,
                        labelColor: AppColors.lightGray,
                        unselectedLabelColor: AppColors.lightGray,
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
    // carSideBookingsController.getUserBookingUpcoming();
    // carSideBookingsController.getUserBookingFinished();
    print(carSideBookingsController.bookingsDetailsFinished.length);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(() {
          if (carSideBookingsController.isLoading.value) {
            return const CircularProgressIndicator(); // Show progress bar while loading
          } else if (carSideBookingsController
              .bookingsDetailsUpcoming.isEmpty) {
            return SizedBox.shrink(); // Show nothing if the list is empty
          } else {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    carSideBookingsController.bookingsDetailsUpcoming.length,
                itemBuilder: (context, index) => CarSideUpcomingCard(
                  size: size,
                  itemIndex: index,
                  carBookingsDetails: carSideBookingsController
                      .bookingsDetailsUpcoming.value[index],
                ),
              ),
            );
          }
        }),
      ],
    );
  }

  Widget finished(BuildContext context) {
    carSideBookingsController.getUserBookingUpcoming();
    carSideBookingsController.getUserBookingFinished();
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (carSideBookingsController.isLoading.value) {
              return const CircularProgressIndicator(); // Show progress bar while loading
            } else if (carSideBookingsController
                .bookingsDetailsFinished.isEmpty) {
              return SizedBox.shrink(); // Show nothing if the list is empty
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: carSideBookingsController
                      .bookingsDetailsFinished.value.length,
                  itemBuilder: (context, index) => CarSideFinishedCard(
                    size: size,
                    itemIndex: index,
                    carBookingsDetails: carSideBookingsController
                        .bookingsDetailsFinished.value[index],
                  ),
                ),
              );
            }
          }),
        )
      ],
    );
  }
}
