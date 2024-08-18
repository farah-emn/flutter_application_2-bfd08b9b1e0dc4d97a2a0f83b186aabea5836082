// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_local_variable, unnecessary_brace_in_string_interps, prefer_is_empty, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:traveling/cards/flight_details_card.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/flight_filter_search_controller.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../../shared/custom_widgets/custom_search_textfield.dart';

class FlightSearchView extends StatefulWidget {
  const FlightSearchView({super.key});
  @override
  State<FlightSearchView> createState() => _FlightSearchViewState();
}

class _FlightSearchViewState extends State<FlightSearchView> {
  final FlightSearchController controller = FlightSearchController();
  final TextEditingController _fromSearchController = TextEditingController();
  final TextEditingController _toSearchController = TextEditingController();
  final CurrencyController flightCurrencyController =
      Get.find<CurrencyController>();
  var isloading = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    'Flights',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.backgroundgrayColor,
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      // SizedBox(
                      //   height: 45,
                      //   width: size.width - 30,
                      //   child: TextField(
                      //     textAlignVertical: TextAlignVertical.bottom,
                      //     decoration: searchTextFielDecoratiom.copyWith(
                      //       hintText: "Search for flight",
                      //       suffixIcon: InkWell(
                      //         onTap: _showBottomSheet,
                      //         child: const Icon(
                      //           Icons.filter_alt,
                      //           color: AppColors.LightGrayColor,
                      //         ),
                      //       ),
                      //       prefixIcon: const Icon(
                      //         Icons.search,
                      //         color: AppColors.grayText,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 15),
                      // ValueListenableBuilder(
                      //   valueListenable: controller.flightsList,
                      //   builder: (context, value, child) {
                      //     if (controller.flightsList.value.isEmpty) {
                      //       return Center(child: CircularProgressIndicator());
                      //     } else {
                      //       return Expanded(
                      //         child: ListView.builder(
                      //           itemCount: controller.flightsList.value.length,
                      //           itemBuilder: (context, index) {
                      //             return FlightDetailsCard(
                      //               itemIndex: index,
                      //               flightsList:
                      //                   controller.flightsList.value[index],
                      //             );
                      //           },
                      //         ),
                      //       );
                      //     }
                      //   },
                      // )
                      Obx(() {
                        controller.updateFlightsList();
                        if (controller.isloading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: controller.flightsList.value.length,
                              itemBuilder: (context, index) {
                                return FlightDetailsCard(
                                  itemIndex: index,
                                  flightsList:
                                      controller.flightsList.value[index],
                                );
                              },
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    Size size = MediaQuery.of(context).size;
    double LowPrice = flightCurrencyController.convert(
        flightCurrencyController.selectedCurrency.value, 100);
    var prices = controller.filteredFlightsData.entries
        .map((entry) => entry.value['TicketAdultEconomyPrice'].toDouble())
        .toList();
    double MinPrice = 0.0;
    double MaxPrice = 0.0;
    if (prices.isNotEmpty) {
      MinPrice = flightCurrencyController.convert(
          flightCurrencyController.selectedCurrency.value,
          prices.reduce((value, element) => value < element ? value : element));
      MaxPrice = flightCurrencyController.convert(
          flightCurrencyController.selectedCurrency.value,
          prices.reduce((value, element) => value > element ? value : element));
    }
    RangeValues _currentRangeValues = RangeValues(MinPrice, MaxPrice);

    showModalBottomSheet(
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 50,
                        height: 5,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _fromSearchController,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon:
                                      const Icon(Icons.flight_takeoff_outlined),
                                ),
                                onChanged: (value) {
                                  setModalState(() {
                                    controller.sorteBy.value = value.toString();
                                    controller.filterFlights(
                                        _fromSearchController.text,
                                        _toSearchController.text,
                                        controller.isCheckedDirect.value,
                                        controller.isCheckedIndirect.value,
                                        controller.sorteBy.value,
                                        _currentRangeValues.start.round(),
                                        _currentRangeValues.end.round(),
                                        LowPrice);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  'To',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _toSearchController,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon:
                                      const Icon(Icons.flight_takeoff_outlined),
                                ),
                                onChanged: (value) {
                                  setModalState(() {
                                    controller.sorteBy.value = value.toString();
                                    controller.filterFlights(
                                        _fromSearchController.text,
                                        _toSearchController.text,
                                        controller.isCheckedDirect.value,
                                        controller.isCheckedIndirect.value,
                                        controller.sorteBy.value,
                                        _currentRangeValues.start.round(),
                                        _currentRangeValues.end.round(),
                                        LowPrice);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // const Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Stops',
                            //       style: TextStyle(
                            //         fontSize: 13,
                            //         color: AppColors.grayText,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Checkbox(
                            //           value: controller.isCheckedDirect.value,
                            //           onChanged: (bool? newValue) {
                            //             setModalState(() {
                            //               controller.isCheckedDirect.value =
                            //                   newValue!;
                            //               controller.isCheckedIndirect.value =
                            //                   false;
                            //               controller.filterFlights(
                            //                   _fromSearchController.text,
                            //                   _toSearchController.text,
                            //                   controller.isCheckedDirect.value,
                            //                   controller
                            //                       .isCheckedIndirect.value,
                            //                   controller.sorteBy.value,
                            //                   _currentRangeValues.start.round(),
                            //                   _currentRangeValues.end.round(),
                            //                   LowPrice);
                            //             });
                            //           },
                            //         ),
                            //         const Text('Direct Flight'),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Checkbox(
                            //           value: controller.isCheckedIndirect.value,
                            //           onChanged: (bool? newValue) {
                            //             setModalState(() {
                            //               controller.isCheckedIndirect.value =
                            //                   newValue!;
                            //               controller.isCheckedDirect.value =
                            //                   false;
                            //               controller.filterFlights(
                            //                   _fromSearchController.text,
                            //                   _toSearchController.text,
                            //                   controller.isCheckedDirect.value,
                            //                   controller
                            //                       .isCheckedIndirect.value,
                            //                   controller.sorteBy.value,
                            //                   _currentRangeValues.start.round(),
                            //                   _currentRangeValues.end.round(),
                            //                   LowPrice);
                            //             });
                            //           },
                            //         ),
                            //         const Text('Indirect Flight'),
                            //       ],
                            //     ),
                            //   ],
                            // ),
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
                                  'Store by',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                          value: 'Lowest price',
                                          groupValue: controller.sorteBy.value,
                                          onChanged: (value) {
                                            setState(() {
                                              if (controller.sorteBy.value ==
                                                  value) {
                                                controller.sorteBy.value =
                                                    ''; // Deselect if the same value is pressed
                                              } else {
                                                controller.sorteBy.value =
                                                    value.toString();
                                              }
                                              print(
                                                  'Radio button value changed to: ${controller.sorteBy.value}');
                                            });

                                            setModalState(() {
                                              controller.filterFlights(
                                                _fromSearchController.text,
                                                _toSearchController.text,
                                                controller
                                                    .isCheckedDirect.value,
                                                controller
                                                    .isCheckedIndirect.value,
                                                controller.sorteBy.value,
                                                _currentRangeValues.start
                                                    .round(),
                                                _currentRangeValues.end.round(),
                                                LowPrice,
                                              );
                                            });
                                            print('setModalState called');
                                          },
                                        ),
                                        const Text('Lowest price'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          activeColor: AppColors.mainColorBlue,
                                          value: 'Shortest duration',
                                          groupValue: controller.sorteBy.value,
                                          onChanged: (value) {
                                            setModalState(() {
                                              if (controller.sorteBy.value ==
                                                  value.toString()) {
                                                controller.sorteBy.value = '';
                                              } else {
                                                controller.sorteBy.value =
                                                    value.toString();
                                              }
                                              controller.filterFlights(
                                                  _fromSearchController.text,
                                                  _toSearchController.text,
                                                  controller
                                                      .isCheckedDirect.value,
                                                  controller
                                                      .isCheckedIndirect.value,
                                                  controller.sorteBy.value,
                                                  _currentRangeValues.start
                                                      .round(),
                                                  _currentRangeValues.end
                                                      .round(),
                                                  LowPrice);
                                            });
                                          },
                                        ),
                                        const Text('Shortest duration'),
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
                                          value: 'Earliest departure',
                                          groupValue: controller.sorteBy.value,
                                          onChanged: (value) {
                                            setModalState(() {
                                              if (controller.sorteBy.value ==
                                                  value.toString()) {
                                                controller.sorteBy.value = '';
                                              } else {
                                                controller.sorteBy.value =
                                                    value.toString();
                                              }
                                              controller.filterFlights(
                                                  _fromSearchController.text,
                                                  _toSearchController.text,
                                                  controller
                                                      .isCheckedDirect.value,
                                                  controller
                                                      .isCheckedIndirect.value,
                                                  controller.sorteBy.value,
                                                  _currentRangeValues.start
                                                      .round(),
                                                  _currentRangeValues.end
                                                      .round(),
                                                  LowPrice);
                                            });
                                          },
                                        ),
                                        const Text('Earliest departure'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          activeColor: AppColors.mainColorBlue,
                                          value: 'Latest duration',
                                          groupValue: controller.sorteBy.value,
                                          onChanged: (value) {
                                            setModalState(() {
                                              if (controller.sorteBy.value ==
                                                  value.toString()) {
                                                controller.sorteBy.value = '';
                                              } else {
                                                controller.sorteBy.value =
                                                    value.toString();
                                              }

                                              controller.filterFlights(
                                                  _fromSearchController.text,
                                                  _toSearchController.text,
                                                  controller
                                                      .isCheckedDirect.value,
                                                  controller
                                                      .isCheckedIndirect.value,
                                                  controller.sorteBy.value,
                                                  _currentRangeValues.start
                                                      .round(),
                                                  _currentRangeValues.end
                                                      .round(),
                                                  LowPrice);
                                            });
                                          },
                                        ),
                                        const Text('Latest duration'),
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
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RangeSlider(
                                  values: _currentRangeValues,
                                  min: MinPrice,
                                  max: MaxPrice,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    _currentRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    setModalState(() {
                                      _currentRangeValues = values;
                                      controller.filterFlights(
                                          _fromSearchController.text,
                                          _toSearchController.text,
                                          controller.isCheckedDirect.value,
                                          controller.isCheckedIndirect.value,
                                          controller.sorteBy.value,
                                          _currentRangeValues.start.round(),
                                          _currentRangeValues.end.round(),
                                          LowPrice);
                                    });
                                  },
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Min price: ${_currentRangeValues.start.round()} '),
                                    Text(controller.flightCurrencyController
                                        .selectedCurrency.value),
                                    const Spacer(),
                                    Text(
                                        'Max price: ${_currentRangeValues.end.round()} '),
                                    Text(controller.flightCurrencyController
                                        .selectedCurrency.value),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.Confirm(
                              _fromSearchController,
                              _toSearchController,
                              LowPrice,
                              _currentRangeValues);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          height: 50,
                          width: size.width - 30,
                          decoration: BoxDecoration(
                            color: AppColors.Blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Show ${controller.NumberOfResultFilteredflights} of ${controller.filteredFlightsData.length} flights',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
