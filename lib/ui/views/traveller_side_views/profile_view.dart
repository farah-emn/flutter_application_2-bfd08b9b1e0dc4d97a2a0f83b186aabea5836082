import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  List<String> monthsList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> daysList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31"
  ];

  List<String> yearsList = [
    "1960",
    "1961",
    "1962",
    "1963",
    "1964",
    "1965",
    "1966",
    "1967",
    "1968",
    "1969",
    "1970",
    "1971",
    "1972",
    "1973",
    "1974",
    "1975",
    "1976",
    "1977",
    "1978",
    "1979",
    "1980",
    "1981",
    "1982",
    "1983",
    "1984",
    "1985",
    "1986",
    "1987",
    "1988",
    "1989",
    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006"
  ];

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
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.StatusBarColor,
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.backgroundgrayColor,
                    ),
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
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
                      color: AppColors.backgroundgrayColor,
                    ),
                  ),
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
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.warning_rounded,
                            color: AppColors.BlueText,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: size.width - 93,
                            child: const Text(
                              'You are responsible for the data entered. Please ensure that it is correct',
                              style: TextStyle(
                                  color: AppColors.BlueText, fontSize: 15),
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
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
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              enabled: false,
                              controller: _emailController,
                              decoration: textFielDecoratiom.copyWith(),
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
                                'Mobile Number',
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
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberController,
                              decoration: textFielDecoratiom.copyWith(),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value!.length < 10) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'First Name',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _firstNameController,
                              onChanged: (value) {},
                              decoration: textFielDecoratiom.copyWith(),
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
                                'Last Name',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _lastNameController,
                              onChanged: (value) {},
                              decoration: textFielDecoratiom.copyWith(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Gender',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: InkWell(
                              onTap: _showModalSheet,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedGender ?? 'Select Your Gender',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.grayText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Color.fromARGB(81, 130, 143, 163),
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, top: 5),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Date of Birth',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    inputField(context, 'day', _dayController),
                                    displayDaysList
                                        ? selectionField(
                                            context, 'day', _dayController)
                                        : SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    inputField(
                                        context, 'month', _monthController),
                                    displayMonthsList
                                        ? selectionField(
                                            context, 'month', _monthController)
                                        : SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    inputField(
                                        context, 'year', _yearController),
                                    displayYearsList
                                        ? selectionField(
                                            context, 'year', _yearController)
                                        : SizedBox(),
                                  ],
                                ),
                              ],
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
                                'Nationality',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _nationalityController,
                              decoration: textFielDecoratiom.copyWith(
                                hintText: 'Nationality',
                              ),
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

  Widget inputField(
      BuildContext context, String type, TextEditingController controller) {
    return Container(
      height: 45,
      width: type == 'month' ? context.width / 3 - 5 : context.width / 3 - 30,
      decoration: BoxDecoration(
        color: AppColors.backgroundgrayColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        border: Border.all(color: AppColors.grayText),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: type == 'day'
              ? 'Day'
              : type == 'month'
                  ? 'Month'
                  : 'Year',
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              switch (type) {
                case 'day':
                  displayDaysList = !displayDaysList;
                  break;
                case 'month':
                  displayMonthsList = !displayMonthsList;
                  break;
                case 'year':
                  displayYearsList = !displayYearsList;
                  break;
              }
              setState(() {});
            },
            child: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }

  Widget selectionField(
      BuildContext context, String type, TextEditingController controller) {
    return Container(
      height: 200,
      width: type == 'month' ? context.width / 3 - 10 : context.width / 3 - 25,
      decoration: BoxDecoration(
        color: AppColors.backgroundgrayColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        border: Border.all(color: AppColors.LightGrayColor),
      ),
      child: ListView.builder(
        itemCount: type == 'day'
            ? daysList.length
            : type == 'month'
                ? monthsList.length
                : yearsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                switch (type) {
                  case 'day':
                    controller.text = (index + 1).toString();
                    displayDaysList = false;
                    break;
                  case 'month':
                    controller.text = monthsList[index];
                    displayMonthsList = false;

                    break;
                  case 'year':
                    controller.text = yearsList[index];
                    displayYearsList = false;

                    break;
                }
              });
            },
            child: ListTile(
              title: Text(
                type == 'day'
                    ? daysList[index]
                    : type == 'month'
                        ? monthsList[index]
                        : yearsList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
