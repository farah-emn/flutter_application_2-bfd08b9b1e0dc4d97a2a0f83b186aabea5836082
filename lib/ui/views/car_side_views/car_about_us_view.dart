// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class CarAboutUsView extends StatefulWidget {
  const CarAboutUsView({super.key});
  @override
  State<CarAboutUsView> createState() => _CarAboutUsViewState();
}

class _CarAboutUsViewState extends State<CarAboutUsView> {
  late String CompanyName;
  var CarImage;
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _CarNameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late final User? user;
  late DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Car_Rental_Company');
    user = _auth.currentUser;

    getData();
  }

  void getData() async {
    final userId = user!.uid.toString();
    final event = await ref.child(userId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    _CarNameController.text = userData['car_name_company'];
    _emailController.text = userData['email'];
    _mobileNumberController.text = userData['mobile_number'];

    _locationController.text =
        '${userData['location']} - ${userData['address']}';
    if (mounted) {
      setState(() {
        CarImage = userData['image'];
      });
    }
    // _mobileNumberController.text = userData['mobile_number'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGray,
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.save_as,
                  color: AppColors.lightGray,
                ),
                Text(
                  'About Us',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                InkWell(
                  child: Icon(
                    Icons.save_as,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 70,
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Column(
                      children: [
                        if (CarImage != null)
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundImage: NetworkImage(CarImage),
                            ),
                          )
                        else
                          const SizedBox(
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
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: List.filled(
                        10,
                        const BoxShadow(
                            color: AppColors.gray,
                            blurRadius: BorderSide.strokeAlignOutside,
                            blurStyle: BlurStyle.outer),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Company name',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: size.width,
                        child: TextField(
                          cursorColor: AppColors.darkGray,
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          controller: _CarNameController,
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.darkGray, width: 1.5),
                              ),
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.business_outlined,
                                color: AppColors.darkGray,
                              )),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: size.width,
                        child: TextField(
                          readOnly: true,
                          controller: _emailController,
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide: BorderSide(
                                    color: AppColors.darkGray, width: 1.5),
                              ),
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: AppColors.darkGray,
                              )),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Mobile number',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: size.width,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: textFielDecoratiom.copyWith(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(
                                  color: AppColors.darkGray, width: 1.5),
                            ),
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.call,
                              color: AppColors.darkGray,
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: size.width,
                        child: TextField(
                          decoration: textFielDecoratiom.copyWith(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(
                                  color: AppColors.mainColorBlue, width: 1.5),
                            ),
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.location_on_rounded,
                              color: AppColors.darkGray,
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
