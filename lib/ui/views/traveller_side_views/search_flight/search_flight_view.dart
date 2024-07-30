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
import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateReturnDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_round.dart';
// import 'package:traveling/ui/views/traveller_side_views/traveller_details_view/traveller_details_view2.dart';

class SearchFlightView extends StatefulWidget {
  String? DepartureCity;
  String? ArrivalCity;
  SearchFlightView({this.DepartureCity, this.ArrivalCity, Key? key})
      : super(key: key);

  @override
  SearchFlightViewState createState() => SearchFlightViewState();
}

class SearchFlightViewState extends State<SearchFlightView> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.StatusBarColor,
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
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.backgroundgrayColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
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
                          oneWay(context),
                          RoundTrip(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget oneWay(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage(
                'assets/image/png/line2.png',
              ),
            ),
            // Spacer(),
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
                      'From',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grayText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  width: size.width - 50,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, elevation: 0,
                      backgroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(color: Colors.transparent, width: 0),
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
                                        title: Text('Invalid City Selection'),
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
                                widget.DepartureCity = result['DepartureCity'];
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
                Container(
                  width: size.width - 50,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, elevation: 0,
                      backgroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(color: Colors.transparent, width: 0),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListCityArrivalOneWay(),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          if (widget.DepartureCity != '') {
                            if (result['ArrivalCity'] == widget.DepartureCity) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Invalid City Selection'),
                                    content: Text(
                                        'Arrival city cannot be the same as the departure city.'),
                                  );
                                },
                              );
                            } else {
                              widget.ArrivalCity = result['ArrivalCity'];
                            }
                          } else {
                            widget.ArrivalCity = result['ArrivalCity'];
                          }
                        });
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.flight_land, color: AppColors.gold),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.ArrivalCity ?? '',
                          style: TextStyle(
                              fontSize: TextSize.header2,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
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
                      'Depature Date',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grayText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                DepartureDateDetails(
                  onDateSelected: _handleDateSelection,
                  Departure_date: controller.departureDate,
                  datecontroller: dateController,
                ),
              ],
            ),
            GestureDetector(
              // onTap: () {
              //   Get.to(
              //     SearchViewRoundTrip(DepartureCity: '', ArrivalCity: ''),
              //   );
              // },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    width: size.width / 2 - 20,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.gold,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add rutern',
                          style: TextStyle(
                              color: AppColors.darkBlue, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.incrementAdult();
                            },
                            child: Icon(Icons.arrow_drop_up_sharp,
                                color: AppColors.darkBlue, size: 20),
                          ),
                          InkWell(
                            onTap: () {
                              controller.decrementAdult();
                            },
                            child: Icon(Icons.arrow_drop_down_sharp,
                                color: AppColors.darkBlue, size: 20),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.incrementChild();
                            },
                            child: Icon(Icons.arrow_drop_up_sharp,
                                color: AppColors.darkBlue, size: 20),
                          ),
                          InkWell(
                            onTap: () {
                              controller.decrementChild();
                            },
                            child: Icon(Icons.arrow_drop_down_sharp,
                                color: AppColors.darkBlue, size: 20),
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
          onTap: _searchForFlights,
          child: CustomButton(
              text: 'Search',
              textColor: AppColors.backgroundgrayColor,
              backgroundColor: AppColors.BlueText,
              widthPercent: 1.1,
              heightPercent: 15),
        ),
      ],
    );
  }

  Widget RoundTrip(BuildContext context) {
    String? DepartureCity;
    String? ArrivalCity;
    final SearchViewRoundTripController controller =
        Get.put(SearchViewRoundTripController());

    final TextEditingController dateController = TextEditingController();
    final TextEditingController returnDateController = TextEditingController();
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
    }

    @override
    void dispose() {
      super.dispose();
    }

    void _handleDateSelection(String dateText) {
      controller.updateSelectedDate();
      dateController.text = dateText;
    }

    // RoundTrip({
    //   this.DepartureCity,
    //   this.ArrivalCity,
    // });
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage(
                    'assets/image/png/line2.png',
                  ),
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
                          'From',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width - 50,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, elevation: 0,
                          backgroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: BorderSide(color: Colors.transparent, width: 0),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListDepartureCityRound(),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              if (widget.ArrivalCity != '') {
                                if (result['DepartureCity'] ==
                                    widget.ArrivalCity) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Invalid City Selection'),
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
                                widget.DepartureCity = result['DepartureCity'];
                              }
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.flight_takeoff, color: AppColors.gold),
                            Column(
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 18, top: 8),
                                  child: Text(
                                    widget.DepartureCity ?? '',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                    Container(
                      width: size.width - 50,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, elevation: 0,
                          backgroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: BorderSide(color: Colors.transparent, width: 0),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListCityArrivalRound(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              if (widget.DepartureCity != '') {
                                if (result['ArrivalCity'] ==
                                    widget.DepartureCity) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Invalid City Selection'),
                                        content: Text(
                                            'Arrival city cannot be the same as the departure city.'),
                                      );
                                    },
                                  );
                                } else {
                                  widget.ArrivalCity = result['ArrivalCity'];
                                }
                              } else {
                                widget.ArrivalCity = result['ArrivalCity'];
                              }
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.flight_land_rounded,
                                color: AppColors.gold),
                            SizedBox(
                              width: 10,
                            ),
                            Column(children: [
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18, top: 8),
                                child: Text(
                                  widget.ArrivalCity ?? '',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            DepartureDateReturnDateDetails(
                onDateSelected: _handleDateSelection,
                Departure_date: controller.departureDate,
                Return_date: controller.ReturnDate,
                datecontroller: dateController,
                returnDateController: returnDateController),
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
                          'Adults Number',
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
                          GetBuilder<SearchViewRoundTripController>(
                            init: SearchViewRoundTripController(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.incrementAdult();
                                },
                                child: Icon(Icons.arrow_drop_up_sharp,
                                    color: AppColors.darkBlue, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.decrementAdult();
                                },
                                child: Icon(Icons.arrow_drop_down_sharp,
                                    color: AppColors.darkBlue, size: 20),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.group, color: AppColors.gold),
                          SizedBox(
                            width: 10,
                          ),
                          GetBuilder<SearchViewRoundTripController>(
                            init: SearchViewRoundTripController(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.incrementChild();
                                },
                                child: Icon(Icons.arrow_drop_up_sharp,
                                    color: AppColors.darkBlue, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.decrementChild();
                                },
                                child: Icon(Icons.arrow_drop_down_sharp,
                                    color: AppColors.darkBlue, size: 20),
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
              onTap: _searchForFlights,
              child: CustomButton(
                  text: 'Search',
                  textColor: AppColors.backgroundgrayColor,
                  backgroundColor: AppColors.mainColorBlue,
                  widthPercent: 1.1,
                  heightPercent: 15),
            ),
          ],
        ),
      ],
    );
  }
}
