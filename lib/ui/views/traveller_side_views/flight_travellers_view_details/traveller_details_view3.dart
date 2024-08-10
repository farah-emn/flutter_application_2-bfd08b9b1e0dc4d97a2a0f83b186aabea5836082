// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides, unused_field, prefer_final_fields, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_types_as_parameter_names, unnecessary_null_comparison, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/flight_details_class.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/traveller_details_view1_controller.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/flight_info_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:flutter/services.dart';
import '../../../../controllers/flight_Step3payment_controller.dart';
import '../../../shared/custom_widgets/white_container.dart';

class TravellerDetailsView3 extends StatefulWidget {
  FlightDetailsClass flightdata;
  FlightDetailsClass? ReturnFlightData;
  String flightType;
  TravellerDetailsView3(
      {required this.flightdata,
      this.ReturnFlightData,
      required this.flightType});

  @override
  _TravellerDetailsView3State createState() => _TravellerDetailsView3State();
}

class _TravellerDetailsView3State extends State<TravellerDetailsView3> {
  final FlightStep3paymentController Step3controller =
      Get.put(FlightStep3paymentController());
  final TravellerDetailsView1Controller detailsView1Controller =
      Get.find<TravellerDetailsView1Controller>();
  final SearchViewOneWayController SearchViewOneWay_Controller =
      Get.find<SearchViewOneWayController>();
  final SearchViewRoundTripController SearchViewRoundTrip_Controller =
      Get.find<SearchViewRoundTripController>();
  final FlightInfoController controller_flight =
      Get.find<FlightInfoController>();
  final CurrencyController currencyController = Get.put(CurrencyController());

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountExtraBaggage = 0;
    detailsView1Controller.BaggageAdult.map((Baggage_Option) {
      if (Baggage_Option == BaggageOption.option15kg) {
        totalAmountExtraBaggage = totalAmountExtraBaggage + 100.50;
      }
      if (Baggage_Option == BaggageOption.option20kg) {
        totalAmountExtraBaggage = totalAmountExtraBaggage + 200.87;
      }
      if (Baggage_Option == BaggageOption.option25kg) {
        totalAmountExtraBaggage = totalAmountExtraBaggage + 300.50;
      }
      detailsView1Controller.BaggageChild.map((Baggage_Option) {
        if (Baggage_Option == BaggageOption.option15kg) {
          totalAmountExtraBaggage = totalAmountExtraBaggage + 100.50;
        }
        if (Baggage_Option == BaggageOption.option20kg) {
          totalAmountExtraBaggage = totalAmountExtraBaggage + 200.87;
        }
        if (Baggage_Option == BaggageOption.option25kg) {
          totalAmountExtraBaggage = totalAmountExtraBaggage + 300.50;
        }
      }).toList();
    }).toList();

    //
    double totalPriceTicketFlight = 0;

    if (widget.flightType == 'oneway') {
      totalPriceTicketFlight = (widget.flightdata!.TicketAdultFirstClassPrice *
              detailsView1Controller.AdultList.length) +
          ((widget.flightdata!.TicketAdultFirstClassPrice *
              detailsView1Controller.ChildList.length));
    } else {
      totalPriceTicketFlight = ((widget.flightdata!.TicketAdultFirstClassPrice +
                  widget.ReturnFlightData!.TicketAdultFirstClassPrice) *
              detailsView1Controller.AdultList.length) +
          ((widget.flightdata!.TicketAdultFirstClassPrice +
                  widget.ReturnFlightData!.TicketAdultFirstClassPrice) *
              detailsView1Controller.ChildList.length);
    }
    return SingleChildScrollView(
      child: Container(
        // padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Credit card information',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: decoration.copyWith(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Name of card holder',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                      child: TextField(
                        controller: Step3controller.cardHolderController,
                        onChanged: (value) {},
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.credit_card_rounded,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            Step3controller.errorTextcardHolder.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Card Number',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Step3controller.cardNumberController,
                        onChanged: (value) {},
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.date_range,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            Step3controller.errorTextcardNumber.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Expiry Date (MM)',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: 110,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^\d{2}/\d{2}$')),
                                ],
                                controller:
                                    Step3controller.MMexpiryDateController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                decoration: textFielDecoratiom.copyWith(
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                    borderSide: BorderSide(
                                        color: AppColors.purple, width: 1.5),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.person_2_rounded,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Expiry Date (yy)',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: 110,
                              child: TextFormField(
                                controller:
                                    Step3controller.YYexpiryDateController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^\d{2}/\d{2}$')),
                                ],
                                decoration: textFielDecoratiom.copyWith(
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                    borderSide: BorderSide(
                                        color: AppColors.purple, width: 1.5),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.person_2_rounded,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      'CVV',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 100,
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[.,/]')),
                                    ],
                                    controller: Step3controller.cvvController,
                                    onChanged: (value) {},
                                    decoration: textFielDecoratiom.copyWith(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide: BorderSide(
                                            color: AppColors.purple,
                                            width: 1.5),
                                      ),
                                      fillColor: Colors.white,
                                      prefixIcon: const Icon(
                                        Icons.person_2_rounded,
                                        color: AppColors.gold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        // GetBuilder<HotelSummaryController>(
                        //   init: HotelSummary_Controller,
                        //   builder: (Step3Controller) => Container(
                        //     padding: EdgeInsets.only(top: 0, left: 20),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //       // border: Border.all(
                        //       //   color: Colors.grey,
                        //       //   width: 1.0,
                        //       // ),
                        //     ),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton<String>(
                        //         value: HotelSummary_Controller.Currency,
                        //         onChanged: (String? newValue) {
                        //           if (newValue != null) {
                        //             // HotelSummary_Controller.updateFromCurrency(
                        //             //     newValue);
                        //             // convert(
                        //             //     currencyController.selectedCurrency.value,
                        //             //     Step3Controller.Currency,
                        //             //     totalPriceTicketFlight);
                        //           }
                        //         },
                        //         items: Step3Controller.currencies
                        //             .map<DropdownMenuItem<String>>(
                        //           (String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(
                        //                 value,
                        //                 style: TextStyle(color: AppColors.grayText),
                        //               ),
                        //             );
                        //           },
                        //         ).toList(),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            Step3controller.errorTextYYexpiryDate.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            Step3controller.errorTextMMexpiryDate.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            Step3controller.errorTextcvv.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: screenWidth(30),
                        top: screenHeight(86),
                        bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Total to be paid:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Total flight ticket:',
                              style: TextStyle(
                                fontSize: screenWidth(26),
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${currencyController.convert(currencyController.selectedCurrency.value, totalPriceTicketFlight)}',
                                  style: TextStyle(
                                    fontSize: screenWidth(26),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  currencyController.selectedCurrency.value,
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Total extra baggage:',
                              style: TextStyle(
                                fontSize: screenWidth(26),
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${currencyController.convert(Step3controller.Currency, totalAmountExtraBaggage)}',
                                  style: TextStyle(
                                    fontSize: screenWidth(26),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  currencyController.selectedCurrency.value,
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          children: [
                            Text(
                              'Total amount:',
                              style: TextStyle(
                                fontSize: screenWidth(26),
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${currencyController.convert(currencyController.selectedCurrency.value, totalAmountExtraBaggage + totalPriceTicketFlight)}',
                                  style: TextStyle(
                                    fontSize: screenWidth(26),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  currencyController.selectedCurrency.value,
                                  style: TextStyle(
                                    fontSize: screenWidth(24),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
