// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_escapes, use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use, unnecessary_null_comparison, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/hotel_Step3payment_controller.dart';
import 'package:traveling/controllers/hotel_bookings_controller.dart';
import 'package:traveling/controllers/hotel_controller.dart';
import 'package:traveling/controllers/hotel_guest_controller.dart';
import 'package:traveling/controllers/hotel_search_controller.dart';
import 'package:traveling/controllers/text_only_input_formatter.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import '../../../controllers/hotel_rooms_controller.dart';
import '../../shared/custom_widgets/custom_button.dart';

bool is3 = false;

class BookingSummaryView extends StatefulWidget {
  RoomDetailsClass Room;
  String Hotel;
  BookingSummaryView({super.key, required this.Room, required this.Hotel});
  @override
  State<BookingSummaryView> createState() => _BookingSummaryViewState();
}

class _BookingSummaryViewState extends State<BookingSummaryView> {
  final GuestController Guest_Controller = Get.put(GuestController());
  final HotelStep3paymentController HotelSummary_Controller =
      Get.put(HotelStep3paymentController());
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int activeStepIndex = 0;
  late int id_hotel_booking;
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
        databaseReference.child('hotel_booking');
    idRefhotel_booking.once().then((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          id_hotel_booking = event.snapshot.children.length + 1;
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
          content: step1(context, widget.Hotel, widget.Room),
          state: activeStepIndex > 0 ? StepState.complete : StepState.disabled,
          isActive: activeStepIndex >= 0,
        ),
        Step(
          title: const Text(
            'Guest\nDetails',
            style: TextStyle(fontSize: TextSize.header2),
          ),
          content: step2(context, _emailController, _mobileNumberController,
              _firstNameController, _lastNameController, widget.Room),
          state: activeStepIndex > 1 ? StepState.complete : StepState.disabled,
          isActive: activeStepIndex >= 1,
        ),
        Step(
            title: const Text(
              'Payment',
              style: TextStyle(fontSize: TextSize.header2),
            ),
            content: step3(context, widget.Room),
            state: StepState.disabled,
            isActive: activeStepIndex >= 2),
      ];
    }

    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: SafeArea(
        child: Stack(children: [
          Container(
            color: AppColors.lightPurple,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.purple,
                      ),
                      Text(
                        'Add Room',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.purple),
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.lightPurple,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
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
                      primary: AppColors.purple,
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
                            if (await Guest_Controller.validateGuest()) {
                              // (Guest_Controller.EmailContactDetails != '' &&
                              //     Guest_Controller.MobileNumberContactDetails !=
                              //         '' &&
                              //     Guest_Controller.FirstNameContactDetails !=
                              //         '' &&
                              //     Guest_Controller.LastNameContactDetails != '') {
                              setState(() {
                                activeStepIndex += 1;
                              });
                            }
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
                              widget.Room.Price)) {
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
                                                color: AppColors.purple,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Icon(
                                            Icons.check_circle_outlined,
                                            color: AppColors.purple,
                                            size: 100,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'SUCCESS!',
                                            style: TextStyle(
                                                color: AppColors.purple,
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
                                                'Your flight has been\n\ booked successfully.',
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
                                              ConfirmBooking(
                                                  widget.Room,
                                                  widget.Hotel,
                                                  id_hotel_booking,
                                                  uid,
                                                  context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 15,
                                              ),
                                              child: CustomButton(
                                                backgroundColor:
                                                    AppColors.purple,
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

Widget step1(BuildContext context, String HotelId, RoomDetailsClass room) {
  final HotelRoomsController hotelRoomsController =
      Get.put(HotelRoomsController());
  hotelRoomsController.getRoomRating(room.id);

  final HotelController Hotel_Controller = Get.put(HotelController());
  final CurrencyController Currency_Controller = Get.put(CurrencyController());
  final SearchHotelController hotelscontroller =
      Get.put(SearchHotelController());
  int calculateNumberOfNights() {
    DateTime? startDate = hotelscontroller.ArrivalDate.value;
    DateTime? endDate = hotelscontroller.departureDate.value;
    final CurrencyController controller = Get.put(CurrencyController());

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

  print(_getFormattedDate(hotelscontroller.getFormattedArrivalDate()));
  print(hotelscontroller.getFormattedDepartureDate());
  print(hotelscontroller.getFormattedArrivalDate());
  print(_getFormattedDate(hotelscontroller.getFormattedDepartureDate()));

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
                      image: AssetImage('assets/image/png/hotel1.jpg'),
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
                        hotelscontroller
                            .Hotels[Hotel_Controller.selectedIndex.value].Name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.room,
                            color: AppColors.gold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            room.Overview,
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
                            Icons.location_on_rounded,
                            color: AppColors.gold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            hotelscontroller
                                .Hotels[Hotel_Controller.selectedIndex.value]
                                .location,
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
                            Icons.star,
                            color: AppColors.gold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          (hotelRoomsController.HotelaverageRating.value > 0 &&
                                  hotelRoomsController
                                          .HotelaverageRating.value <=
                                      1)
                              ? Text(
                                  '1 Stars',
                                  style: TextStyle(color: AppColors.grayText),
                                )
                              : (hotelRoomsController.HotelaverageRating.value >
                                          1 &&
                                      hotelRoomsController
                                              .HotelaverageRating.value <=
                                          2)
                                  ? Text(
                                      '2 Stars',
                                      style:
                                          TextStyle(color: AppColors.grayText),
                                    )
                                  : (hotelRoomsController
                                                  .HotelaverageRating.value >
                                              2 &&
                                          hotelRoomsController
                                                  .HotelaverageRating.value <=
                                              3)
                                      ? Text(
                                          '3 Stars',
                                          style: TextStyle(
                                              color: AppColors.grayText),
                                        )
                                      : (hotelRoomsController.HotelaverageRating
                                                      .value >
                                                  3 &&
                                              hotelRoomsController
                                                      .HotelaverageRating
                                                      .value <=
                                                  4)
                                          ? Text(
                                              '4 Stars',
                                              style: TextStyle(
                                                  color: AppColors.grayText),
                                            )
                                          : (hotelRoomsController
                                                          .HotelaverageRating
                                                          .value >
                                                      4 &&
                                                  hotelRoomsController
                                                          .HotelaverageRating
                                                          .value <=
                                                      5)
                                              ? Text(
                                                  '4 Stars',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.grayText),
                                                )
                                              : Text(
                                                  '1 Stars',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.grayText),
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
            padding: const EdgeInsets.only(
              // left: 15,
              // right: 15,
              bottom: 15,
              top: 20,
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
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
                            'Number of nights',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${numberOfNights} night',
                            style: TextStyle(
                              color: AppColors.purple,
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
                            'Check in',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            _getFormattedDate(
                                hotelscontroller.getFormattedArrivalDate()),
                            style: TextStyle(
                              color: AppColors.purple,
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
                            'Check out',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          Text(
                            _getFormattedDate(
                                hotelscontroller.getFormattedDepartureDate()),
                            style: TextStyle(
                              color: AppColors.purple,
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
    TextEditingController emailController,
    TextEditingController mobileNumberController,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
    RoomDetailsClass room) {
  final GuestController Guest_Controller = Get.put(GuestController());
  final CurrencyController currencycontroller = Get.put(CurrencyController());
  final SearchHotelController hotelscontroller =
      Get.put(SearchHotelController());
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
      // Container(
      //   padding: EdgeInsets.all(10),
      //   width: size.width,
      //   decoration: BoxDecoration(
      //       color: AppColors.lightPurple,
      //       borderRadius: BorderRadiusDirectional.circular(25)),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     // crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Use your passport or GCC National ID to \nquickly and securely auto-fill traveller\n details',
      //         style: TextStyle(
      //             fontWeight: FontWeight.w500,
      //             color: Color.fromRGBO(96, 96, 96, 1),
      //             fontSize: screenWidth(25)),
      //         textAlign: TextAlign.center,
      //       ),
      //       Container(
      //         width: size.width - 20,
      //         height: 40,
      //         decoration: BoxDecoration(
      //             color: AppColors.purple,
      //             borderRadius: BorderRadius.circular(20)),
      //         child: Padding(
      //           padding: EdgeInsetsDirectional.all(10),
      //           child: Center(
      //             child: Text(
      //               'Scan ID to add traveller',
      //               style: TextStyle(
      //                   color: Colors.white, fontSize: screenWidth(25)),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // const SizedBox(
      //   height: 20,
      // ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            ' Booking details ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: TextSize.header1,
            ),
          ),
        ],
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
                  Guest_Controller.SetFirstNameContactDetails(
                      value ?? firstNameController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.purple, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.person_2_rounded,
                    color: AppColors.gold,
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
                  Guest_Controller.SetLastNameContactDetails(
                      value ?? lastNameController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.purple, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.person_2_rounded,
                    color: AppColors.gold,
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
                  Guest_Controller.SetEmailContactDetails(
                      value ?? emailController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.purple, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.email_rounded,
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
                    Guest_Controller.errorTextEmail.value,
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
            // Container(
            //     height: 65,
            //     child: IntlPhoneField(
            //       focusNode: focusNode,
            //       controller: mobileNumberController,
            //       decoration: textFielDecoratiom.copyWith(
            //         focusedBorder: const OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(18)),
            //           borderSide:
            //               BorderSide(color: AppColors.purple, width: 1.5),
            //         ),
            //         prefixIcon: Icon(
            //           Icons.phone,
            //           color: AppColors.gold,
            //         ), // Add your prefix icon here
            //         filled: true,
            //         fillColor: Colors.white, // Set your desired fill color
            //       ),
            //       languageCode: "en",
            //       onChanged: (phone) {},
            //       onCountryChanged: (country) {},
            //       showDropdownIcon: true, // Show the dropdown icon
            //       dropdownIcon:
            //           // Adjust the padding as needed
            //           Icon(
            //         Icons.arrow_drop_down, // Replace with your desired icon
            //         color: AppColors.gold,
            //       ),

            //       initialCountryCode: 'US', // Set your initial country code
            //     )),

            SizedBox(
              height: 45,
              child: TextField(
                // keyboardType: TextInputType.phone,
                controller: mobileNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  // MobileNumber = value;

                  Guest_Controller.SetMobileNumberContactDetails(
                      value ?? mobileNumberController.text);
                },
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.purple, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    Guest_Controller.errorText.value,
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
                    '${room.Price.toString()} ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.purple),
                  ),
                  Text(
                    currencycontroller.selectedCurrency.toString(),
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

Widget step3(BuildContext contex, RoomDetailsClass room) {
  final HotelStep3paymentController HotelSummary_Controller =
      Get.put(HotelStep3paymentController());
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
                controller: HotelSummary_Controller.cardHolderController,
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.purple, width: 1.5),
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
                    HotelSummary_Controller.errorTextcardHolder.value,
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
                controller: HotelSummary_Controller.cardNumberController,
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.purple, width: 1.5),
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
                    HotelSummary_Controller.errorTextcardNumber.value,
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
                            HotelSummary_Controller.MMexpiryDateController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
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
                      width: 100,
                      child: TextFormField(
                        controller:
                            HotelSummary_Controller.YYexpiryDateController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'^\d{2}/\d{2}$')),
                        ],
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
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
                        controller: HotelSummary_Controller.cvvController,
                        onChanged: (value) {},
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
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
                    HotelSummary_Controller.errorTextYYexpiryDate.value,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    HotelSummary_Controller.errorTextMMexpiryDate.value,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  )),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Obx(() => Text(
                    HotelSummary_Controller.errorTextcvv.value,
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
                    '${room.Price.toString()} ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.purple),
                  ),
                  Text(
                    currencycontroller.selectedCurrency.toString(),
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

Future<void> ConfirmBooking(RoomDetailsClass room, String HotelId,
    int id_hotel_booking, var userid, BuildContext context) async {
  HotelBookingsController HotelbookingsController =
      Get.put(HotelBookingsController());
  final GuestController Guest_Controller = Get.put(GuestController());
  final HotelStep3paymentController HotelSummary_Controller =
      Get.put(HotelStep3paymentController());
  final SearchHotelController Search_Hotel_Controller =
      Get.put(SearchHotelController());

  DatabaseReference ref = FirebaseDatabase.instance.reference();
  ref.child('hotel_booking/$id_hotel_booking:').set({
    'Email': Guest_Controller.EmailContactDetails.toString(),
    'FirstName': Guest_Controller.FirstNameContactDetails.toString(),
    'LastName': Guest_Controller.LastNameContactDetails.toString(),
    'MobileNumber': Guest_Controller.MobileNumberContactDetails.toString(),
    'RoomId': room.id.toString(),
    'TotalPrice': room.Price,
    'BookingDate':
        '${DateTime.now().day}. ${DateTime.now().month}, ${DateTime.now().year}',
    'userId': userid.toString(),
    'Adults': Search_Hotel_Controller.Adultcounter,
    'Children': Search_Hotel_Controller.Childcounter,
    'DepartureDate': Search_Hotel_Controller.getFormattedDepartureDate(),
    'ArrivalDate': Search_Hotel_Controller.getFormattedArrivalDate()
  });

  ref.child('Room/${room.id}').update({'is_reserved': true});
  Guest_Controller.clearData();
  Search_Hotel_Controller.clearData();
  HotelSummary_Controller.clearData();
  HotelbookingsController.NewbookingRoom.value = true;
  Future.delayed(Duration(seconds: 2), () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          initialIndex: 2,
        ),
      ),
    );
    HotelbookingsController.NewbookingRoom.value = true;
  });
}
