import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_image.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/home_screen.dart';
import 'package:traveling/ui/views/traveller_side_views/home_view.dart';
import 'package:traveling/ui/views/traveller_side_views/signup_view.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class HotelSignInView extends StatefulWidget {
  const HotelSignInView({super.key});

  @override
  State<HotelSignInView> createState() => _HotelSignInViewState();
}

class _HotelSignInViewState extends State<HotelSignInView> {
  late String email;
  late String password;
  late String errorText = '';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ;
    final _auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
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
                        color: Color(0xFF9A9CC2)),
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
                      'Sign in ',
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
                      height: 30,
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
                              _passwordController.value.text.isEmpty) {
                            setState(() {
                              errorText = "Please enter all fields";
                            });
                          } else if (!_emailController.value.text.isEmail) {
                            setState(() {
                              errorText = "Please enter valid email";
                            });
                          } else if (password.length < 7) {
                            setState(() {
                              errorText =
                                  "Password can't be less than 6 charecters";
                            });
                          } else {
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Get.offAll(Home());
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
                              print(e);
                            }
                          }
                          ;
                        } catch (e) {}
                      },
                      child: CustomButton(
                        backgroundColor: AppColors.darkBlue,
                        text: 'Sign in',
                        textColor: AppColors.backgroundgrayColor,
                        heightPercent: 15,
                        widthPercent: 1,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(20),
                    ),
                    // const Center(
                    //   child: CustomTextGray(
                    //     mainText: 'or sign in with ',
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: screenHeight(20),
                    // ),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     CustomImage(imagename: 'facebook_icon'),
                    //     CustomImage(imagename: 'google_icon'),
                    //     CustomImage(imagename: 'twitter_icon'),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextGray(
                            mainText: 'You already have account? '),
                        InkWell(
                          onTap: () {
                            Get.offAll(const SignUpView());
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
