// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_home_screen.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_signup_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class HotelSignInView extends StatefulWidget {
  const HotelSignInView({super.key});

  @override
  State<HotelSignInView> createState() => _HotelSignInViewState();
}

class _HotelSignInViewState extends State<HotelSignInView> {
  late String email;
  late String password;
  late String confermPassword;
  late String HotelName;
  late String errorText = '';
  late String errorTextEmail = '';
  late String errorTextPassword = '';
  late String errorTextCompanyName = '';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _HotelNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _HotelNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    final DatabaseReference ref = FirebaseDatabase.instance.ref("Hotel");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightPurple,
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
                  top: 280,
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
                      height: 330,
                    ),
                    Text(
                      'Sign in ',
                      style: TextStyle(
                          fontSize: TextSize.header1,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 40,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: AppColors.purple,
                          ),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                          'Password',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                         decoration: textFielDecoratiom.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.purple,
                          ),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    (errorTextPassword != null)
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 6, top: 5, bottom: 15),
                            child: Text(
                              errorTextPassword,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 15,
                          ),
                    const SizedBox(
                      height: 10,
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
                          if (_emailController.value.text.isEmpty &&
                              _passwordController.value.text.isEmpty) {
                            setState(() {
                              errorText = "Please enter all fields";
                            });
                          } else if (_emailController.value.text.isEmpty ||
                              !_emailController.value.text.isEmail) {
                            setState(() {
                              errorTextEmail = "Please enter valid email";
                            });
                          } else {
                            setState(() {
                              errorTextEmail = '';
                            });
                          }
                          if (_passwordController.value.text.isEmpty &&
                              _emailController.value.text.isNotEmpty) {
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

                          if (_HotelNameController.value.text.isEmpty) {
                            setState(() {
                              errorTextCompanyName =
                                  "Please enter a valid Company name";
                            });
                          } else {
                            errorTextCompanyName = '';
                          }

                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            Get.offAll(HoteltHome());
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
                        backgroundColor: AppColors.purple,
                        text: 'Sign in',
                        textColor: AppColors.backgroundgrayColor,
                        widthPercent: size.width,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You already have account? ',
                          style: TextStyle(
                            color: AppColors.grayText,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(const HoteltSignUpView());
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppColors.purple,
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
