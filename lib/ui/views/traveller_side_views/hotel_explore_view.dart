// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, library_private_types_in_public_api, deprecated_member_use, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, unused_import, avoid_print, unused_element, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/hotel_details_card.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/classes/hotel1.dart';
import 'package:traveling/classes/hotel_info_class.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/hotel_controller.dart';
import 'package:traveling/controllers/hotel_filters_search_controller.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/controllers/hotel_search_controller.dart';
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

class AllHotelView extends StatefulWidget {
  List<HotelClass1> Hotels;
  AllHotelView({required this.Hotels, Key? key}) : super(key: key);

  @override
  AllHotelViewState createState() => AllHotelViewState();
}

class AllHotelViewState extends State<AllHotelView> {
  final TextEditingController dateController = TextEditingController();
  bool? isChecked = false;
  String? sorteBy;
  int NumberOfResultFilteredHotelRooms = 0;
  late final List<HotelClass1> hotels;
  final HotelController HotelsController = Get.put(HotelController());
  void _handleDateSelection(String dateText) {
    controller.updateSelectedDate();
    dateController.text = dateText;
  }

  bool? isCheckedFreeWifi = false;
  bool? isCheckedPrivatePool = false;
  bool? isCheckedPrivateParking = false;
  bool? isCheckedCleaningServices = false;
  bool? isCheckedFoodDrink = false;
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());
  final SearchHotelController controller = Get.put(SearchHotelController());
  final HotelController Hotel_Controller = Get.put(HotelController());
  final HotelRoomsController HotelRooms_Controller =
      Get.put(HotelRoomsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _showSortByBottomShest() {
      final HotelFilterSearchController HotelFilterSearch_Controller =
          Get.put(HotelFilterSearchController());
      showModalBottomSheet(
          backgroundColor: AppColors.backgroundgrayColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
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
                                  color:
                                      const Color.fromARGB(255, 190, 190, 190),
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
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 60, bottom: 15),
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   children: [
                                //     Radio(
                                //       activeColor: AppColors.purple,
                                //       autofocus: true,
                                //       value: 'Our Choice for You',
                                //       groupValue: sorteBy,
                                //       onChanged: (value) {
                                //         setModalState(
                                //           () {
                                //             sorteBy = value.toString();
                                //           },
                                //         );
                                //       },
                                //     ),
                                //     const Text(
                                //       'Our Choice for You',
                                //     ),
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: AppColors.purple,
                                      value: 'Highest price',
                                      groupValue: sorteBy,
                                      onChanged: (value) {
                                        setModalState(
                                          () {
                                            sorteBy = value.toString();
                                            HotelFilterSearch_Controller
                                                .sortByForHotels(sorteBy);
                                            Navigator.pop(context);
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
                                      value: 'Lowest price',
                                      groupValue: sorteBy,
                                      onChanged: (value) {
                                        setModalState(
                                          () {
                                            sorteBy = value.toString();
                                            HotelFilterSearch_Controller
                                                .sortByForHotels(sorteBy);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Lowest price',
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
                                        setModalState(
                                          () {
                                            sorteBy = value.toString();
                                            HotelFilterSearch_Controller
                                                .sortByForHotels(sorteBy);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Highest Rated',
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
          });
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
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
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
                                  color:
                                      const Color.fromARGB(255, 190, 190, 190),
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
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 60, bottom: 15),
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
                                        setModalState(
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
                                        setModalState(
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
                                        setModalState(
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
                                        setModalState(
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
                                        setModalState(
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
          });
    }

    void _showFilttersBottomShest() {
      double MinPrice = 0.0;
      double MaxPrice = 0.0;
      final HotelFilterSearchController HotelFilterSearch_Controller =
          Get.put(HotelFilterSearchController());
      final HotelRoomsController HotelRooms_Controller =
          Get.put(HotelRoomsController());
      List<double> HotelRoomPrices = [];
      for (var room in HotelRooms_Controller.hotelsRooms) {
        HotelRoomPrices.add(room.Price.toDouble());
      }
      if (HotelRoomPrices.isNotEmpty) {
        MinPrice = HotelFilterSearch_Controller.convert(
            'USD',
            HotelCurrency_Controller.selectedCurrency.value,
            HotelRoomPrices.reduce(
                (value, element) => value < element ? value : element));
        MaxPrice = HotelFilterSearch_Controller.convert(
            'USD',
            HotelCurrency_Controller.selectedCurrency.value,
            HotelRoomPrices.reduce(
                (value, element) => value > element ? value : element));
      }
      RangeValues _currentRangeValues = RangeValues(MinPrice, MaxPrice);

      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
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
                                // const Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'Guest Rating',
                                //       style: TextStyle(
                                //           fontSize: 13,
                                //           color: AppColors.grayText,
                                //           fontWeight: FontWeight.w500),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Radio(
                                //               activeColor:
                                //                   AppColors.mainColorBlue,
                                //               value: 'Excellent',
                                //               groupValue: sorteBy,
                                //               onChanged: (value) {
                                //                 setModalState(
                                //                   () {
                                //                     sorteBy = value.toString();
                                //                   },
                                //                 );
                                //               },
                                //             ),
                                //             const Text(
                                //               '+9.0 Excellent',
                                //             ),
                                //           ],
                                //         ),
                                //         Row(
                                //           children: [
                                //             Radio(
                                //               activeColor:
                                //                   AppColors.mainColorBlue,
                                //               value: 'Very good',
                                //               groupValue: sorteBy,
                                //               onChanged: (value) {
                                //                 setModalState(
                                //                   () {
                                //                     sorteBy = value.toString();
                                //                   },
                                //                 );
                                //               },
                                //             ),
                                //             const Text(
                                //               '+8.0 Very Good',
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Radio(
                                //               activeColor:
                                //                   AppColors.mainColorBlue,
                                //               value: 'Good',
                                //               groupValue: sorteBy,
                                //               onChanged: (value) {
                                //                 setModalState(
                                //                   () {
                                //                     sorteBy = value.toString();
                                //                   },
                                //                 );
                                //               },
                                //             ),
                                //             const Text(
                                //               '+7.0 Good',
                                //             ),
                                //           ],
                                //         ),
                                //         Row(
                                //           children: [
                                //             Radio(
                                //               activeColor:
                                //                   AppColors.mainColorBlue,
                                //               value: 'Fair',
                                //               groupValue: sorteBy,
                                //               onChanged: (value) {
                                //                 setModalState(
                                //                   () {
                                //                     sorteBy = value.toString();
                                //                   },
                                //                 );
                                //               },
                                //             ),
                                //             const Text(
                                //               '+6.0 Fair',
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Radio(
                                        //       activeColor:
                                        //           AppColors.mainColorBlue,
                                        //       value: 'Free wi-fi',
                                        //       groupValue: sorteBy,
                                        //       onChanged: (value) {
                                        //         sorteBy = value.toString();

                                        //         setModalState(() {
                                        //           // filterFlights(
                                        //           //     _FromSearchController.text,
                                        //           //     _ToSearchController.text,
                                        //           //     isCheckedDirect!,
                                        //           //     isCheckedIndirect!,
                                        //           //     sorteBy,
                                        //           //     _currentRangeValues.start
                                        //           //         .round(),
                                        //           //     _currentRangeValues.end
                                        //           //         .round());
                                        //         });
                                        //       },
                                        //     ),
                                        //     const Text('Free wi-fi'),
                                        //   ],
                                        // ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isCheckedFreeWifi,
                                              onChanged: (bool? newValue) {
                                                setModalState(
                                                  () {
                                                    isCheckedFreeWifi =
                                                        newValue!;
                                                    HotelFilterSearch_Controller
                                                        .FiterPropertyAmentyForHotel(
                                                            isCheckedFreeWifi,
                                                            isCheckedPrivatePool,
                                                            isCheckedCleaningServices,
                                                            isCheckedFoodDrink,
                                                            isCheckedPrivateParking,
                                                            _currentRangeValues); // isCheckedIndirect = false;
                                                    // isCheckedIndirect = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text('Free wi-fi'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isCheckedFoodDrink,
                                              onChanged: (bool? newValue) {
                                                setModalState(
                                                  () {
                                                    isCheckedFoodDrink =
                                                        newValue!;
                                                    HotelFilterSearch_Controller
                                                        .FiterPropertyAmentyForHotel(
                                                            isCheckedFreeWifi,
                                                            isCheckedPrivatePool,
                                                            isCheckedCleaningServices,
                                                            isCheckedFoodDrink,
                                                            isCheckedPrivateParking,
                                                            _currentRangeValues); // isCheckedIndirect = false;
                                                    // isCheckedIndirect = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text('Food & drink'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isCheckedPrivatePool,
                                              onChanged: (bool? newValue) {
                                                setModalState(
                                                  () {
                                                    isCheckedPrivatePool =
                                                        newValue!;
                                                    HotelFilterSearch_Controller
                                                        .FiterPropertyAmentyForHotel(
                                                            isCheckedFreeWifi,
                                                            isCheckedPrivatePool,
                                                            isCheckedCleaningServices,
                                                            isCheckedFoodDrink,
                                                            isCheckedPrivateParking,
                                                            _currentRangeValues); // isCheckedIndirect = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text('Private pool'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isCheckedCleaningServices,
                                              onChanged: (bool? newValue) {
                                                setModalState(
                                                  () {
                                                    isCheckedCleaningServices =
                                                        newValue!;
                                                    HotelFilterSearch_Controller
                                                        .FiterPropertyAmentyForHotel(
                                                            isCheckedFreeWifi,
                                                            isCheckedPrivatePool,
                                                            isCheckedCleaningServices,
                                                            isCheckedFoodDrink,
                                                            isCheckedPrivateParking,
                                                            _currentRangeValues); // isCheckedIndirect = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text('Cleaning services'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isCheckedPrivateParking,
                                      onChanged: (bool? newValue) {
                                        setModalState(
                                          () {
                                            isCheckedPrivateParking = newValue!;
                                            HotelFilterSearch_Controller
                                                .FiterPropertyAmentyForHotel(
                                                    isCheckedFreeWifi,
                                                    isCheckedPrivatePool,
                                                    isCheckedCleaningServices,
                                                    isCheckedFoodDrink,
                                                    isCheckedPrivateParking,
                                                    _currentRangeValues); // isCheckedIndirect = false;
                                          },
                                        );
                                      },
                                    ),
                                    const Text('Private praking'),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
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
                                    min: MinPrice,
                                    max: MaxPrice,
                                    divisions: 100,
                                    labels: RangeLabels(
                                      _currentRangeValues.start
                                          .round()
                                          .toString(),
                                      _currentRangeValues.end
                                          .round()
                                          .toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setModalState(() {
                                        _currentRangeValues = values;
                                        HotelFilterSearch_Controller
                                            .FiterPropertyAmentyForHotel(
                                                isCheckedFreeWifi,
                                                isCheckedPrivatePool,
                                                isCheckedCleaningServices,
                                                isCheckedFoodDrink,
                                                isCheckedPrivateParking,
                                                _currentRangeValues); // isCheckedIndirect = false;
                                      });
                                    }),
                                Row(
                                  children: [
                                    Text(
                                        'Min price: ${_currentRangeValues.start.round()} '),
                                    Text(HotelCurrency_Controller
                                        .selectedCurrency.value),
                                    const Spacer(),
                                    Text(
                                        'Max price: ${_currentRangeValues.end.round()} '),
                                    Text(HotelCurrency_Controller
                                        .selectedCurrency.value)
                                  ],
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              HotelFilterSearch_Controller
                                  .ConfirmFiterPropertyAmentyForHotel(
                                      isCheckedFreeWifi,
                                      isCheckedPrivatePool,
                                      isCheckedCleaningServices,
                                      isCheckedFoodDrink,
                                      isCheckedPrivateParking,
                                      _currentRangeValues);
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              height: 50,
                              width: size.width - 30,
                              decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (isCheckedCleaningServices == false &&
                                          isCheckedFoodDrink == false &&
                                          isCheckedFreeWifi == false &&
                                          isCheckedPrivateParking == false &&
                                          isCheckedPrivatePool == false)
                                      ? Text(
                                          'Show ${controller.validHotels.length} of ${controller.validHotels.length} Roobbdems',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          'Show ${HotelFilterSearch_Controller.FiltersHotels.length} of ${controller.NumberOfHotels} Roobbms',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          });
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
                              children: [
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
                                      '${controller.getFormattedArrivalDate()}  - ${controller.getFormattedDepartureDate()}',
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
                              children: [
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
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      '${controller.Roomscounter} Rooms, ${controller.Adultcounter} Adults, ${controller.Childcounter} Children',
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
                    Obx(() {
                      return (controller.Hotels.isEmpty)
                          ? const CircularProgressIndicator()
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.Hotels.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      Hotel_Controller.setSelectedIndex(index);
                                    },
                                    child: HotelDetailsCard(
                                      size: size,
                                      itemIndex: index,
                                      hotelDetails: controller.Hotels[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }),
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
