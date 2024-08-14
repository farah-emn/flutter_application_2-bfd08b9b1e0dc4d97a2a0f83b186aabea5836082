// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unnecessary_string_escapes, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/car_class1.dart';
import 'package:traveling/controllers/car_customer_details.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import '../../../controllers/car_payment.dart';
import '../../../controllers/car_search_controller.dart';
// import '../../../controllers/car_user_booking_controller.dart';
import '../../../controllers/currency_controller.dart';
import '../../../controllers/text_only_input_formatter.dart';
import '../../shared/custom_widgets/custom_button.dart';

bool is3 = false;

class BookingCarSummaryView extends StatefulWidget {
  CarClass1 CarDeails;
  BookingCarSummaryView({super.key, required this.CarDeails});

  @override
  State<BookingCarSummaryView> createState() => _BookingCarSummaryViewState();
}

class _BookingCarSummaryViewState extends State<BookingCarSummaryView> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int activeStepIndex = 0;
  int _nextStep = 1;
  final CarCustomerController carCustomerController =
      Get.put(CarCustomerController());
  final CarStep3paymentController HotelSummary_Controller =
      Get.put(CarStep3paymentController());

  late int id_Car_booking;
  User? user;
  final _auth = FirebaseAuth.instance;
  var uid;
  var currentUser;
  var userid;
  @override
  void initState() {
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    userid = _auth.currentUser;
    final databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference idRefhotel_booking =
        databaseReference.child('CarBooking');
    idRefhotel_booking.once().then((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          id_Car_booking = event.snapshot.children.length + 1;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Step> StepsList() {
      return <Step>[
        Step(
          title: const Text(
            'Booking\nSummery',
            style: TextStyle(fontSize: TextSize.header2),
          ),
          content: step1(context, widget.CarDeails),
          state: activeStepIndex > 0 ? StepState.complete : StepState.disabled,
          isActive: activeStepIndex >= 0,
        ),
        Step(
          title: const Text(
            'Guest\nDetails',
            style: TextStyle(fontSize: TextSize.header2),
          ),
          content: step2(
              context,
              widget.CarDeails,
              _emailController,
              _firstNameController,
              _lastNameController,
              _mobileNumberController),
          state: activeStepIndex > 1 ? StepState.complete : StepState.disabled,
          isActive: activeStepIndex >= 1,
        ),
        Step(
            title: const Text(
              'Payment',
              style: TextStyle(fontSize: TextSize.header2),
            ),
            content: step3(context, widget.CarDeails),
            state: StepState.disabled,
            isActive: activeStepIndex >= 2),
      ];
    }

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Stack(children: [
          Container(
            color: AppColors.lightGray,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.darkGray,
                      ),
                      Text(
                        'Add Room',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGray),
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.lightGray,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/png/background1.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.backgroundgrayColor,
                  margin: const EdgeInsets.only(
                    top: 100,
                  ),
                  child: Theme(
                    data: ThemeData(
                        colorScheme: const ColorScheme.light(
                      primary: AppColors.darkGray,
                      background: AppColors.backgroundgrayColor,
                    )),
                    child: Stepper(
                      elevation: 0,
                      steps: StepsList(),
                      type: StepperType.horizontal,
                      currentStep: activeStepIndex,
                      onStepContinue: () async {
                        final isLastStep =
                            activeStepIndex == StepsList().length - 1;
                        if (activeStepIndex < StepsList().length - 1) {
                          if (activeStepIndex == 0) {
                            setState(() {
                              activeStepIndex += 1;
                            });
                          } else if (activeStepIndex == 1) {
                            if (await carCustomerController
                                .validateGuest()) if (carCustomerController
                                        .EmailContactDetails !=
                                    '' &&
                                carCustomerController
                                        .MobileNumberContactDetails !=
                                    '' &&
                                carCustomerController.FirstNameContactDetails !=
                                    '' &&
                                carCustomerController.LastNameContactDetails !=
                                    '')
                              setState(() {
                                activeStepIndex += 1;
                              });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please add details for Travellers",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else if (isLastStep) {
                          if (await HotelSummary_Controller.validateCreditCard(
                              widget.CarDeails.rentalInDay)) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: size.width,
                                      height: 450,
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.cancel,
                                                color: AppColors.darkGray,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Icon(
                                            Icons.check_circle_outlined,
                                            color: AppColors.darkGray,
                                            size: 100,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'SUCCESS!',
                                            style: TextStyle(
                                                color: AppColors.darkGray,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Your car has been\n\ booked successfully.',
                                                style: TextStyle(
                                                    fontSize: TextSize.header2,
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
                                              ConfirmBooking(widget.CarDeails,
                                                  id_Car_booking, uid, context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 15,
                                              ),
                                              child: CustomButton(
                                                backgroundColor:
                                                    AppColors.darkGray,
                                                text: 'Confirm',
                                                textColor: AppColors
                                                    .backgroundgrayColor,
                                                widthPercent: size.width,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else {}
                        }
                      },
                      onStepCancel: () {
                        activeStepIndex == 0
                            ? null
                            : setState(() {
                                activeStepIndex -= 1;
                              });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget step1(BuildContext context, CarClass1 carDeails) {
  CarSearchController carSearchController = Get.put(CarSearchController());
  final CurrencyController controller = Get.put(CurrencyController());

  int calculateNumberOfNights() {
    DateTime? startDate = carSearchController.PickUpDate.value;
    DateTime? endDate = carSearchController.DropOffDate.value;

    if (startDate != null && endDate != null) {
      int nights = endDate.difference(startDate).inDays;
      if (nights == 0 && endDate.isAfter(startDate)) {
        nights = 1;
      }
      return nights;
    } else {
      return 1;
    }
  }

  int numberOfNights = calculateNumberOfNights();

  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/image/png/car.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 160,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // '${carDeails.companyRentailName}-
                        '${carDeails.company}-${carDeails.model}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.speed,
                            color: AppColors.darkGray,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            carDeails.topSpeed,
                            style: TextStyle(color: AppColors.grayText),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car_filled,
                            color: AppColors.darkGray,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            carDeails.ger,
                            style: TextStyle(color: AppColors.grayText),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.flight_class,
                            color: AppColors.darkGray,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            carDeails.seats,
                            style: TextStyle(color: AppColors.grayText),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              // left: 15,
              // right: 15,
              bottom: 15,
              top: 20,
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Number of days',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${numberOfNights} night',
                            style: TextStyle(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pick-up Date',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            _getFormattedDate(
                                carSearchController.getFormattedPickUpDate()),
                            style: TextStyle(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Drop-off Date',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          Text(
                            _getFormattedDate(
                                carSearchController.getFormattedDropOffDate()),
                            style: TextStyle(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              // left: 15,
              // right: 15,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cancellation policy',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              // left: 15,
              // right: 15,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Service fee & tax',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

String _getFormattedCity(String City) {
  final List<String> parts = City.split(',');
  if (parts.length >= 2) {
    final String City = parts[0];

    return '$City';
  } else {
    return '';
  }
}

String _getFormattedDate(String date) {
  String day = '';
  final DateFormat inputFormat = DateFormat('d. M, yyyy');
  final DateFormat outputFormat = DateFormat('MMMM');
  final List<String> parts = date.split('.');
  if (parts.length >= 2) {
    day = parts[0].trim();
  }

  DateTime dateTime;
  try {
    dateTime = inputFormat.parse(date);
  } catch (e) {
    return '';
  }

  String monthName = outputFormat.format(dateTime);
  String year = dateTime.year.toString();
  return '$day. $monthName, $year';
}

Widget step2(
    BuildContext context,
    CarClass1 carDeails,
    TextEditingController emailController,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
    TextEditingController mobileNumberController) {
  final CarCustomerController carCustomerController =
      Get.put(CarCustomerController());
  final CurrencyController currencycontroller = Get.put(CurrencyController());
  final CarSearchController carSearchController =
      Get.put(CarSearchController());
  Size size = MediaQuery.of(context).size;

  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final RegExp regExp = RegExp(r'^[a-zA-Z\s]*$');
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }

  return (Column(
    children: [
      Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        width: size.width,
        // decoration: BoxDecoration(
        //     color: AppColors.lightOrange,
        //     borderRadius: BorderRadiusDirectional.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   'Use your passport or GCC National ID to \nquickly and securely auto-fill traveller\n details',
            //   style: TextStyle(
            //       fontWeight: FontWeight.w500,
            //       color: Color.fromRGBO(96, 96, 96, 1),
            //       fontSize: screenWidth(25)),
            //   textAlign: TextAlign.center,
            // ),
            // Container(
            //   width: size.width - 20,
            //   height: 40,
            //   decoration: BoxDecoration(
            //       color: AppColors.orange,
            //       borderRadius: BorderRadius.circular(20)),
            //   child: Padding(
            //     padding: EdgeInsetsDirectional.all(10),
            //     child: Center(
            //       child: Text(
            //         'Scan ID to add traveller',
            //         style: TextStyle(
            //             color: Colors.white, fontSize: screenWidth(25)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            ' Fill in your details ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TextSize.header1,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: decoration.copyWith(),
        child: Column(
          children: [
            const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'First Name',
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
                keyboardType: TextInputType.emailAddress,
                controller: firstNameController,
                inputFormatters: <TextInputFormatter>[
                  TextOnlyInputFormatter(),
                ],
                onChanged: (value) {
                  carCustomerController.SetFirstNameContactDetails(
                      value ?? firstNameController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide:
                        BorderSide(color: AppColors.darkGray, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.person_2_rounded,
                    color: AppColors.darkGray,
                  ),
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
                  'Last Name',
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
                keyboardType: TextInputType.text,
                controller: lastNameController,
                inputFormatters: <TextInputFormatter>[
                  TextOnlyInputFormatter(),
                ],
                onChanged: (value) {
                  carCustomerController.SetLastNameContactDetails(
                      value ?? lastNameController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide:
                        BorderSide(color: AppColors.darkGray, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.person_2_rounded,
                    color: AppColors.darkGray,
                  ),
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
                  'Email',
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                // inputFormatters: <TextInputFormatter>[
                //   EmailInputFormatter(),
                // ],
                onChanged: (value) {
                  // email = value;
                  carCustomerController.SetEmailContactDetails(
                      value ?? emailController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide:
                        BorderSide(color: AppColors.darkGray, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    carCustomerController.errorTextEmail.value,
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
                  'Mobile Number',
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
                controller: mobileNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  // MobileNumber = value;

                  carCustomerController.SetMobileNumberContactDetails(
                      value ?? mobileNumberController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide:
                        BorderSide(color: AppColors.darkGray, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    carCustomerController.errorText.value,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )),
            ]),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.bottomLeft,
        decoration: decoration.copyWith(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: screenHeight(40),
                  ),
                  const Text(
                    'Total to be paid:',
                    style: TextStyle(
                      fontSize: TextSize.header1,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${currencycontroller.convert(currencycontroller.selectedCurrency.value, carDeails.rentalInDay.toDouble()).toString()} ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray),
                  ),
                  Text(
                    currencycontroller.selectedCurrency.value,
                    style: TextStyle(
                        fontSize: TextSize.header2, color: AppColors.grayText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ));
}

Widget step3(BuildContext contex, CarClass1 carDeails) {
  final CarStep3paymentController carStep3paymentController =
      Get.put(CarStep3paymentController());
  final CurrencyController currencycontroller = Get.put(CurrencyController());
  is3 = true;
  return Column(
    children: [
      (Container(
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
                controller: carStep3paymentController.cardHolderController,
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide:
                        BorderSide(color: AppColors.darkGray, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.credit_card_rounded,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    carStep3paymentController.errorTextcardHolder.value,
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
                controller: carStep3paymentController.cardNumberController,
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide:
                        BorderSide(color: AppColors.darkGray, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.date_range,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    carStep3paymentController.errorTextcardNumber.value,
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
                      width: 100,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'^\d{2}/\d{2}$')),
                        ],
                        controller:
                            carStep3paymentController.MMexpiryDateController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                                color: AppColors.darkGray, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: AppColors.darkGray,
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
                      width: 100,
                      child: TextFormField(
                        controller:
                            carStep3paymentController.YYexpiryDateController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'^\d{2}/\d{2}$')),
                        ],
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                                color: AppColors.darkGray, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: AppColors.darkGray,
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
                          FilteringTextInputFormatter.deny(RegExp(r'[.,/]')),
                        ],
                        controller: carStep3paymentController.cvvController,
                        onChanged: (value) {},
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                                color: AppColors.darkGray, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ),
                    ),
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
                    carStep3paymentController.errorTextYYexpiryDate.value,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    carStep3paymentController.errorTextMMexpiryDate.value,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    carStep3paymentController.errorTextcvv.value,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )),
            ]),
          ],
        ),
      )),
      const SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.bottomLeft,
        decoration: decoration.copyWith(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Total to be paid:',
                    style: TextStyle(
                      fontSize: TextSize.header1,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currencycontroller
                        .convert(currencycontroller.selectedCurrency.value,
                            carDeails.rentalInDay.toDouble())
                        .toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray),
                  ),
                  Text(
                    currencycontroller.selectedCurrency.value,
                    style: TextStyle(
                        fontSize: TextSize.header2, color: AppColors.grayText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Future<void> ConfirmBooking(CarClass1 car, int id_hotel_booking, var userid,
    BuildContext context) async {
  // HotelBookingsController HotelbookingsController =
  //     Get.put(HotelBookingsController());
  // CarBookingsController carBookingsController =
  //     Get.put(CarBookingsController());
  final CarCustomerController carCustomerController =
      Get.put(CarCustomerController());
  final CarStep3paymentController carStep3paymentController =
      Get.put(CarStep3paymentController());
  final CarSearchController carSearchController =
      Get.put(CarSearchController());

  DatabaseReference ref = FirebaseDatabase.instance.reference();
  ref.child('CarBooking/$id_hotel_booking:').set({
    'Email': carCustomerController.EmailContactDetails.toString(),
    'FirstName': carCustomerController.FirstNameContactDetails.toString(),
    'LastName': carCustomerController.LastNameContactDetails.toString(),
    'MobileNumber': carCustomerController.MobileNumberContactDetails.toString(),
    'CarId': car.id.toString(),
    'CarRentailCompany': car.companyRentailName,
    'TotalPrice': car.rentalInDay * calculateNumberOfNights(),
    'BookingDate':
        '${DateTime.now().day}. ${DateTime.now().month}, ${DateTime.now().year}',
    'userId': userid.toString(),
    'PickupDate': carSearchController.getFormattedPickUpDate(),
    'DropOffDate': carSearchController.getFormattedDropOffDate()
  });

  ref.child('Car/${car.id}').update({'is_reserved': true});
  carCustomerController.clearData();
  carCustomerController.clearData();
  carStep3paymentController.clearData();
  // carBookingsController.NewbookingRoom.value = true;
  int tabNumber;
  Future.delayed(Duration(seconds: 2), () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          initialIndex: 2,
          //tabNumber: 2
        ),
      ),
    );
    // carBookingsController.NewbookingRoom.value = true;
  });
}

int calculateNumberOfNights() {
  final CarCustomerController carCustomerController =
      Get.put(CarCustomerController());
  final CarStep3paymentController carStep3paymentController =
      Get.put(CarStep3paymentController());
  final CarSearchController carSearchController =
      Get.put(CarSearchController());
  DateTime? startDate = carSearchController.PickUpDate.value;
  DateTime? endDate = carSearchController.DropOffDate.value;

  if (startDate != null && endDate != null) {
    int nights = endDate.difference(startDate).inDays;
    if (nights == 0 && endDate.isAfter(startDate)) {
      nights = 1;
    }
    return nights;
  } else {
    return 1;
  }
}
