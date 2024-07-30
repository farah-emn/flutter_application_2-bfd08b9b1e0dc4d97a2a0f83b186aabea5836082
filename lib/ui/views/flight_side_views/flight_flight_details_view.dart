import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/custom_widgets/tab_item.dart';

import '../../../cards/bookings_card.dart';
import '../../../classes/Bookings_class.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightFlightDetailsView extends StatefulWidget {
  const FlightFlightDetailsView({super.key});

  @override
  State<FlightFlightDetailsView> createState() =>
      _FlightFlightDetailsViewState();
}

class _FlightFlightDetailsViewState extends State<FlightFlightDetailsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.StatusBarColor,
          body: SafeArea(
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Flight Details',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.backgroundgrayColor),
                      ),
                      SizedBox(),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    width: size.width - 30,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.babyblueColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: AppColors.babyblueColor,
                      indicator: BoxDecoration(
                        color: AppColors.Blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.Blue,
                      tabs: [
                        TabItem(title: 'Details', count: 1),
                        TabItem(title: 'Bookings', count: 2),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Expanded(
                    child: TabBarView(
                      children: [
                        flightDetails(context),
                        bookings(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget flightDetails(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
    child: ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Plane Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Plane id',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Plane Features',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Flight details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'From',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_takeoff_outlined)),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'To',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: size.width - 50,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: textFielDecoratiom.copyWith(
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.flight_land)),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Depature Time',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.access_time)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Return Time',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon:
                                  const Icon(Icons.access_time_outlined)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Depature Date',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.date_range_rounded)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Return Date',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.date_range_rounded)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Tickets and Seats',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Number of economy seats',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                  Icons.airline_seat_recline_normal)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ticket Price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon:
                                  const Icon(Icons.airplane_ticket_outlined)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Number of first class seats',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                  Icons.airline_seat_recline_extra_rounded)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ticket Price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon:
                                  const Icon(Icons.airplane_ticket_outlined)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Child economy ticket price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.child_care)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Child first class ticket price',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width / 2 - 15,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.child_care)),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

Widget bookings(BuildContext context) {
  return Expanded(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: bookingsDetails.length,
      itemBuilder: (context, index) => BookingsCard(
        itemIndex: index,
        bookingsModel: bookingsDetails[index],
      ),
    ),
  );
}
