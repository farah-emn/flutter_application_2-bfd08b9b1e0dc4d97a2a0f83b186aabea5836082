// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/car_side_views/car_signin_view.dart';
import 'package:traveling/ui/views/car_side_views/car_signup_image_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class CarSignUpView extends StatefulWidget {
  const CarSignUpView({super.key});

  @override
  State<CarSignUpView> createState() => _CarSignUpViewState();
}

class _CarSignUpViewState extends State<CarSignUpView> {
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
  final _CarNameController = TextEditingController();
  final _mobileNumber = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  String _selectedCountryCode = '+963'; // Default
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
    _CarNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  late String errorMobilenumber = '';

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    final DatabaseReference ref = FirebaseDatabase.instance.ref("Hotel");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGray,
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
                                  "Wellcome ",
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
                padding: const EdgeInsets.only(top: 330),
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
                        const SizedBox(
                          height: 30,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.darkGray, width: 1.5),
                              ),
                              prefixIcon: const Icon(
                                Icons.email_rounded,
                                color: AppColors.darkGray,
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
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.red),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),

                        const Row(
                          children: [
                            Text(
                              'Company Name',
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
                            controller: _CarNameController,
                            decoration: textFielDecoratiom.copyWith(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.darkGray, width: 1.5),
                              ),
                              prefixIcon: const Icon(
                                Icons.location_city_rounded,
                                color: AppColors.darkGray,
                              ),
                            ),
                            onChanged: (value) {
                              CompanyName = value;
                            },
                          ),
                        ),
                        (errorTextCompanyName.isNotEmpty)
                            ? Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: 6, top: 5, bottom: 15),
                                child: Text(
                                  errorTextEmail,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.red),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.darkGray, width: 1.5),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: AppColors.darkGray,
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
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.red),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),

                        const Row(
                          children: [
                            Text(
                              'Confirm Password',
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.darkGray, width: 1.5),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: AppColors.darkGray,
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
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.red),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),

                        Text(
                          errorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
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
                                if (_CarNameController.value.text.isEmpty) {
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
                                  Get.offAll(CarSignUpImageView(
                                    email: email,
                                    password: password,
                                    CarRentalCompany: _CarNameController.text,
                                    mobileNumber: _mobileNumber.text,
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
                              backgroundColor: AppColors.darkGray,
                              text: 'Sign up',
                              textColor: AppColors.backgroundgrayColor,
                              widthPercent: size.width,
                            )),
                        const SizedBox(
                          height: 10,
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
                              'You already have account? ',
                              style: TextStyle(
                                color: AppColors.grayText,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.off(const CarSignInView());
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: AppColors.darkGray,
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
