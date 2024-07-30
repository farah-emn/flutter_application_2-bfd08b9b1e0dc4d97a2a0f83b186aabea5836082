// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, library_private_types_in_public_api, deprecated_member_use, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, unused_import, avoid_print
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/custom_widgets/tab_item.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_explore_view.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_info_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateReturnDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_round.dart';
// import 'package:traveling/ui/views/traveller_side_views/traveller_details_view/traveller_details_view2.dart';

class SearchHotelView extends StatefulWidget {
  String? DepartureCity;
  String? ArrivalCity;
  SearchHotelView({this.DepartureCity, this.ArrivalCity, Key? key})
      : super(key: key);

  @override
  SearchHotelViewState createState() => SearchHotelViewState();
}

class SearchHotelViewState extends State<SearchHotelView> {
  final TextEditingController dateController = TextEditingController();
  void _handleDateSelection(String dateText) {
    controller.updateSelectedDate();
    dateController.text = dateText;
  }

  final SearchViewOneWayController controller =
      Get.put(SearchViewOneWayController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDepartureCitySelected(String selectedCity) {
    controller.setDepartureCity(widget.ArrivalCity ?? '');
  }

  void onArrivalCitySelected(String selectedCity) {
    controller.setArrivalCity(widget.DepartureCity ?? '');
  }

  void _searchForFlights() async {
    if (widget.DepartureCity != null) {
      controller.setDepartureCity(widget.DepartureCity!);
    }
    if (widget.ArrivalCity != null) {
      controller.setArrivalCity(widget.ArrivalCity!);
    }
    controller.searchForFlights();
    print(';;;;;;;;;;;');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: SafeArea(
        child: Stack(children: [
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
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Search Hotel',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.purple),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Destonation',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, elevation: 0,
                          backgroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side:
                              BorderSide(color: Colors.transparent, width: 0),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListDepartureCity(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              if (result != null) {
                                setState(() {
                                  if (widget.ArrivalCity != '') {
                                    if (result['DepartureCity'] ==
                                        widget.ArrivalCity) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Invalid City Selection'),
                                            content: Text(
                                                'Arrival city cannot be the same as the departure city.'),
                                          );
                                        },
                                      );
                                    } else {
                                      widget.DepartureCity =
                                          result['DepartureCity'];
                                    }
                                  } else {
                                    widget.DepartureCity =
                                        result['DepartureCity'];
                                  }
                                });
                              }
                            });
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.flight_takeoff, color: AppColors.gold),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.DepartureCity ?? '',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Arrival Date',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? newDepartureDate =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2024),
                                        firstDate: DateTime(2024),
                                        lastDate: DateTime(2026));
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                width: size.width / 2 - 20,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.calendar_month_rounded,
                                        color: AppColors.gold),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '2024/10',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                            InkWell(
                              onTap: () async {
                                DateTime? newDepartureDate =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2024),
                                        firstDate: DateTime(2024),
                                        lastDate: DateTime(2026));
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                width: size.width / 2 - 20,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.calendar_month_rounded,
                                        color: AppColors.gold),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '2024/11',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Adult Number',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              width: size.width / 2 - 20,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.group, color: AppColors.gold),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GetBuilder<SearchViewOneWayController>(
                                    init: SearchViewOneWayController(),
                                    builder: (controller) {
                                      return Text(
                                        '${controller.Adultcounter} Adult',
                                        style: TextStyle(
                                            fontSize: TextSize.header2,
                                            fontWeight: FontWeight.w500),
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.incrementAdult();
                                        },
                                        child: Icon(Icons.arrow_drop_up_sharp,
                                            color: AppColors.purple,
                                            size: 20),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.decrementAdult();
                                        },
                                        child: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: AppColors.purple,
                                            size: 20),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Children Number',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              width: size.width / 2 - 20,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.group, color: AppColors.gold),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GetBuilder<SearchViewOneWayController>(
                                    init: SearchViewOneWayController(),
                                    builder: (controller) {
                                      return Text(
                                        '${controller.Childcounter} Children',
                                        style: TextStyle(
                                            fontSize: TextSize.header2,
                                            fontWeight: FontWeight.w500),
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.incrementChild();
                                        },
                                        child: Icon(Icons.arrow_drop_up_sharp,
                                            color: AppColors.purple,
                                            size: 20),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.decrementChild();
                                        },
                                        child: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: AppColors.purple,
                                            size: 20),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AllHotelView());
                      },
                      child: CustomButton(
                          text: 'Search',
                          textColor: AppColors.backgroundgrayColor,
                          backgroundColor: AppColors.purple,
                          widthPercent: size.width,
                          heightPercent: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
