// ignore_for_file: body_might_complete_normally_nullable, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateReturnDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_hotel/search_hotel_view.dart';
import '../../../controllers/car_search_controller.dart';
import 'car_search/list_pickup_location_car.dart';
import 'car_search/pickup_time_drop_off_time.dart';
import 'search_flight/DepartureDateDetails.dart';

class SearchView extends StatefulWidget {
  String? DepartureCityOneWay;
  String? ArrivalCityOnyWay;
  String? DepartureCityRoundTrip;
  String? ArrivalCityOnyRoundTrip;
  String? PickUpLocation;

  SearchView(
      {this.DepartureCityOneWay,
      this.ArrivalCityOnyWay,
      this.DepartureCityRoundTrip,
      this.ArrivalCityOnyRoundTrip,
      Key? key})
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
  FlightType? selectedOption;
  bool isFlightTypeSelected = false;
  var selectedFlightType;

  FlightTypeRoundTrip? selectedOptionRounTrip;
  bool isRoundTripFlightTypeSelected = false;
  var selectedRoundTripFlightType;
  void _handleDateSelection(String dateText) {
    controller.updateSelectedDate();
    dateController.text = dateText;
  }

  final SearchViewOneWayController controller =
      Get.put(SearchViewOneWayController());
  final SearchViewOneWayController searchViewOneWayController =
      Get.put(SearchViewOneWayController());
  @override
  void initState() {
    super.initState();
    searchViewRoundTripController.setFlightType('Flight type');
    searchViewOneWayController.setFlightType('Flight type');
    _tabController = TabController(length: 3, vsync: this);
  }

  SearchViewRoundTripController searchViewRoundTripController =
      Get.put(SearchViewRoundTripController());

  @override
  void dispose() {
    super.dispose();
    // searchViewRoundTripController.clearData();
  }

