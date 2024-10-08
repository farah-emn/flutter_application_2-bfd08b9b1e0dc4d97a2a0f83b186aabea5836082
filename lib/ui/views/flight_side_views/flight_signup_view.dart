// ignore_for_file: unnecessary_new, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/views/flight_side_views/flight_signin_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signin_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../../shared/text_size.dart';
import 'flight_home_screen.dart';
import 'flight_image_signup_view.dart';

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
  var isLoading = false.obs;
  // int IdAirline = 0;
  final auth = FirebaseAuth.instance;

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
                        SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              'CompanyName',
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
                            decoration: textFielDecoratiom.copyWith(
                              prefixIcon: Icon(Icons.lock_rounded),
                            ),
                            controller: _CompanyNameController,
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
                                } else if (_passwordController
                                            .value.text.length <
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
                                        "Please enter a valid Hotel name";
                                  });
                                } else {
                                  errorTextCompanyName = '';
                                }
                                if (errorTextAirlineCode.isEmpty &&
                                    errorTextEmail.isEmpty &&
                                    errorTextPassword.isEmpty &&
                                    errorTextConfirmPassword.isEmpty) {
                                  Get.offAll(FlightImageSignUpView(
                                    email: email,
                                    password: password,
                                    comapnyname: _CompanyNameController.text,
                                  ));
                                }
                                //   try {
                                //     final newAirelineCompany =
                                //         await auth.createUserWithEmailAndPassword(
                                //             email: email, password: password);
                                //     User? AirelineCompany = auth.currentUser;

                                //     if (AirelineCompany != null) {
                                //       Get.offAll(HotelSignUpImageView());
                                //       ref
                                //           .child(AirelineCompany.uid.toString())
                                //           .set({
                                //         'email': email,
                                //         'password': password,
                                //         'mobile_number': '',
                                //         'HotelName': _CarNameController.text,
                                //         "location": ''
                                //       });
                                //     }
                                //   } catch (e) {
                                //     if (e is FirebaseAuthException) {
                                //       switch (e.code) {
                                //         case 'weak-password':
                                //           setState(() {
                                //             errorText = 'Password is too weak.';
                                //           });
                                //           break;
                                //         case 'email-already-in-use':
                                //           setState(() {
                                //             errorText =
                                //                 'Email is already registered.';
                                //           });

                                //           break;
                                //         // Add more cases as needed
                                //         default:
                                //         // Use the default error message
                                //       }
                                //     }
                                //   }
                                // }
                              } catch (e) {}
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
