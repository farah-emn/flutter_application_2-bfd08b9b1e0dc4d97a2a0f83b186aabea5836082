import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/hotel_finished_booking_card.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';

import 'package:traveling/ui/shared/colors.dart';

import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_search_view.dart';
import 'package:traveling/ui/views/traveller_side_views/car_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateReturnDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_hotel/search_hotel_view.dart';

class SearchView extends StatefulWidget {
  String? DepartureCity;
  String? ArrivalCity;
  SearchView({this.DepartureCity, this.ArrivalCity, Key? key})
      : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String color = 'purple';
  String? _flightSorteBy = 'One Way';

  Color selectedColor = Colors.black;
  bool _isLoading = false;
  List<Color> colors = [
    Colors.black,
    Color.fromARGB(255, 255, 249, 249),
    Colors.grey,
    AppColors.darkBlue,
    Colors.red,
    Colors.brown,
  ];
  List<bool> isSelected = [true, false, false];
  List<bool> isSelectedColor = [true, false, false];
  String dropdownValue2 = 'Toyota';
  bool _isWidgetActive = true;

  String sorteBy = 'Normal';
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
    _tabController = TabController(length: 3, vsync: this);
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
          child: Stack(
            children: [
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
              const Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Search',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )
                      // color == 'purple'
                      //     ? const Text(
                      //         'Search',
                      //         style: TextStyle(
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w700,
                      //             color: AppColors.purple),
                      //       )
                      //     : const Text(
                      //         'Search',
                      //         style: TextStyle(
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w700,
                      //             color: AppColors.backgroundgrayColor),
                      //       )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: size.width - 30,
                  height: 40,
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
                      SearchHotelView(),
                      flightSearch(context),
                      carSearch(context, size),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                  height: 40,
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
                                      return const AlertDialog(
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
                        const Icon(Icons.flight_takeoff, color: AppColors.Blue),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.DepartureCity ?? '',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
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
                  height: 40,
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
                                  return const AlertDialog(
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
                        Icon(Icons.flight_land, color: AppColors.Blue),
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        _flightSorteBy = 'Round Trip';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      width: size.width / 2 - 20,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.Blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add rutern',
                            style:
                                TextStyle(color: AppColors.Blue, fontSize: 16),
                          ),
                        ],
                      ),
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
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.group, color: AppColors.Blue),
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
                                color: AppColors.Blue, size: 20),
                          ),
                          InkWell(
                            onTap: () {
                              controller.decrementAdult();
                            },
                            child: Icon(Icons.arrow_drop_down_sharp,
                                color: AppColors.Blue, size: 20),
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
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.group, color: AppColors.Blue),
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
                                color: AppColors.Blue, size: 20),
                          ),
                          InkWell(
                            onTap: () {
                              controller.decrementChild();
                            },
                            child: Icon(Icons.arrow_drop_down_sharp,
                                color: AppColors.Blue, size: 20),
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
            backgroundColor: AppColors.Blue,
            widthPercent: size.width,
          ),
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
                      height: 40,
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
                            Icon(Icons.flight_takeoff, color: AppColors.Blue),
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
                      height: 40,
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
                                color: AppColors.Blue),
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
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.group, color: AppColors.Blue),
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
                                    color: AppColors.Blue, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.decrementAdult();
                                },
                                child: Icon(Icons.arrow_drop_down_sharp,
                                    color: AppColors.Blue, size: 20),
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
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.group, color: AppColors.Blue),
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
                                    color: AppColors.Blue, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.decrementChild();
                                },
                                child: Icon(Icons.arrow_drop_down_sharp,
                                    color: AppColors.Blue, size: 20),
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
                backgroundColor: AppColors.Blue,
                widthPercent: size.width,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget flightSearch(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.Blue,
                  autofocus: true,
                  value: 'One Way',
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
                  'One Way',
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.Blue,
                  value: 'Round Trip',
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
                  'Round Trip',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _flightSorteBy == 'One Way' ? oneWay(context) : RoundTrip(context)
      ],
    );
  }

  Widget hotelSearch(BuildContext context) {
    return Container();
  }

  Widget carSearch(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text(
              'Seats',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grayText,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        ToggleButtons(
          disabledColor: AppColors.grayText,

          borderColor: AppColors.LightGrayColor,
          borderRadius: BorderRadius.circular(15),
          // focusColor: AppColors.grayText,
          fillColor: AppColors.lightOrange,
          selectedColor: AppColors.blackColor,
          selectedBorderColor: AppColors.lightOrange,
          color: AppColors.grayText,

          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          constraints: BoxConstraints(
            minWidth: size.width / 3 - 14,
            minHeight: 40.0,
          ),
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text('2 Seats'),
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text('4 Seats'),
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text('+6 Seats'),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plate Number',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                  width: size.width / 2 - 35,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: textFielDecoratiom.copyWith(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightOrange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.numbers_rounded,
                          color: AppColors.orange,
                        )),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Speed',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                  width: size.width / 2 - 35,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: textFielDecoratiom.copyWith(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightOrange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.speed,
                          color: AppColors.orange,
                        )),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: const [
            Text(
              'Company',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grayText,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          width: size.width - 35,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.LightGrayColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            padding: EdgeInsets.only(left: 15),
            underline: DecoratedBox(
              decoration: BoxDecoration(),
            ),
            value: dropdownValue2,
            items: <String>[
              'Marceds',
              'KIA',
              'Rang Rover',
              'Roz Raiz',
              'Honday',
              'Honda',
              'Toyota',
              'GMC',
              'Odi',
              'BMW',
              'Other'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: const [
            Text(
              'Ger',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grayText,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: AppColors.orange,
                  value: 'Normal',
                  autofocus: true,
                  groupValue: sorteBy,
                  onChanged: (value) {
                    sorteBy = value.toString();
                  },
                ),
                const Text('Normal'),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.orange,
                  value: 'Automatic',
                  groupValue: sorteBy,
                  onChanged: (value) {
                    sorteBy = value.toString();
                  },
                ),
                const Text('Automatic'),
              ],
            ),
            SizedBox(),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: const [
            Text(
              'Color',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grayText,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: colors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: selectedColor == color
                        ? Border.all(color: Colors.black, width: 3)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            Get.to(CarView());
          },
          child: CustomButton(
            text: 'Search',
            textColor: AppColors.backgroundgrayColor,
            backgroundColor: AppColors.Blue,
            widthPercent: size.width,
          ),
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
