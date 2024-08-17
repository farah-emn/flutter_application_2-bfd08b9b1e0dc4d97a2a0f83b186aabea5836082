// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/text_size.dart';
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
  late String errorMobilenumber = '';

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
    _controller.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  String _selectedCountryCode = '+963'; // Default
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
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
                      height: 90,
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
              SizedBox(
                height: 80,
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
                      height: 310,
                    ),
                    Text(
                      'Sign up ',
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
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
                          'Hotel name',
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
                        keyboardType: TextInputType.text,
                        controller: _HotelNameController,
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.location_city_rounded,
                            color: AppColors.purple,
                          ),
                        ),
                        onChanged: (value) {
                          CompanyName = value;
                        },
                      ),
                    ),
                    (errorTextCompanyName != '')
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
                          'Mobile Number',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: _selectedCountryCode,
                          items: <String>[
                            '+1',
                            '+91',
                            '+44',
                            '+81',
                            '+61',
                            '+966',
                            '+965',
                            '+963'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountryCode = newValue!;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: textFielDecoratiom.copyWith(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.purple, width: 1.5),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.transparent,
                              ),
                            ),
                            controller: _controller,
                            keyboardType: TextInputType.phone,
                          ),
                        )),
                      ],
                    ),
                    (errorMobilenumber != '')
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 6, top: 5, bottom: 15),
                            child: Text(
                              errorMobilenumber,
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
                        controller: _passwordController,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    (errorTextPassword != '')
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
                      height: 40,
                      child: TextFormField(
                        controller: _confirmPasswordController,
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
                          confermPassword = value;
                        },
                      ),
                    ),
                    (errorTextConfirmPassword != null)
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 6, top: 5, bottom: 15),
                            child: Text(
                              errorTextConfirmPassword,
                              style: TextStyle(fontSize: 11, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 15,
                          ),
                    Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 5,
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
                              errorMobilenumber = "";
                              if (_emailController.value.text.isEmpty &&
                                  _HotelNameController.value.text.isEmpty &&
                                  _passwordController.value.text.isEmpty &&
                                  _controller.text.isEmpty) {
                                errorText = "Please enter all fields";
                              } else {
                                if (_emailController.value.text.isEmpty ||
                                    !_emailController.value.text
                                        .contains('@')) {
                                  errorTextEmail = "Please enter a valid email";
                                }
                                if (_controller.value.text.length < 9) {
                                  errorMobilenumber =
                                      "Please enter a valid Mobile number";
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

                                if (_HotelNameController.value.text.isEmpty) {
                                  errorTextCompanyName =
                                      "Please enter a valid Hotel name";
                                }
                              }
                            });
                            if (errorTextAirlineCode.isEmpty &&
                                errorTextEmail.isEmpty &&
                                errorTextPassword.isEmpty &&
                                errorTextConfirmPassword.isEmpty) {
                              Get.offAll(HotelSignUpImageView(
                                  email: email,
                                  password: password,
                                  CompanyName: _HotelNameController.text));
                            }
                          } catch (e) {}
                        },
                        child: CustomButton(
                          backgroundColor: AppColors.purple,
                          text: 'Sign up',
                          textColor: AppColors.backgroundgrayColor,
                          widthPercent: size.width,
                        )),
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
                            Get.off(const HotelSignInView());
                          },
                          child: const Text(
                            'Sign in',
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
