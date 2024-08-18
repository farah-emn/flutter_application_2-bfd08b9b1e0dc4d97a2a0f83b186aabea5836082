// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/currency_display.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightAboutUsView extends StatefulWidget {
  const FlightAboutUsView({super.key});
  @override
  State<FlightAboutUsView> createState() => _FlightAboutUsViewState();
}

class _FlightAboutUsViewState extends State<FlightAboutUsView> {
  late String email;
  late String password;
  late String confermPassword;
  late String AirelineCode;
  late String CompanyName;
  var Companylogo;
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
  final _auth = FirebaseAuth.instance;
  late final User? user;
  late DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Airline_company');
    user = _auth.currentUser;

    getData();
  }

  void getData() async {
    final userId = user!.uid.toString();
    final event = await ref.child(userId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    _CompanyNameController.text = userData['AirlineCompanyName'];
    _emailController.text = userData['email'];
    if (mounted) {
      setState(() {
        Companylogo = userData['logo'];
      });
    }
    // _mobileNumberController.text = userData['mobile_number'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
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
              padding: const EdgeInsets.only(top: 90, right: 15, left: 15),
              child: Column(
                children: [
                  Column(
                    children: [
                      if (Companylogo != null)
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(Companylogo),
                          ),
                        )
                      else
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage:
                                AssetImage('assets/image/png/girlUser1.png'),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
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
                    width: size.width,
                    child: TextField(
                      controller: _CompanyNameController,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      decoration: textFielDecoratiom.copyWith(
                          prefixIcon: const Icon(Icons.business_outlined)),
                      onChanged: (value) {},
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
                    width: size.width,
                    child: TextField(
                      controller: _emailController,
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFielDecoratiom.copyWith(
                          prefixIcon: const Icon(Icons.email)),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // const Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       'Mobile number',
                  //       style: TextStyle(
                  //           fontSize: 13,
                  //           color: AppColors.grayText,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 45,
                  //   width: size.width,
                  //   child: TextField(
                  //     keyboardType: TextInputType.phone,
                  //     decoration: textFielDecoratiom.copyWith(
                  //         prefixIcon: const Icon(Icons.call)),
                  //     onChanged: (value) {},
                  //   ),
                  // ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
