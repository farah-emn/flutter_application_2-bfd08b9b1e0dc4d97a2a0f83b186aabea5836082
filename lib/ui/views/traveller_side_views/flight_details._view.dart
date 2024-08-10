// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, unnecessary_string_escapes, use_build_context_synchronously, deprecated_member_use, unused_label, empty_statements, must_be_immutable, overridden_fields, use_key_in_widget_constructors, annotate_overrides, unused_field

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/flight_details_class.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/controllers/traveller_details_view1_controller.dart';
import 'package:traveling/controllers/flight_info_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flight_summery_oneway_view.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view/flight_summery_roundtrip_view.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/traveller_details_view1.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/traveller_details_view3.dart';

import '../../../controllers/flight_Step3payment_controller.dart';

class FlightDetailsView extends StatefulWidget {
  final FlightDetailsClass flightdata;
  final FlightDetailsClass? ReturnFlightData;
  Key? key;
  String? type;

  FlightDetailsView(
      {required this.flightdata, this.key, this.type, this.ReturnFlightData});

  @override
  State<FlightDetailsView> createState() => _FlightDetailsViewState();
}

class _FlightDetailsViewState extends State<FlightDetailsView> {
  int _activeStepIndex = 0;
  final FlightStep3paymentController controller =
      Get.put(FlightStep3paymentController());
  final dataController = Get.put(TravellerDetailsView1Controller());
  int _nextStep = 1;
  ValueNotifier<bool> isFormValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  final TravellerDetailsView1Controller detailsView1Controller =
      Get.find<TravellerDetailsView1Controller>();
  final SearchViewOneWayController SearchViewOneWay_Controller =
      Get.find<SearchViewOneWayController>();
  // // FormControllerOneWay FormController_OneWay = Get.put(FormControllerOneWay());
  // FormControllerRoundTrip FormController_RoundTrip =
  //     Get.put(FormControllerRoundTrip());

  @override
  void dispose() {
    isFormValid.removeListener(updateStep);

    super.dispose();
  }

  // GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  final TravellerDetails_Controller =
      Get.find<TravellerDetailsView1Controller>();
  List<Step> StepsList() {
    return <Step>[
      Step(
        title: Text('Flight\nSummery'),
        content: FlightSummery(flightdata: widget.flightdata),
        state: _activeStepIndex > 0 ? StepState.complete : StepState.disabled,
        isActive: _activeStepIndex >= 0,
      ),
      Step(
        title: Text('Travellar\nDetails'),
        content:
            TravellerDetailsView1(type: widget.type, isFormValid: isFormValid),
        state: _activeStepIndex > 1 ? StepState.complete : StepState.disabled,
        isActive: _activeStepIndex >= 1,
      ),
      Step(
          title: Text('Payments'),
          content: TravellerDetailsView3(
            flightType: widget.type ?? '',
            flightdata: widget.flightdata,
            ReturnFlightData: widget.ReturnFlightData,
          ),
          state: StepState.disabled,
          isActive: _activeStepIndex >= 2),
    ];
  }

  void updateStep() {
    if (isFormValid.value && _activeStepIndex < StepsList().length - 1) {
      setState(() {
        _activeStepIndex += 1;
      });
    }
  }

  final TravellerDetailsView1_Controller =
      Get.put(TravellerDetailsView1Controller());

