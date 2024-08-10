import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/white_container.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';

import '../../shared/custom_widgets/custom_button.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';

import '../../shared/custom_widgets/custom_textfiled.dart';

import 'home_view.dart';

bool is3 = false;

class BookingCarSummaryView extends StatefulWidget {
  BookingCarSummaryView({super.key});

  @override
  State<BookingCarSummaryView> createState() => _BookingCarSummaryViewState();
}

class _BookingCarSummaryViewState extends State<BookingCarSummaryView> {
  int activeStepIndex = 0;
  int _nextStep = 1;

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
          content: step1(context),
          state: activeStepIndex > 0 ? StepState.complete : StepState.disabled,
          isActive: activeStepIndex >= 0,
        ),
        Step(
          title: const Text(
            'Guest\nDetails',
            style: TextStyle(fontSize: TextSize.header2),
          ),
          content: step2(context),
          state: activeStepIndex > 1 ? StepState.complete : StepState.disabled,
          isActive: activeStepIndex >= 1,
        ),
        Step(
            title: const Text(
              'Payment',
              style: TextStyle(fontSize: TextSize.header2),
            ),
            content: step3(context),
            state: StepState.disabled,
            isActive: activeStepIndex >= 2),
      ];
    }

    return Scaffold(
      backgroundColor: AppColors.lightOrange,
      body: SafeArea(
        child: Stack(children: [
          Container(
            color: AppColors.lightOrange,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.orange,
                      ),
                      Text(
                        'Add Room',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.orange),
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.lightOrange,
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
                      primary: AppColors.orange,
                      background: AppColors.backgroundgrayColor,
                    )),
                    child: Stepper(
                      elevation: 0,
                      steps: StepsList(),
                      type: StepperType.horizontal,
                      currentStep: activeStepIndex,
                      onStepContinue: () {
                        final isLastStep =
                            activeStepIndex == StepsList().length - 1;
                        if (isLastStep) {
                          print(isLastStep);
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
                                              color: AppColors.orange,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Icon(
                                          Icons.check_circle_outlined,
                                          color: AppColors.orange,
                                          size: 100,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'SUCCESS!',
                                          style: TextStyle(
                                              color: AppColors.orange,
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
                                            Get.to(const Home());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 15,
                                            ),
                                            child: CustomButton(
                                                backgroundColor:
                                                    AppColors.orange,
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
                        } else {
                          setState(() {
                            activeStepIndex += 1;
                          });
                        }

                        // if (_nextStep <= 4) {
                        //   _activeStepIndex += 1;
                        //   _nextStep += 1;
                        // }
                        // if (_nextStep == 4) {
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return Dialog(
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(
                        //               20.0), // Set your desired border radius
                        //         ),
                        //         backgroundColor: Colors.white,
                        //         child: Container(
                        //           width: screenWidth(1),
                        //           height: screenHeight(2.4),
                        //           child: Column(
                        //             children: [
                        //               Padding(
                        //                 padding: EdgeInsetsDirectional.only(
                        //                     start: screenWidth(1.5),
                        //                     top: screenHeight(70)),
                        //                 child: Image.asset(
                        //                   'assets/image/png/cancel_icon.png',
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: screenHeight(60),
                        //               ),
                        //               Image.asset(
                        //                   'assets/image/png/success_icon.png',
                        //                   alignment: Alignment.bottomLeft,
                        //                   width: screenWidth(4)),
                        //               SizedBox(
                        //                 height: screenHeight(80),
                        //               ),
                        //               Text(
                        //                 'SUCCESS!',
                        //                 style: TextStyle(
                        //                     color: AppColors.mainColorBlue,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: screenWidth(16)),
                        //               ),
                        //               const SizedBox(
                        //                 height: 20,
                        //               ),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     'Your flight has been\n\ booked successfully.',
                        //                     style: TextStyle(
                        //                         fontSize: screenWidth(24),
                        //                         color: const Color.fromARGB(
                        //                             255, 112, 110, 110)),
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(
                        //                 height: 50,
                        //               ),
                        //               InkWell(
                        //                 onTap: () {
                        //                   Get.to(const Home());
                        //                 },
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                     left: 15,
                        //                     right: 15,
                        //                     bottom: 15,
                        //                   ),
                        //                   child: CustomButton(
                        //                       backgroundColor:
                        //                           AppColors.orange,
                        //                       text: 'Confirm',
                        //                       textColor: AppColors
                        //                           .backgroundgrayColor,
                        //                       widthPercent: 1.35,
                        //                       heightPercent: 20),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     });
                        // }
                        // setState() {}
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

Widget step1(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 160,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car - Model',
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
                            color: AppColors.gold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '280',
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
                            color: AppColors.gold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Automatic',
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
                            color: AppColors.gold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '4 Seats',
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
                  child: const Column(
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
                            '1 day',
                            style: TextStyle(
                              color: AppColors.orange,
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
                            '07 Jan, 2024',
                            style: TextStyle(
                              color: AppColors.orange,
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
                            '08 Jan, 2024',
                            style: TextStyle(
                              color: AppColors.orange,
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

Widget step2(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return (Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        width: size.width,
        decoration: BoxDecoration(
            color: AppColors.lightOrange,
            borderRadius: BorderRadiusDirectional.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Use your passport or GCC National ID to \nquickly and securely auto-fill traveller\n details',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(96, 96, 96, 1),
                  fontSize: screenWidth(25)),
              textAlign: TextAlign.center,
            ),
            Container(
              width: size.width - 20,
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Center(
                  child: Text(
                    'Scan ID to add traveller',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth(25)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            ' Traveller details ',
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.email_rounded,
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ),
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
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '2231',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.orange),
                  ),
                  Text(
                    'SAR',
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

Widget step3(BuildContext contex) {
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.credit_card_rounded,
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
                  'Card Expiration Date',
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.date_range,
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
                onChanged: (value) {},
                decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(color: AppColors.orange, width: 1.5),
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
      )),
      const SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.bottomLeft,
        decoration: decoration.copyWith(),
        child: const Padding(
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
                    '2231',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.orange),
                  ),
                  Text(
                    'SAR',
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
