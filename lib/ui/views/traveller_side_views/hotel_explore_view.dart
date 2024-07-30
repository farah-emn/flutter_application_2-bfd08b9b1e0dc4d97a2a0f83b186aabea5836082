// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, library_private_types_in_public_api, deprecated_member_use, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, unused_import, avoid_print
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/hotel_card.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/classes/hotel_info_class.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/custom_widgets/tab_item.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flights_view_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_info_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateReturnDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_round.dart';
// import 'package:traveling/ui/views/traveller_side_views/traveller_details_view/traveller_details_view2.dart';

class AllHotelView extends StatefulWidget {
  String? DepartureCity;
  String? ArrivalCity;
  AllHotelView({this.DepartureCity, this.ArrivalCity, Key? key})
      : super(key: key);

  @override
  AllHotelViewState createState() => AllHotelViewState();
}

class AllHotelViewState extends State<AllHotelView> {
  final TextEditingController dateController = TextEditingController();
  bool? isChecked = false;
  String? sorteBy;
  RangeValues _currentRangeValues = const RangeValues(20, 80);
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
    void _showSortByBottomShest() {
      showModalBottomSheet(
        backgroundColor: AppColors.backgroundgrayColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: size.height * 0.25,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 190, 190, 190),
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Sort By',
                        style: TextStyle(
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 60, bottom: 15),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                autofocus: true,
                                value: 'Our Choice for You',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Our Choice for You',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                value: 'Highest price',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Highest price',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                value: 'Highest Rated',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Highest Rated',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                value: 'Lowest price',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Lowest price',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void _showRatingsBottomShest() {
      showModalBottomSheet(
        backgroundColor: AppColors.backgroundgrayColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: size.height * 0.25,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 190, 190, 190),
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Ratings',
                        style: TextStyle(
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 60, bottom: 15),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                autofocus: true,
                                value: '5 Stars',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                '5 Stars',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                value: '4 Stars',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                '4 Stars',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.purple,
                                value: '3 Stars',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                '3 Stars',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor:
                                    const Color.fromRGBO(111, 50, 153, 1),
                                value: '2 Stars',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                '2 Stars',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor:
                                    const Color.fromRGBO(111, 50, 153, 1),
                                value: '1 Stars',
                                groupValue: sorteBy,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sorteBy = value.toString();
                                    },
                                  );
                                },
                              ),
                              const Text(
                                '1 Stars',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void _showFilttersBottomShest() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (builder) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 190, 190, 190),
                          borderRadius: BorderRadius.circular(20)),
                      width: 50,
                      height: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Guest Rating',
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Excellent',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        '+9.0 Excellent',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Very good',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        '+8.0 Very Good',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Good',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        '+7.0 Good',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Fair',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        '+6.0 Fair',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 1,
                            width: size.width - 30,
                            color: AppColors.gray,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Property Amenity',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? newValue) {
                                          setState(
                                            () {
                                              isChecked = newValue;
                                            },
                                          );
                                        },
                                      ),
                                      const Text('Internet'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? newValue) {
                                          setState(
                                            () {
                                              isChecked = newValue;
                                            },
                                          );
                                        },
                                      ),
                                      const Text('Direct Flight'),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? newValue) {
                                          setState(
                                            () {
                                              isChecked = newValue;
                                            },
                                          );
                                        },
                                      ),
                                      const Text('Direct Flight'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? newValue) {
                                          setState(
                                            () {
                                              isChecked = newValue;
                                            },
                                          );
                                        },
                                      ),
                                      const Text('Direct Flight'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 1,
                            width: size.width - 30,
                            color: AppColors.gray,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Price range',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          RangeSlider(
                            activeColor: AppColors.purple,
                            values: _currentRangeValues,
                            min: 0,
                            max: 100,
                            divisions: 5,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: 50,
                      width: size.width - 30,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Show 259 of 312 flights',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.purple),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.all(10),
                        decoration: decoration.copyWith(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Selected Date',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grayText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: AppColors.grayText,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Number of Rooms',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grayText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '2 Rooms - 3 Adults',
                                      style: TextStyle(
                                          fontSize: TextSize.header2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: _showSortByBottomShest,
                            child: Container(
                              width: size.width / 3 - 15,
                              decoration: decoration.copyWith(),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.sort,
                                    color: AppColors.gold,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Sort By'),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: _showRatingsBottomShest,
                            child: Container(
                              width: size.width / 3 - 15,
                              decoration: decoration.copyWith(),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.gold,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Ratings'),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: _showFilttersBottomShest,
                            child: Container(
                              width: size.width / 3 - 15,
                              decoration: decoration.copyWith(),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.filter_alt_rounded,
                                    color: AppColors.gold,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Filtters'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: hotelInfo.length,
                          itemBuilder: (context, index) => HotelCard(
                            size: size,
                            itemIndex: index,
                            hotelDetails: hotel[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
