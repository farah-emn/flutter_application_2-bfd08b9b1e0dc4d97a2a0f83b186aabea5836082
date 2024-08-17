// ignore_for_file: unnecessary_new, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/views/flight_side_views/flight_image_signup_view.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../../shared/text_size.dart';
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
  late String AirelineCode;
  late String CompanyName;
  late String errorText = '';
  late String errorTextEmail = '';
  late String errorTextAirlineCode = '';
  late String errorTextPassword = '';
  late String errorTextCompanyName = '';
  late String errorTextConfirmPassword = '';
  final _emailController = TextEditingController();
  // int IdAirline = 0;

  final _AirelineCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _CompanyNameController = TextEditingController();
  @override
  void initState() {
    final databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference idRefAirline = databaseReference.child('Airline_company');
    super.initState();
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 350,
                    ),
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
                    SizedBox(
                      height: 5,
                    ),
                    (errorTextEmail.isNotEmpty)
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 6, top: 5, bottom: 15),
                            child: Text(
                              errorTextEmail,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 20,
                          ),
                    const Row(
                      children: [
                        Text(
                          'Company name',
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
                        keyboardType: TextInputType.text,
                        controller: _CompanyNameController,
                        decoration: textFielDecoratiom.copyWith(
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                        onChanged: (value) {
                          CompanyName = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    (errorTextCompanyName.isNotEmpty)
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 6, top: 5, bottom: 15),
                            child: Text(
                              errorTextCompanyName,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
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
                    SizedBox(
                      height: 5,
                    ),
                    (errorTextPassword.isNotEmpty)
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 6, top: 5, bottom: 15),
                            child: Text(
                              errorTextPassword,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
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
                        onTap: () async {
                          try {
                            setState(() {
                              errorText = "";
                              errorTextEmail = "";
                              errorTextPassword = "";
                              errorTextConfirmPassword = "";
                              errorTextCompanyName = "";
                              // errorMobilenumber = "";
                              if (_emailController.value.text.isEmpty &&
                                      _CompanyNameController
                                          .value.text.isEmpty &&
                                      _passwordController.value.text.isEmpty
                                  // _controller.text.isEmpty
                                  ) {
                                errorText = "Please enter all fields";
                              } else {
                                if (_emailController.value.text.isEmpty ||
                                    !_emailController.value.text
                                        .contains('@')) {
                                  errorTextEmail = "Please enter a valid email";
                                }

                                if (_passwordController.value.text.isEmpty) {
                                  errorTextPassword =
                                      "Please enter a valid password";
                                } else if (_passwordController
                                        .value.text.length <
                                    7) {
                                  errorTextPassword =
                                      "Password can't be less than 6 characters";
                                }

                                if (_passwordController.value.text !=
                                    _confirmPasswordController.value.text) {
                                  errorTextConfirmPassword =
                                      "Password and verification do not match";
                                }
                              }
                            });
                            if (errorTextAirlineCode.isEmpty &&
                                errorTextEmail.isEmpty &&
                                errorTextPassword.isEmpty &&
                                errorTextConfirmPassword.isEmpty) {
                              Get.offAll(FlightImageSignUpView(
                                  email: email,
                                  password: password,
                                  comapnyname: _CompanyNameController.text));
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
                            mainText: 'You already have account? '),
                        InkWell(
                          onTap: () {
                            Get.offAll(const FlightSignInView());
                          },
                          child: const Text(
                            'Sign in',
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
