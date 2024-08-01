// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_signup_image_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import 'hotel_signin_view.dart';

class HoteltSignUpView extends StatefulWidget {
  const HoteltSignUpView({super.key});

  @override
  State<HoteltSignUpView> createState() => _HoteltSignUpViewState();
}

class _HoteltSignUpViewState extends State<HoteltSignUpView> {
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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _HotelNameController = TextEditingController();
  @override
  void initState() {
    final databaseReference = FirebaseDatabase.instance.reference();
    DatabaseReference idReHotel = databaseReference.child('Hotel');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _HotelNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    final DatabaseReference ref = FirebaseDatabase.instance.ref("Hotel");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: Stack(
        children: [
          const Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "T",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mainColorBlue),
                  ),
                  Text(
                    "ravell",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 219, 186, 223)),
                  ),
                  Text(
                    "ing",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
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
                      height: 280,
                    ),
                    Text(
                      'Sign up ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width / 20),
                    ),
                    const SizedBox(
                      height: 35,
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
                      height: 30,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: textFielDecoratiom.copyWith(),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    (errorTextEmail.isNotEmpty)
                        ? Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 6, top: 10),
                            child: Text(
                              errorTextEmail,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 20,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hotel name',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _HotelNameController,
                        decoration: textFielDecoratiom.copyWith(),
                        onChanged: (value) {
                          CompanyName = value;
                        },
                      ),
                    ),
                    (errorTextCompanyName.isNotEmpty)
                        ? Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 6, top: 10),
                            child: Text(
                              errorTextEmail,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 20,
                          ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
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
                      height: 30,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: textFielDecoratiom.copyWith(),
                        controller: _passwordController,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),

                    (errorTextPassword != null)
                        ? Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 6, top: 10),
                            child: Text(
                              errorTextPassword,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 15,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
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
                      height: 30,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: textFielDecoratiom.copyWith(),
                        onChanged: (value) {
                          confermPassword = value;
                        },
                      ),
                    ),
                    (errorTextConfirmPassword != null)
                        ? Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 6, top: 10),
                            child: Text(
                              errorTextConfirmPassword,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 20,
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
                          // Get.offAll(HotelSignUpImageView());

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
                            if (_HotelNameController.value.text.isEmpty) {
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
                              try {
                                final newAirelineCompany =
                                    await auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                User? AirelineCompany = auth.currentUser;

                                if (AirelineCompany != null) {
                                  Get.offAll(HotelSignUpImageView());
                                  ref
                                      .child(AirelineCompany.uid.toString())
                                      .set({
                                    'email': email,
                                    'password': password,
                                    'mobile_number': '',
                                    'HotelName': _HotelNameController.text,
                                    "location": ''
                                  });
                                }
                              } catch (e) {
                                if (e is FirebaseAuthException) {
                                  switch (e.code) {
                                    case 'weak-password':
                                      setState(() {
                                        errorText = 'Password is too weak.';
                                      });
                                      break;
                                    case 'email-already-in-use':
                                      setState(() {
                                        errorText =
                                            'Email is already registered.';
                                      });

                                      break;
                                    // Add more cases as needed
                                    default:
                                    // Use the default error message
                                  }
                                }
                              }
                            }
                          } catch (e) {}
                        },
                        child: CustomButton(
                          backgroundColor: AppColors.darkBlue,
                          text: 'Sign up',
                          textColor: AppColors.backgroundgrayColor,
                          heightPercent: 20,
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
                        const CustomTextGray(
                            mainText: 'You already have account? '),
                        InkWell(
                          onTap: () {
                            Get.offAll(const HotelSignInView());
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
