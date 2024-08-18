import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/hotel_side_finished_card.dart';
import 'package:traveling/cards/hotel_side_upcoming_card.dart';
import '../../../controllers/hotel_side_booking_controller.dart';
import '../../shared/colors.dart';

class HotelBookingView extends StatefulWidget {
  const HotelBookingView({super.key});
  @override
  State<HotelBookingView> createState() => _HotelBookingViewState();
}

class _HotelBookingViewState extends State<HotelBookingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _flightSorteBy = 'Upcoming';
  String? _hotelSorteBy = 'Upcoming';
  HotelSideBookingsController hotelbookingscontroller =
      Get.put(HotelSideBookingsController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    hotelbookingscontroller.getUserBookingUpcoming(); // Call the method here
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.lightPurple,
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
                          color: AppColors.purple),
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
                        indicatorColor: AppColors.purple,
                        labelColor: AppColors.purple,
                        unselectedLabelColor: AppColors.lightPurple,
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
    print('pppppppppppp                 nnnnnnnnn99n');
    hotelbookingscontroller.getUserBookingUpcoming();
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(() {
          if (hotelbookingscontroller.isLoading.value) {
            return const CircularProgressIndicator(); // Show progress bar while loading
          } else if (hotelbookingscontroller.bookingsDetailsUpcoming.isEmpty) {
            return SizedBox.shrink(); // Show nothing if the list is empty
          } else {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    hotelbookingscontroller.bookingsDetailsUpcoming.length,
                itemBuilder: (context, index) => HotelSideUpcomingCard(
                  size: size,
                  itemIndex: index,
                  hotelBookingsDetails2:
                      hotelbookingscontroller.bookingsDetailsUpcoming[index],
                ),
              ),
            );
          }
        }),
      ],
    );
  }

  Widget finished(BuildContext context) {
    hotelbookingscontroller.getUserBookingFinished();
    print(hotelbookingscontroller.bookingsDetailsFinished.length);
    Size size = MediaQuery.of(context).size;
    @override
    void initState() {
      super.initState();
      hotelbookingscontroller.getUserBookingFinished();
    }

    return Column(
      children: [
        Obx(() {
          if (hotelbookingscontroller.isLoading.value) {
            return const CircularProgressIndicator(); // Show progress bar while loading
          } else if (hotelbookingscontroller.bookingsDetailsFinished.isEmpty) {
            return SizedBox.shrink(); // Show nothing if the list is empty
          } else {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: hotelbookingscontroller
                    .bookingsDetailsFinished.value.length,
                itemBuilder: (context, index) => HotelSideFinishedCard(
                  size: size,
                  itemIndex: index,
                  hotelBookingsDetails2: hotelbookingscontroller
                      .bookingsDetailsFinished.value[index],
                ),
              ),
            );
          }
        })
        // Expanded(
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: HotelFinishedDetails2.length,
        //     itemBuilder: (context, index) => HotelSideFinishedCard(
        //       size: size,
        //       itemIndex: index,
        //       hotelBookingsDetails2: HotelFinishedDetails2[index],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