  void _searchForFlights() async {
    if (controller.deoarturecityone != '' &&
        controller.Arrivalcityone != '' &&
        controller.TypeFlight != 'Flight type') {
      controller.fetchFlights();
    } else if (controller.deoarturecityone != '' ||
        controller.Arrivalcityone != '' ||
        controller.TypeFlight != 'Flight type') {
      controller.isloading.value = false;
      Fluttertoast.showToast(
          msg: "Please select all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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

  Future<FlightType?> showFlightTypeOneWayOptions() async {
    selectedOption = selectedFlightType;

    selectedFlightType = await showModalBottomSheet<FlightType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3 + 80,
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (_, searchViewOneWayController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.LightGrayColor, width: 1),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            const Text(
                              'Flight type',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        ListTile(
                          key: UniqueKey(),
                          title: Text('Economy'),
                          leading: Radio<FlightType>(
                            value: FlightType.Economy,
                            groupValue: selectedOption,
                            onChanged: (FlightType? value) {
                              setState(() {
                                selectedOption = value;
                                controller.setFlightType('E');
                                isFlightTypeSelected = true;
                              });
                              Navigator.pop(context, selectedOption);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('First class'),
                          leading: Radio<FlightType>(
                            value: FlightType.FirstClass,
                            groupValue: selectedOption,
                            onChanged: (FlightType? value) {
                              setState(() {
                                selectedOption = value;
                                controller.setFlightType('F');
                                isFlightTypeSelected = true;
                              });
                              Navigator.pop(context, selectedOption);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

    if (selectedFlightType != null) {
      setState(() {
        selectedOption = selectedFlightType;
      });
    }
  }

  Future<FlightTypeRoundTrip?> showFlightTypeRoundTripOptions() async {
    selectedOptionRounTrip = selectedOptionRounTrip;

    selectedRoundTripFlightType =
        await showModalBottomSheet<FlightTypeRoundTrip>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3 + 80,
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (_, contrller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15),
                            const Text(
                              'Flight type',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        ListTile(
                          key: UniqueKey(),
                          title: Text('Economy'),
                          leading: Radio<FlightTypeRoundTrip>(
                            value: FlightTypeRoundTrip.Economy,
                            groupValue: selectedOptionRounTrip,
                            onChanged: (FlightTypeRoundTrip? value) {
                              setState(() {
                                selectedOptionRounTrip = value;
                                searchViewRoundTripController
                                    .setFlightType('E');
                                isRoundTripFlightTypeSelected = true;
                              });
                              Navigator.pop(context, selectedOptionRounTrip);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('First Class'),
                          leading: Radio<FlightTypeRoundTrip>(
                            value: FlightTypeRoundTrip.FirstClass,
                            groupValue: selectedOptionRounTrip,
                            onChanged: (FlightTypeRoundTrip? value) {
                              setState(() {
                                selectedOptionRounTrip = value;
                                searchViewRoundTripController
                                    .setFlightType('F');
                                isFlightTypeSelected = true;
                              });
                              Navigator.pop(context, selectedOptionRounTrip);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

    if (selectedRoundTripFlightType != null) {
      setState(() {
        selectedOptionRounTrip = selectedRoundTripFlightType;
      });
    }
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
                      side:
                          BorderSide(color: AppColors.LightGrayColor, width: 1),
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
                              if (controller.Arrivalcityone.value != '') {
                                if (controller.deoarturecityone.value ==
                                    controller.Arrivalcityone.value) {
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
                                }
                                //   else {
                                //     widget.DepartureCityOneWay =
                                //         result['DepartureCity'];
                                //   }
                                // } else {
                                //   widget.DepartureCityOneWay =
                                //       result['DepartureCity'];
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
                          controller.deoarturecityone.value ?? '',
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
                      side:
                          BorderSide(color: AppColors.LightGrayColor, width: 1),
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
                          if (controller.deoarturecityone.value != '') {
                            if (controller.Arrivalcityone.value ==
                                controller.deoarturecityone.value) {
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
                            }
                            //   else {
                            //     widget.ArrivalCityOnyWay = result['ArrivalCity'];
                            //   }
                            // } else {
                            //   widget.ArrivalCityOnyWay = result['ArrivalCity'];
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
                          controller.Arrivalcityone.value ?? '',
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
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.LightGrayColor, width: 1),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.Blue,
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
                    border:
                        Border.all(color: AppColors.LightGrayColor, width: 1),
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
                                color: AppColors.Blue, size: 17),
                          ),
                          InkWell(
                            onTap: () {
                              controller.decrementAdult();
                            },
                            child: Icon(Icons.arrow_drop_down_sharp,
                                color: AppColors.Blue, size: 17),
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
                    border:
                        Border.all(color: AppColors.LightGrayColor, width: 1),
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
                                color: AppColors.Blue, size: 17),
                          ),
                          InkWell(
                            onTap: () {
                              controller.decrementChild();
                            },
                            child: Icon(Icons.arrow_drop_down_sharp,
                                color: AppColors.Blue, size: 17),
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
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            showFlightTypeOneWayOptions();
          },
          child: Container(
            padding: EdgeInsetsDirectional.only(start: 15, end: 15),
            height: 40,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.LightGrayColor, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person, color: AppColors.Blue),
                SizedBox(width: 10),
                Obx(
                  () => Text(
                    controller.TypeFlight.value ?? '',
                    style: TextStyle(
                      color: (controller.TypeFlight.value == 'Flight type')
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                Icon(Icons.circle_outlined,
                    size: 12, color: AppColors.grayText),
              ],
            ),
          ),
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
    final SearchViewRoundTripController controller =
        Get.put(SearchViewRoundTripController());

    final TextEditingController dateController = TextEditingController();
    final TextEditingController returnDateController = TextEditingController();

    void _searchForFlights() async {
      if (controller.DepartureCityRoundTrip.value != '' &&
          controller.ArrivalCityRoundTrip.value != '' &&
          controller.TypeFlight != 'Flight type') {
        controller.fetchFlights();
      } else if (controller.DepartureCityRoundTrip.value != '' ||
          controller.ArrivalCityRoundTrip.value != '' ||
          controller.TypeFlight != 'Flight type') {
        controller.isloading.value = false;
        Fluttertoast.showToast(
            msg: "Please select all fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    @override
    void dispose() {
      super.dispose();
    }

    void _handleDateSelection(String dateText) {
      controller.updateSelectedDate();
      dateController.text = dateText;
    }

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Column(
          children: [
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
                          side: BorderSide(
                              color: AppColors.LightGrayColor, width: 1),
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
                              if (searchViewRoundTripController
                                      .ArrivalCityRoundTrip.value !=
                                  '') {
                                if (searchViewRoundTripController
                                        .DepartureCityRoundTrip.value ==
                                    searchViewRoundTripController
                                        .ArrivalCityRoundTrip.value) {
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
                                }
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
                                    searchViewRoundTripController
                                        .DepartureCityRoundTrip.value,
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
                          side: BorderSide(
                              color: AppColors.LightGrayColor, width: 1),
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
                              if (searchViewRoundTripController
                                      .DepartureCityRoundTrip.value !=
                                  '') {
                                if (searchViewRoundTripController
                                        .ArrivalCityRoundTrip.value ==
                                    searchViewRoundTripController
                                        .DepartureCityRoundTrip.value) {
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
                                }
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
                                  searchViewRoundTripController
                                      .ArrivalCityRoundTrip.value,
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
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.LightGrayColor, width: 1),
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
                                    color: AppColors.Blue, size: 17),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.decrementAdult();
                                },
                                child: Icon(Icons.arrow_drop_down_sharp,
                                    color: AppColors.Blue, size: 17),
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
                        border: Border.all(
                            color: AppColors.LightGrayColor, width: 1),
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
                                    color: AppColors.Blue, size: 17),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.decrementChild();
                                },
                                child: Icon(Icons.arrow_drop_down_sharp,
                                    color: AppColors.Blue, size: 17),
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
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showFlightTypeRoundTripOptions();
              },
              child: Container(
                padding: EdgeInsetsDirectional.only(start: 15, end: 15),
                height: 40,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.LightGrayColor, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person, color: AppColors.Blue),
                    SizedBox(width: 10),
                    Obx(
                      () => Text(
                        searchViewRoundTripController.TypeFlight.value ?? '',
                        style: TextStyle(
                          color:
                              (searchViewRoundTripController.TypeFlight.value ==
                                      'Flight type')
                                  ? Colors.grey
                                  : Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.circle_outlined,
                        size: 12, color: AppColors.grayText),
                  ],
                ),
              ),
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
            Container(
              width: 20,
              height: 20,
              child: Obx(
                () => (searchViewRoundTripController.isloading.value == true &&
                        searchViewRoundTripController.TypeFlight !=
                            'Flight type' &&
                        searchViewRoundTripController.DepartureCityRoundTrip !=
                            '' &&
                        searchViewRoundTripController.ArrivalCityRoundTrip !=
                            '')
                    ? CircularProgressIndicator()
                    : (searchViewOneWayController.isloading.value == true)
                        ? CircularProgressIndicator()
                        : SizedBox(),
              ),
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
    final TextEditingController PickupDateController = TextEditingController();
    final TextEditingController DropOffDateController = TextEditingController();
    CarSearchController carSearchController = Get.put(CarSearchController());
    void _searchForCar() async {
      if (widget.PickUpLocation != null) {
        carSearchController.setPickUplocation(widget.PickUpLocation ?? '');
      }
      carSearchController.searchForCarRenatl(
          sorteBy, isSelected, selectedColor, dropdownValue2);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //         Container(
        //         width: 20,
        //         height: 20,
        //         child: Obx(
        //           () => (
        //               ? CircularProgressIndicator()
        //               : (searchViewOneWayController.isloading.value == true)
        //                   ? CircularProgressIndicator()
        //                   : SizedBox(),
        //         ),
        //       ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pick up & Drop off location',
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grayText,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          width: size.width,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, elevation: 0,
              backgroundColor: Colors.transparent, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              side: BorderSide(color: AppColors.LightGrayColor, width: 1),
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPickupLocation(),
                ),
              );
              if (result != null) {
                setState(() {
                  widget.PickUpLocation = result['PickUpLocation'];
                });
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.flight_takeoff, color: AppColors.darkGray),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.PickUpLocation ?? '',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        PickupDateDropOffDateDetails(
            onDateSelected: _handleDateSelection,
            ArrivalDate: carSearchController.PickUpDate,
            DepartureDate: carSearchController.DropOffDate,
            DeparturedateController: PickupDateController,
            ArrivalDateController: DropOffDateController),
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
          fillColor: AppColors.lightGray,
          selectedColor: AppColors.blackColor,
          selectedBorderColor: AppColors.lightGray,
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
        // const SizedBox(
        //   height: 20,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           'Plate Number',
        //           style: TextStyle(
        //               fontSize: 13,
        //               color: AppColors.grayText,
        //               fontWeight: FontWeight.w500),
        //         ),
        //         SizedBox(
        //           height: 40,
        //           width: size.width / 2 - 35,
        //           child: TextField(
        //             keyboardType: TextInputType.number,
        //             decoration: textFielDecoratiom.copyWith(
        //                 focusedBorder: const OutlineInputBorder(
        //                   borderSide: BorderSide(
        //                     color: AppColors.lightOrange,
        //                   ),
        //                   borderRadius: BorderRadius.all(Radius.circular(18)),
        //                 ),
        //                 fillColor: Colors.white,
        //                 prefixIcon: const Icon(
        //                   Icons.numbers_rounded,
        //                   color: AppColors.orange,
        //                 )),
        //             onChanged: (value) {},
        //           ),
        //         ),
        //       ],
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           'Top Speed',
        //           style: TextStyle(
        //               fontSize: 13,
        //               color: AppColors.grayText,
        //               fontWeight: FontWeight.w500),
        //         ),
        //         SizedBox(
        //           height: 40,
        //           width: size.width / 2 - 35,
        //           child: TextField(
        //             keyboardType: TextInputType.number,
        //             decoration: textFielDecoratiom.copyWith(
        //                 focusedBorder: const OutlineInputBorder(
        //                   borderSide: BorderSide(
        //                     color: AppColors.lightOrange,
        //                   ),
        //                   borderRadius: BorderRadius.all(Radius.circular(18)),
        //                 ),
        //                 fillColor: Colors.white,
        //                 prefixIcon: const Icon(
        //                   Icons.speed,
        //                   color: AppColors.orange,
        //                 )),
        //             onChanged: (value) {},
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
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
                  activeColor: AppColors.darkGray,
                  value: 'Normal',
                  autofocus: true,
                  groupValue: sorteBy,
                  onChanged: (value) {
                    setState(() {
                      sorteBy = value.toString();
                    });
                  },
                ),
                const Text('Normal'),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.darkGray,
                  value: 'Automatic',
                  groupValue: sorteBy,
                  onChanged: (value) {
                    setState(() {
                      sorteBy = value.toString();
                    });
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
            print('jj9j');
            // Get.to(CarView());
            // if (widget.PickUpLocation != '') {
            //   Fluttertoast.showToast(
            //       msg: "Please select all fields",
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.BOTTOM,
            //       timeInSecForIosWeb: 1,
            //       backgroundColor: Colors.grey,
            //       textColor: Colors.white,
            //       fontSize: 16.0);
            //   ;
            // } else {
            _searchForCar();
            //   }
          },
          child: CustomButton(
            text: 'Search',
            textColor: AppColors.backgroundgrayColor,
            backgroundColor: AppColors.darkGray,
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
