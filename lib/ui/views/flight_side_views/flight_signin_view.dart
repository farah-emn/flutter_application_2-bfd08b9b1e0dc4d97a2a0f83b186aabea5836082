// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/flight_side_views/flight_home_screen.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signup_view.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/home_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../../shared/text_size.dart';

class FlightSignInView extends StatefulWidget {
  const FlightSignInView({super.key});

  @override
  State<FlightSignInView> createState() => _FlightSignInViewState();
}

class _FlightSignInViewState extends State<FlightSignInView> {
  late String email;
  late String password;
  late String confermPassword;
  late String AirelineCode;
  late String CompanyName;
  late String errorText = '';
  late String errorTextEmail = '';
  late String errorTextAirlineCode = '';
  late String errorTextPassword = '';
  late String errorTextCompanyName = '';
  late String errorTextConfirmPassword = '';
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _AirelineCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _CompanyNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _AirelineCodeController.dispose();
    _CompanyNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref("Airline_company");
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
                                  "Wellcome",
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
              SizedBox(
                height: 100,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.black

                    // image: DecorationImage(
                    //     image: AssetImage('assets/image/png/background1.png'),
                    //     fit: BoxFit.fill),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 350,
                    ),
                    const Text(
                      'Sign in ',
                      style: TextStyle(
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFielDecoratiom.copyWith(
                          prefixIcon: Icon(Icons.email),
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
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: textFielDecoratiom.copyWith(
                          prefixIcon: Icon(Icons.lock),
                        ),
                        onChanged: (value) {
                          password = value;
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
                        onTap: () async {
                          try {
                            if (_emailController.value.text.isEmpty ||
                                !_emailController.value.text.isEmail) {
                              setState(() {
                                errorTextEmail = "Please enter valid email";
                              });
                            } else {
                              setState(() {
                                errorTextEmail = '';
                              });
                            }
                            if (_passwordController.value.text.isEmpty) {
                              setState(() {
                                errorTextPassword =
                                    "Please enter a valid password";
                              });
                            } else if (_passwordController.value.text.length <
                                    7 &&
                                _passwordController.value.text.isNotEmpty) {
                              setState(() {
                                errorTextPassword =
                                    "Password can't be less than 6 charecters";
                              });
                            } else {
                              setState(() {
                                errorTextPassword = '';
                              });
                            }
                            if (_passwordController.value.text !=
                                _confirmPasswordController.value.text) {
                              setState(() {
                                errorTextConfirmPassword =
                                    "Password and verification do not match";
                              });
                            } else {
                              errorTextConfirmPassword = '';
                            }
                            if (_CompanyNameController.value.text.isEmpty) {
                              setState(() {
                                errorTextCompanyName =
                                    "Please enter a valid Company name";
                              });
                            } else {
                              errorTextCompanyName = '';
                            }

                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Get.offAll(FlightHome());
                              }
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                if (e.code == 'user-not-found') {
                                  setState(() {
                                    errorText = 'No user found for that email.';
                                  });
                                } else if (e.code == 'wrong-password') {
                                  setState(() {
                                    errorText =
                                        'Wrong password provided for that user.';
                                  });
                                } else {
                                  setState(() {
                                    errorText =
                                        'Failed with error code: ${e.code}';
                                    errorText = e.message!;
                                  });
                                }
                              }
                            }
                          } catch (e) {}
                        },
                        child: CustomButton(
                          text: 'Sign up',
                          textColor: AppColors.backgroundgrayColor,
                          widthPercent: size.width,
                          backgroundColor: AppColors.mainColorBlue,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextGray(
                            mainText: 'You Do not have account? '),
                        InkWell(
                          onTap: () {
                            Get.offAll(const FlightSignUpView());
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppColors.mainColorBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
