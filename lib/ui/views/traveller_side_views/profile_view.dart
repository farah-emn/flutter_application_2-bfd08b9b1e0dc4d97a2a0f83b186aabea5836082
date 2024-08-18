import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController _mobileNumberController =
      TextEditingController();
  late final TextEditingController _firstNameController =
      TextEditingController();
  late final TextEditingController _lastNameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();

  late final TextEditingController _nationalityController =
      TextEditingController();
  late final TextEditingController _monthController = TextEditingController();
  late final TextEditingController _yearController = TextEditingController();
  late final TextEditingController _dayController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late final User? user;
  String? email;
  String? selectedGender;
  bool displayMonthsList = false;
  bool displayDaysList = false;
  bool displayYearsList = false;

  final _formKey = GlobalKey<FormState>();
  DateTime minDate = DateTime.now();
  late final Function(String) onDateSelected;
  late final Rx<DateTime> Departure_date;
  late final TextEditingController datecontroller;

  late DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('user');
    user = _auth.currentUser;

    getData();
  }

  void getData() async {
    final userId = user!.uid.toString();
    final event = await ref.child(userId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    selectedGender = userData['gender'];
    _emailController.text = userData['email'];
    _mobileNumberController.text = userData['mobile_number'];
    _firstNameController.text = userData['first_name'];
    _lastNameController.text = userData['last_name'];
    _nationalityController.text = userData['nationality'];
    _dayController.text = userData['day'];
    _monthController.text = userData['month'];
    _yearController.text = userData['year'];
  }

  void _showModalSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (Builder) {
        return Container(
          height: 200,
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.minimize,
                    size: 40,
                    color: AppColors.gray,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: AppColors.mainColorBlue,
                        value: 'male',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(
                            () {
                              selectedGender = value.toString();
                            },
                          );
                        },
                      ),
                      const Text(
                        'Male',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: AppColors.mainColorBlue,
                        value: 'female',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                      ),
                      const Text('Female'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [AppColors.lightBlue, AppColors.lightPurple],
        ),
      ),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.lightPurple,
                ),
              ),
              const Text(
                'Profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> userData = {
                      'mobile_number': _mobileNumberController.text,
                      'first_name': _firstNameController.text,
                      'last_name': _lastNameController.text,
                      'nationality': _nationalityController.text,
                      'day': _dayController.text ?? '',
                      'month': _monthController.text ?? '',
                      'year': _yearController.text ?? '',
                      'gender': selectedGender ?? '',
                    };
                    ref
                        .child(user!.uid.toString())
                        .update(userData)
                        .then((value) => Get.back());
                  }
                },
                child: const Icon(
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
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        AssetImage('assets/image/png/girlUser1.png'),
                  ),
                ),
                // TextField(
                //   enabled: false,
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 20),
                //   controller: _emailController,
                //   decoration: textFielDecoratiom.copyWith(
                //     enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: AppColors.backgroundgrayColor,
                //       ),
                //     ),
                //     disabledBorder: const UnderlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //       borderSide:
                //           BorderSide(color: AppColors.backgroundgrayColor),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width - 30,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        color: AppColors.grayText,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: size.width - 93,
                        child: const Text(
                          'You are responsible for the data entered. Please ensure that it is correct',
                          style: TextStyle(
                              color: AppColors.grayText, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.vertical,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      const Row(
                        children: [
                          Text(
                            'Account Details',
                            style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: List.filled(
                            10,
                            const BoxShadow(
                                color: AppColors.gray,
                                blurRadius: BorderSide.strokeAlignOutside,
                                blurStyle: BlurStyle.outer),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
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
                            Container(
                              height: 40,
                              color: Colors.white,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                enabled: false,
                                controller: _emailController,
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.email_rounded,
                                    color: AppColors.Blue,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
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
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: _mobileNumberController,
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.call,
                                    color: AppColors.Blue,
                                  ),
                                ),
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.length < 10) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Personal Informations',
                            style: TextStyle(
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: List.filled(
                            10,
                            const BoxShadow(
                                color: AppColors.gray,
                                blurRadius: BorderSide.strokeAlignOutside,
                                blurStyle: BlurStyle.outer),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'First Name',
                                  style: TextStyle(
                                    fontSize: TextSize.header2,
                                    color: AppColors.grayText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: _firstNameController,
                                onChanged: (value) {},
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.person_2_rounded,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Last Name',
                                  style: TextStyle(
                                    fontSize: TextSize.header2,
                                    color: AppColors.grayText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: _lastNameController,
                                onChanged: (value) {},
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.person_2_rounded,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: TextSize.header2,
                                    color: AppColors.grayText,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: _showModalSheet,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.LightGrayColor,
                                      width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.male,
                                      color: AppColors.lightPurple,
                                    ),
                                    Text(
                                      selectedGender ?? 'Select Your Gender',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.grayText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20 ,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Nationality',
                                  style: TextStyle(
                                    fontSize: TextSize.header2,
                                    color: AppColors.grayText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              width: size.width,
                              child: TextField(
                                controller: _nationalityController,
                                decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.flag_rounded,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _mobileNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }
}