  @override
  Widget build(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;
    String? userName;
    List<Step> StepsList() {
      return <Step>[
        Step(
          title: Text('Flight\nSummery'),
          content: (widget.type == 'oneway')
              ? FlightSummery(flightdata: widget.flightdata)
              : FlightSummeryRoundTrip(
                  flightdata: widget.flightdata,
                  ReturnFlightData: widget.ReturnFlightData,
                ),
          state: _activeStepIndex > 0 ? StepState.complete : StepState.disabled,
          isActive: _activeStepIndex >= 0,
        ),
        Step(
          title: Text('Travellar\nDetails'),
          content: TravellerDetailsView1(
            type: widget.type,
            // key: widget.key,
            isFormValid: isFormValid,
          ),
          state: _activeStepIndex > 1 ? StepState.complete : StepState.disabled,
          isActive: _activeStepIndex >= 1,
        ),
        Step(
            title: Text('Payments'),
            content: TravellerDetailsView3(
              flightType: widget.type ?? '',
              flightdata: widget.flightdata,
              ReturnFlightData: widget.ReturnFlightData,
            ),
            state:
                _activeStepIndex > 2 ? StepState.complete : StepState.disabled,
            isActive: _activeStepIndex >= 2),
      ];
    }

    return Scaffold(
        backgroundColor: AppColors.LightBlueColor,
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Image.asset('assets/image/png/plane_white.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 80,
                  ),
                  child: Image.asset('assets/image/png/universe_icon.png'),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenHeight(10), start: screenWidth(12)),
                child: Column(
                  children: [
                    Text(
                      widget.flightdata.DepartureCity,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.flightdata.DeparureTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenHeight(10), start: screenWidth(1.3)),
                child: Column(
                  children: [
                    Text(
                      widget.flightdata.ArrivalCity,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.flightdata.ArrivalTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.only(top: 180),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/png/background1.png'),
                        fit: BoxFit.fill),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 220),
              child: Stepper(
                  elevation: 0,
                  steps: StepsList(),
                  type: StepperType.horizontal,
                  currentStep: _activeStepIndex,
                  onStepContinue: () async {
                    final isLastStep =
                        _activeStepIndex == StepsList().length - 1;
                    if (isLastStep) {
                      print(isLastStep);
                      //   print('ggggg');
                      //   if (detailsView1Controller.AdultList.isNotEmpty) {
                      //     if (widget.type == 'oneway') {
                      //       _activeStepIndex += 1;

                      //       // if (FormController_OneWay.validateForm()) {
                      //       //   setState(() {
                      //       //     _activeStepIndex += 1;
                      //       //     FormController_OneWay.resetForm();
                      //       //     FormController_OneWay.formKey.currentState
                      //       //         ?.reset();
                      //       //   });
                      //       // } else {
                      //       //   print('Form is not valid');
                      //       // }
                      //     }
                      //     if (widget.type == 'RoundTrip') {
                      //       _activeStepIndex += 1;

                      //       // if (FormController_RoundTrip.validateForm()) {
                      //       // setState(() {
                      //       //   _activeStepIndex += 1;
                      //       //   FormController_RoundTrip.resetForm();
                      //       //   FormController_RoundTrip.formKey.currentState
                      //       //       ?.reset();
                      //       // });
                      //     } else {
                      //       //   print('Form is not valid');
                      //       // }
                      //     }
                      //   } else {
                      //     Fluttertoast.showToast(
                      //         msg: "Please add details for Travellers",
                      //         toastLength: Toast.LENGTH_SHORT,
                      //         gravity: ToastGravity.BOTTOM,
                      //         timeInSecForIosWeb: 1,
                      //         backgroundColor: Colors.grey,
                      //         textColor: Colors.white,
                      //         fontSize: 16.0);
                      //   }
                      // }
                      // } else if (_activeStepIndex == StepsList().length - 1) {
                      // if (await controller.validateCreditCard()) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: Colors.white,
                              child: Container(
                                width: screenWidth(1),
                                height: screenHeight(2.4),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: screenWidth(1.5),
                                            top: screenHeight(70)),
                                        child: InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Image.asset(
                                            'assets/image/png/cancel_icon.png',
                                          ),
                                        )),
                                    SizedBox(
                                      height: screenHeight(60),
                                    ),
                                    Image.asset(
                                        'assets/image/png/success_icon.png',
                                        alignment: Alignment.bottomLeft,
                                        width: screenWidth(4)),
                                    SizedBox(
                                      height: screenHeight(80),
                                    ),
                                    Text(
                                      'SUCCESS!',
                                      style: TextStyle(
                                          color: AppColors.mainColorBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth(16)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Your flight has been\n\ booked successfully.',
                                          style: TextStyle(
                                              fontSize: screenWidth(24),
                                              color: Color.fromARGB(
                                                  255, 112, 110, 110)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ConfirmBooking();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 15,
                                        ),
                                        child: CustomButton(
                                          backgroundColor: AppColors.Blue,
                                          text: 'Confirm',
                                          textColor:
                                              AppColors.backgroundgrayColor,
                                          widthPercent: size.width,
                                          ),
                                    ),),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (_activeStepIndex == 0) {
                      setState(() {
                        _activeStepIndex += 1;
                      });

                      // Fluttertoast.showToast(
                      //     msg: "Please add details for credit card",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.BOTTOM,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.grey,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0);
                    } else if (_activeStepIndex == 1) {
                      // if (TravellerDetailsView1_Controller
                      //             .validateContactDetails ==
                      //         true &&
                      //     TravellerDetailsView1_Controller.AdultList.isNotEmpty)
                      setState(() {
                        _activeStepIndex += 1;
                      });
                      // else {
                      //   Fluttertoast.showToast(
                      //       msg: "Please add details for Travellers",
                      //       toastLength: Toast.LENGTH_SHORT,
                      //       gravity: ToastGravity.BOTTOM,
                      //       timeInSecForIosWeb: 1,
                      //       backgroundColor: Colors.grey,
                      //       textColor: Colors.white,
                      //       fontSize: 16.0);
                      // }
                    }
                    onStepCancel:
                    () async {
                      // if (_activeStepIndex == 0) {
                      //   return;
                      // }
                      if (_activeStepIndex != 0) {
                        setState(() {
                          _activeStepIndex -= 1;

                          _nextStep -= 1;
                        });
                      }
                    };
                  }),
            )
          ],
        ));
  }

  Future<void> ConfirmBooking() async {
    // DatabaseReference ref = FirebaseDatabase.instance.reference();
    // List<String?> passengerIds = [];
    // final dataController = Get.find<TravellerDetailsView1Controller>();
    // // final FlightInfoController controller_flight =
    // //     Get.find<FlightInfoController>();
    // final SearchViewOneWayController SearchViewOneWay_controller =
    //     Get.find<SearchViewOneWayController>();
    // final Step3controller = Get.find<Step3Controller>();
    // // double totalPriceTicketFlight =
    // //     controller_flight.flightInfo.value.Flight_price;

    // ref.child('flights').onChildAdded.listen((event) {
    //   // late String DeparureDate =
    //   //     controller_flight.flightInfo.value.DeparureDate;
    //   // late String ReturnDate = controller_flight.flightInfo.value.ArrivalDate;
    //   // late String DeparureCity =
    //   //     controller_flight.flightInfo.value.DeparureCity;
    //   // late String ArrivalCity = controller_flight.flightInfo.value.ArrivalCity;

    //   bool seat_passengers_Adult_Condition = (event.snapshot
    //           .child('Available_seat_passengers_Adult')
    //           .value as int) >=
    //       dataController.AdultList.length;
    //   print(seat_passengers_Adult_Condition);

    //   bool seat_passengers_Child_Condition = (event.snapshot
    //           .child('Available_seat_passengers_children')
    //           .value as int) >=
    //       dataController.ChildList.length;

    //   for (int index = 0; index < dataController.AdultList.length; index++) {
    //     print(dataController.AdultList[index].givenName);
    //     DatabaseReference ref1 = FirebaseDatabase.instance.reference();

    //     ref1.child('passenger').push().set({
    //       "Firstname": dataController.AdultList[index].givenName,
    //       "Lastname": dataController.AdultList[index].surname,
    //       "Nationality": dataController.AdultList[index].nationality,
    //       "birthDate": dataController.AdultList[index].birthDate,
    //       "PassportNumber": dataController.AdultList[index].passportNumber,
    //       "Gender": dataController.AdultList[index].gender,
    //       "issuingCountryPassport":
    //           dataController.AdultList[index].issuingCountry,
    //       "ExpirationDatePassport": dataController.AdultList[index].expiration,
    //       "FlightId": event.snapshot.key
    //     });
    //     passengerIds
    //         .add('p${index + 1}-${dataController.AdultList[index].givenName}');
    //     int bookingid = 1;

    //     var bookingRef = ref.child('booking').push();
    //     bookingRef.set({
    //       'passengerIds': passengerIds,
    //       'flightId': event.snapshot.key,
    //       'TotalTicketPrice': Step3controller.totalPriceTicketFlight
    //     });

    //     var bookingId = bookingRef.key;
    //     FirebaseDatabase.instance
    //         .reference()
    //         .child('ContactPassenger')
    //         .push()
    //         .set({
    //       'Email': TravellerDetailsView1_Controller.EmailContactDetails,
    //       'MobileNumber':
    //           TravellerDetailsView1_Controller.MobileNumberContactDetails,
    //       'FirstName': TravellerDetailsView1_Controller.FirstNameContactDetails,
    //       'LastName': TravellerDetailsView1_Controller.LastNameContactDetails,
    //       'bookingId': bookingId
    //     });
    //     final SearchViewRoundTripController SearchViewround_Controller =
    //         Get.find<SearchViewRoundTripController>();

    //     SearchViewOneWay_Controller.clearData();
    //     // SearchViewround_Controller.clearData();
    //     detailsView1Controller.clearData();
    //     Step3controller.clearData();
    //   }
    //   // }
    // });
    Get.to(Home());
  }
}
