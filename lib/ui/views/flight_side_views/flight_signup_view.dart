import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/flight_side_views/flight_home_view.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../traveller_side_views/home_screen.dart';
import 'flight_home_screen.dart';

class FlightSignUpView extends StatefulWidget {
  const FlightSignUpView({super.key});

  @override
  State<FlightSignUpView> createState() => _FlightSignUpViewState();
}

class _FlightSignUpViewState extends State<FlightSignUpView> {
  late String email;
  late String password;
  late String confermPassword;
  late String errorText = '';
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    final DatabaseReference ref = FirebaseDatabase.instance.ref("user");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 110,
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.cloud,
                              color: Color.fromARGB(76, 249, 249, 249),
                              size: 60,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Travelling",
                                  style: TextStyle(
                                      color: AppColors.backgroundgrayColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.cloud,
                                  color: Color.fromARGB(76, 249, 249, 249),
                                  size: 50,
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                              ],
                            ),
                            Row(
                              children: [],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Wellcome back",
                                  style: TextStyle(
                                    color: AppColors.backgroundgrayColor,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 300,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/png/background1.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 350),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign up ',
                          style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        const Row(
                          children: [
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
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: textFielDecoratiom.copyWith(
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Password',
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
                            keyboardType: TextInputType.visiblePassword,
                            decoration: textFielDecoratiom.copyWith(
                              prefixIcon: Icon(Icons.lock_rounded),
                            ),
                            controller: _passwordController,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Conferm Password',
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
                            controller: _confirmPasswordController,
                            decoration: textFielDecoratiom.copyWith(
                              prefixIcon: Icon(Icons.lock_rounded),
                            ),
                            onChanged: (value) {
                              confermPassword = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          errorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(
                                () => const FlightHome(),
                              );
                            },
                            child: CustomButton(
                              backgroundColor: AppColors.darkBlue,
                              text: 'Sign up',
                              textColor: AppColors.backgroundgrayColor,
                              widthPercent: size.width,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        // const Center(
                        //   child: CustomTextGray(
                        //     mainText: 'or sign in with ',
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     CustomImage(imagename: 'facebook_icon'),
                        //     CustomImage(imagename: 'google_icon'),
                        //     CustomImage(imagename: 'twitter_icon'),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: screenHeight(20),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You already have account?  ',
                              style: TextStyle(
                                color: AppColors.grayText,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAll(const FlightSignInView());
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
