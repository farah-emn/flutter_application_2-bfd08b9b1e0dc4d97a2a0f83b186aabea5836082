import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_summery_view.dart';
import 'package:traveling/ui/views/traveller_side_views/flights_view.dart';

import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfiled.dart';
import '../../shared/utils.dart';
import 'home_screen.dart';
import 'traveller_details_view2.dart';
import 'traveller_details_view3.dart';

class FlightDetailsView extends StatefulWidget {
  FlightDetailsView({super.key});

  @override
  State<FlightDetailsView> createState() => _FlightDetailsViewState();
}

class _FlightDetailsViewState extends State<FlightDetailsView> {
  int _activeStepIndex = 0;

  int _nextStep = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Step> StepsList() {
      return <Step>[
        Step(
          title: Text('Flight\nSummery'),
          content: FlightSummeryView(),
          state: _activeStepIndex > 0 ? StepState.complete : StepState.disabled,
          isActive: _activeStepIndex >= 0,
        ),
        Step(
          title: Text('Travellar\nDetails'),
          content: TravellerDetailsView2(),
          state: _activeStepIndex > 1 ? StepState.complete : StepState.disabled,
          isActive: _activeStepIndex >= 1,
        ),
        Step(
            title: Text('Payments'),
            content: step3(context),
            state: StepState.disabled,
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
                child: const Column(
                  children: [
                    Text(
                      'CAI',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '26 DEC',
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
                child: const Column(
                  children: [
                    Text(
                      'RUH',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '26 DEC',
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
                onStepContinue: () {
                  if (_nextStep <= 4) {
                    _activeStepIndex += 1;
                    _nextStep += 1;
                  }
                  if (_nextStep == 4) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set your desired border radius
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
                                    child: Image.asset(
                                      'assets/image/png/cancel_icon.png',
                                    ),
                                  ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Get.to(Home());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 15,
                                      ),
                                      child: CustomButton(
                          backgroundColor: AppColors.darkBlue,

                                          text: 'Confirm',
                                          textColor:
                                              AppColors.backgroundgrayColor,
                                          widthPercent: size.width,
                                          heightPercent: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  // setState() {}
                },
                onStepCancel: () {
                  if (_activeStepIndex == 0) {
                    return;
                  }
                  _activeStepIndex -= 1;
                  _nextStep -= 1;
                  // setState(){}
                },
              ),
            ),
          ],
        ));
  }
}

Widget step3(BuildContext contex) {
  return (Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        const CustomTextField(
          prefIcon: Icons.credit_card_rounded,
          colorIcon: AppColors.IconPurpleColor,
          hintText: 'First name',
        ),
        SizedBox(
          height: 20,
        ),
        const CustomTextField(
          prefIcon: Icons.date_range,
          colorIcon: Color.fromARGB(255, 198, 237, 195),
          hintText: 'Card expiration date',
        ),
        SizedBox(
          height: 20,
        ),
        const CustomTextField(
          prefIcon: Icons.person,
          colorIcon: AppColors.IconBlueColor,
          hintText: 'Name of card holder',
          suffIcon: Icons.keyboard_arrow_down,
        ),
        Container(
            alignment: Alignment.bottomLeft,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: screenWidth(30), top: screenHeight(86)),
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
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '2231',
                        style: TextStyle(
                          fontSize: screenWidth(18),
                          color: AppColors.mainColorBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'SAR',
                        style: TextStyle(
                          fontSize: screenWidth(26),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(80),
                  )
                ],
              ),
            )),
      ],
    ),
  ));
}
