// // // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_key_in_widget_constructors, use_build_context_synchronously, library_private_types_in_public_api, unnecessary_null_comparison, sized_box_for_whitespace, body_might_complete_normally_nullable, curly_braces_in_flow_control_structures, prefer_is_empty, prefer_conditional_assignment

// // import 'package:flutter/material.dart';
// // import 'package:flutter_ocr_sdk/mrz_result.dart';
// // import 'package:fluttertoast/fluttertoast.dart';k
// // import 'package:get/get.dart';
// // import 'package:traveling/controllers/flight_info_controller.dart';
// // import 'package:traveling/controllers/traveller_details_view1_controller.dart';
// // import 'package:traveling/controllers/traveller_details_view2_controller.dart';
// // import 'package:traveling/ui/shared/colors.dart';
// // import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
// // import 'package:traveling/ui/shared/text_size.dart';
// // import 'package:traveling/ui/shared/utils.dart';
// // import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/scan_traveller_id/traveller_scan_id_view.dart';
// // import 'scan_traveller_id/global.dart';

// // class TravellerDetailsView2 extends StatefulWidget {
// //   MrzResult? change_data;
// //   final TextEditingController? firstname_con;
// //   final TextEditingController? lastname_con;
// //   final TextEditingController? nationality_con;
// //   final TextEditingController? dateofbirth_con;
// //   final TextEditingController? passportnumber_con;
// //   final TextEditingController? issuingcountry_con;
// //   final TextEditingController? expiredate_con;
// //   final TextEditingController? gender;

// //   TravellerDetailsView2(
// //       {this.change_data,
// //       this.firstname_con,
// //       this.lastname_con,
// //       this.nationality_con,
// //       this.dateofbirth_con,
// //       this.passportnumber_con,
// //       this.issuingcountry_con,
// //       this.expiredate_con,
// //       this.gender});

// //   @override
// //   _TravellerDetailsView2State createState() => _TravellerDetailsView2State();
// // }

// // class _TravellerDetailsView2State extends State<TravellerDetailsView2> {
// //   final firstname_con = TextEditingController();
// //   final lastname_con = TextEditingController();
// //   final nationality_con = TextEditingController();
// //   final dateofbirth_con = TextEditingController();
// //   final passportnumber_con = TextEditingController();
// //   final issuingcountry_con = TextEditingController();
// //   final expiredate_con = TextEditingController();
// //   final controller_TravellerDetailsView2 =
// //       Get.put(TravellerDetailsView2Controller());
// //   TravellerDetailsView2Controller controller_TravellerDetailsview2 =
// //       Get.find<TravellerDetailsView2Controller>();
// //   TravellerDetailsView1Controller controller_TravellerDetailsview1 =
// //       Get.find<TravellerDetailsView1Controller>();
// //   final FlightInfoController flightInfoController =
// //       Get.put(FlightInfoController());
// //   bool isNationalitySelected = false;
// //   bool isGenderSelected = false;
// //   bool isBirthDateSelected = false;
// //   bool isBirthDateDaySelected = false;
// //   bool isBirthDateMonthSelected = false;
// //   bool isBirthDateYearSelected = false;
// //   bool isExpireDaySelected = false;
// //   bool isExpireDateMonthSelected = false;
// //   bool isExpireDateYearSelected = false;
// //   bool isissuingcountrySelected = false;
// //   String? errorMessageNationality = '';
// //   String? errorMessageGender = '';
// //   String? errorMessageBirthDate = '';
// //   String? errorMessageExpireDate = '';
// //   String? errorMessageissuingcountry = '';
// //   String? errorFirstName = '';
// //   String? errorLastName = '';
// //   String? errorPassport = '';
// //   String? generalErrorMessage = '';

// //   var selectedgender;
// //   MrzResult? TravellerData;
// //   Gender? selectedOption;
// //   String? selectedValueIssuingCountry;
// //   String? selectedValueNationality;
// //   final List<String> items_Nationality = ['Syrian - SYR', 'Algeria - DZA'];
// //   final List<String> items_issuingCountry = ['SYR - Syrian', 'DZA - Algeria'];
// //   final List<String> genderItems = [
// //     'Male',
// //     'Female',
// //   ];

// //   DateTime now = DateTime.now();
// //   late List<int> daysListBirthDate;
// //   late List<int> monthListBirthDate;
// //   late List<int> yearListBirthDate;
// //   late List<int> daysListExpireDate;
// //   late List<int> monthListExpireDate;
// //   late List<int> yearListExpireDate;

// //   int? selectedBirthDateDay;
// //   int? selectedBirthDateMonth;
// //   int? selectedBirthDateYear;
// //   int? selectedExpireDateDay;
// //   int? selectedExpireDateMonth;
// //   int? selectedExpireDateYear;
// //   Future<int> loadData() async {
// //     return await initMRZSDK();
// //   }

// //   @override
// //   void initState() {
// //     super.initState();

// //     daysListBirthDate = List<int>.generate(31, (i) => i + 1);
// //     monthListBirthDate = List<int>.generate(12, (i) => i + 1);
// //     yearListBirthDate = List<int>.generate(2006 - 1940 + 1, (i) => i + 1940);
// //     daysListExpireDate = List<int>.generate(31, (i) => i + 1);
// //     monthListExpireDate = List<int>.generate(12, (i) => i + 1);
// //     yearListExpireDate = List<int>.generate(2055 - 2024 + 1, (i) => i + 2024);

// //     if (TravellerData == null && widget.change_data == null) {
// //       setState(() {
// //         controller_TravellerDetailsView2.setgender('gender');
// //         controller_TravellerDetailsview2.setNationality('Nationality');
// //         controller_TravellerDetailsview2.setbirthdateDay('Day');
// //         controller_TravellerDetailsview2.setbirthdateMonth('Month');
// //         controller_TravellerDetailsview2.setbirthdateYear('Year');
// //         controller_TravellerDetailsview2.setexpiredateDay('Day');
// //         controller_TravellerDetailsview2.setexpiredateMonth('Month');
// //         controller_TravellerDetailsview2.setexpiredateYear('Year');
// //         controller_TravellerDetailsview2.setissuingcountry('issuing Country');
// //       });
// //     } else if (widget.change_data != null) {
// //       setState(() {
// //         firstname_con.text = widget.change_data!.givenName!;
// //         lastname_con.text = widget.change_data!.surname!;
// //         passportnumber_con.text = widget.change_data!.passportNumber!;
// //         issuingcountry_con.text = widget.change_data!.issuingCountry!;
// //         controller_TravellerDetailsView2
// //             .setgender(widget.change_data?.gender ?? '');
// //         controller_TravellerDetailsView2
// //             .setNationality(widget.change_data?.nationality ?? '');
// //         controller_TravellerDetailsview2
// //             .setissuingcountry(widget.change_data?.issuingCountry ?? '');
// //         String? birthDate = widget.change_data?.birthDate;
// //         String? expiration = widget.change_data?.expiration;
// //         List<String> BirthDate = birthDate!.split('/');
// //         List<String> expirationDate = expiration!.split('/');
// //         int yearBirthDate = int.parse(BirthDate[0]);
// //         int monthBirthDate = int.parse(BirthDate[1]);
// //         int dayBirthDate = int.parse(BirthDate[2]);
// //         int yearExpirationDate = int.parse(expirationDate[0]);
// //         int monthExpirationDate = int.parse(expirationDate[1]);
// //         int dayExpirationDate = int.parse(expirationDate[2]);
// //         controller_TravellerDetailsview2
// //             .setbirthdateDay(dayBirthDate.toString());
// //         controller_TravellerDetailsview2
// //             .setbirthdateMonth(monthBirthDate.toString());
// //         controller_TravellerDetailsview2
// //             .setbirthdateYear(yearBirthDate.toString());
// //         controller_TravellerDetailsview2
// //             .setexpiredateDay(dayExpirationDate.toString());
// //         controller_TravellerDetailsview2
// //             .setexpiredateMonth(monthExpirationDate.toString());
// //         controller_TravellerDetailsview2
// //             .setexpiredateYear(yearExpirationDate.toString());
// //         isBirthDateSelected = true;
// //         isNationalitySelected = true;
// //         isGenderSelected = true;
// //         isBirthDateDaySelected = true;
// //         isBirthDateMonthSelected = true;
// //         isBirthDateYearSelected = true;
// //         isExpireDaySelected = true;
// //         isExpireDateMonthSelected = true;
// //         isExpireDateYearSelected = true;
// //         isissuingcountrySelected = true;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //   }

// //   void _confirm() async {
// //     setState(() {
// //       if (firstname_con.text.isEmpty &&
// //           lastname_con.text.isEmpty &&
// //           passportnumber_con.text.isEmpty &&
// //           !isBirthDateDaySelected &&
// //           !isBirthDateMonthSelected &&
// //           !isBirthDateYearSelected &&
// //           !isExpireDateMonthSelected &&
// //           !isExpireDateYearSelected &&
// //           !isExpireDaySelected &&
// //           !isGenderSelected &&
// //           !isNationalitySelected &&
// //           !isissuingcountrySelected) {
// //         generalErrorMessage = 'Please enter all fields';
// //       } else {
// //         errorFirstName = (firstname_con.text.length < 2)
// //             ? 'Please Enter a First name more than two characters'
// //             : null;
// //         errorLastName = (lastname_con.text.length < 2)
// //             ? 'Please Enter a last name more than two characters'
// //             : null;
// //         errorPassport = (passportnumber_con.text.length == 0)
// //             ? 'Please Enter a valid Passport number'
// //             : null;
// //         errorMessageNationality =
// //             isNationalitySelected ? null : 'Please choose your Nationality';
// //         errorMessageissuingcountry =
// //             isissuingcountrySelected ? null : 'Please choose issuing country';
// //         errorMessageGender =
// //             isGenderSelected ? null : 'Please choose your Gender';
// //         errorMessageExpireDate = (isExpireDaySelected &&
// //                 isExpireDateMonthSelected &&
// //                 isExpireDateYearSelected)
// //             ? null
// //             : 'Please choose your Expire date';
// //         errorMessageBirthDate = (isBirthDateDaySelected &&
// //                 isBirthDateMonthSelected &&
// //                 isBirthDateYearSelected)
// //             ? null
// //             : 'Please choose your Birth date';
// //       }
// //     });
// //     if (isBirthDateDaySelected &&
// //         isBirthDateMonthSelected &&
// //         isBirthDateYearSelected &&
// //         isExpireDateMonthSelected &&
// //         isExpireDateYearSelected &&
// //         isExpireDaySelected &&
// //         isGenderSelected &&
// //         isNationalitySelected &&
// //         isissuingcountrySelected) {
// //       setState(() {
// //         if (TravellerData == null) {
// //           TravellerData = MrzResult();
// //         }
// //         TravellerData?.givenName = firstname_con.text;
// //         TravellerData?.surname = lastname_con.text;
// //         TravellerData?.gender = controller_TravellerDetailsView2.gender.value;
// //         TravellerData?.passportNumber = passportnumber_con.text;
// //         TravellerData?.birthDate =
// //             '${selectedBirthDateYear ?? controller_TravellerDetailsview2.birthdateYear.value}/${selectedBirthDateMonth ?? controller_TravellerDetailsview2.birthdateMonth.value}/${selectedBirthDateDay ?? controller_TravellerDetailsview2.birthdateDay.value}';
// //         TravellerData?.nationality =
// //             controller_TravellerDetailsview2.Nationality.value;
// //         TravellerData?.expiration =
// //             '${(selectedExpireDateYear != null) ? selectedExpireDateYear.toString() : controller_TravellerDetailsview2.expiredateYear.value}/${(selectedExpireDateMonth != null) ? selectedExpireDateMonth.toString() : controller_TravellerDetailsview2.expiredateMonth.value}/${(selectedExpireDateDay != null) ? selectedExpireDateDay.toString() : controller_TravellerDetailsview2.expiredateDay.value}';
// //         TravellerData?.issuingCountry =
// //             controller_TravellerDetailsview2.issuingcountry.value;

// //         if (controller_TravellerDetailsview1.AdultList.isEmpty) {
// //           Navigator.pop(context, TravellerData);
// //         } else if (controller_TravellerDetailsview1.AdultList.isNotEmpty &&
// //             controller_TravellerDetailsview1.ChildList.isEmpty) {
// //           if (widget.change_data != null) {
// //             bool isTravellerAdded =
// //                 controller_TravellerDetailsview1.AdultList.any((element) =>
// //                     element.passportNumber == passportnumber_con.text &&
// //                     widget.change_data?.passportNumber !=
// //                         passportnumber_con.text);

// //             if (!isTravellerAdded) {
// //               setState(() {
// //                 widget.change_data?.givenName = firstname_con.text;
// //                 widget.change_data?.surname = lastname_con.text;
// //                 widget.change_data?.gender =
// //                     controller_TravellerDetailsview2.gender.value;
// //                 widget.change_data?.nationality =
// //                     controller_TravellerDetailsview2.Nationality.value;
// //                 widget.change_data?.passportNumber = passportnumber_con.text;
// //                 widget.change_data?.issuingCountry =
// //                     controller_TravellerDetailsview2.issuingcountry.value;
// //                 widget.change_data?.birthDate =
// //                     '${selectedBirthDateYear ?? controller_TravellerDetailsview2.birthdateYear.value}/${selectedBirthDateMonth ?? controller_TravellerDetailsview2.birthdateMonth.value}/${selectedBirthDateDay ?? controller_TravellerDetailsview2.birthdateDay.value}';
// //                 widget.change_data?.expiration =
// //                     '${(selectedExpireDateYear != null) ? selectedExpireDateYear.toString() : controller_TravellerDetailsview2.expiredateYear.value}/${(selectedExpireDateMonth != null) ? selectedExpireDateMonth.toString() : controller_TravellerDetailsview2.expiredateMonth.value}/${(selectedExpireDateDay != null) ? selectedExpireDateDay.toString() : controller_TravellerDetailsview2.expiredateDay.value}';
// //                 Navigator.pop(context, widget.change_data);
// //               });
// //             } else {
// //               Fluttertoast.showToast(
// //                   msg: 'The traveler is already aded',
// //                   toastLength: Toast.LENGTH_SHORT,
// //                   gravity: ToastGravity.BOTTOM,
// //                   timeInSecForIosWeb: 1,
// //                   backgroundColor: Colors.grey,
// //                   textColor: Colors.white,
// //                   fontSize: 16.0);
// //             }
// //           } else {
// //             bool isTravellerAdded = false;
// //             for (var AdultTraveller
// //                 in controller_TravellerDetailsview1.AdultList) {
// //               for (var ChildTraveller
// //                   in controller_TravellerDetailsview1.ChildList) {
// //                 if (AdultTraveller.passportNumber ==
// //                     ChildTraveller.passportNumber) {
// //                   isTravellerAdded = true;
// //                 }
// //                 if (ChildTraveller.passportNumber == passportnumber_con.text) {
// //                   isTravellerAdded = true;
// //                 }
// //                 if (AdultTraveller.passportNumber == passportnumber_con.text) {
// //                   isTravellerAdded = true;
// //                 }
// //               }
// //             }
// //             if (isTravellerAdded == true) {
// //               Fluttertoast.showToast(
// //                   msg: 'The traveler is already added',
// //                   toastLength: Toast.LENGTH_SHORT,
// //                   gravity: ToastGravity.BOTTOM,
// //                   timeInSecForIosWeb: 1,
// //                   backgroundColor: Colors.grey,
// //                   textColor: Colors.white,
// //                   fontSize: 16.0);
// //             } else {
// //               Navigator.pop(context, TravellerData);
// //             }
// //           }
// //         }
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     return Scaffold(
// //       backgroundColor: AppColors.Blue,
// //       body: Stack(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.only(left: 15, right: 15, top: 35),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   'Flight Details',
// //                   style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.w700,
// //                       color: AppColors.backgroundgrayColor),
// //                 ),
// //                 SizedBox(),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.only(
// //               top: 70,
// //             ),
// //             child: Container(
// //               decoration: const BoxDecoration(
// //                 image: DecorationImage(
// //                     image: AssetImage('assets/image/png/background1.png'),
// //                     fit: BoxFit.fill),
// //               ),
// //             ),
// //           ),
// //           Column(
// //             children: <Widget>[
// //               SizedBox(height: 80),
// //               InkWell(
// //                 onTap: () async {
// //                   int data = await loadData();
// //                   if (data != null) {
// //                     print('kkkkk');
// //                     TravellerData = await Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => ScanId(
// //                             firstname_con: firstname_con,
// //                             lastname_con: lastname_con,
// //                             dateofbirth_con: dateofbirth_con,
// //                             passportnumber_con: passportnumber_con,
// //                             issuingcountry_con: issuingcountry_con,
// //                             expiredate_con: expiredate_con,
// //                             nationality_con: nationality_con,
// //                             gender: TravellerData?.gender),
// //                       ),
// //                     );
// //                     if (TravellerData != null) {
// //                       setState(() {
// //                         controller_TravellerDetailsview2
// //                             .setgender(TravellerData?.gender ?? '');
// //                         controller_TravellerDetailsview2.setissuingcountry(
// //                             TravellerData?.issuingCountry ?? '');
// //                         controller_TravellerDetailsView2
// //                             .setNationality(TravellerData?.nationality ?? '');
// //                         controller_TravellerDetailsview2.setbirthdateDay(
// //                             controller_TravellerDetailsview2
// //                                 .getFormattedDateDay(
// //                                     TravellerData?.birthDate ?? ''));
// //                         controller_TravellerDetailsview2.setbirthdateMonth(
// //                             controller_TravellerDetailsview2
// //                                 .getFormattedDateMonth(
// //                                     TravellerData?.birthDate ?? ''));
// //                         controller_TravellerDetailsview2.setbirthdateYear(
// //                             controller_TravellerDetailsview2
// //                                 .getFormattedDateYear(
// //                                     TravellerData?.birthDate ?? ''));
// //                         controller_TravellerDetailsview2.setexpiredateDay(
// //                             controller_TravellerDetailsview2
// //                                 .getFormattedDateDay(
// //                                     TravellerData?.expiration ?? ''));
// //                         controller_TravellerDetailsview2.setexpiredateMonth(
// //                             controller_TravellerDetailsview2
// //                                 .getFormattedDateMonth(
// //                                     TravellerData?.expiration ?? ''));
// //                         controller_TravellerDetailsview2.setexpiredateYear(
// //                             controller_TravellerDetailsview2
// //                                 .getFormattedDateYear(
// //                                     TravellerData?.expiration ?? ''));
// //                       });
// //                     }
// //                     if (TravellerData == null) {
// //                       if (widget.change_data != null) {
// //                         setState(() {
// //                           controller_TravellerDetailsview2.gender.value =
// //                               widget.change_data?.gender;
// //                           controller_TravellerDetailsview2.Nationality.value =
// //                               widget.change_data?.nationality;
// //                           controller_TravellerDetailsview2.issuingcountry
// //                               .value = widget.change_data?.issuingCountry;
// //                           controller_TravellerDetailsview2.birthdateDay.value =
// //                               (widget.change_data?.birthDate != null)
// //                                   ? controller_TravellerDetailsview2
// //                                       .getFormattedDateDay(
// //                                           widget.change_data?.birthDate ?? '')
// //                                   : controller_TravellerDetailsview2
// //                                       .birthdateDay.value;
// //                           controller_TravellerDetailsview2
// //                                   .birthdateMonth.value =
// //                               (widget.change_data?.birthDate != null)
// //                                   ? controller_TravellerDetailsview2
// //                                       .getFormattedDateMonth(
// //                                           widget.change_data?.birthDate ?? '')
// //                                   : controller_TravellerDetailsview2
// //                                       .birthdateMonth.value;

// //                           controller_TravellerDetailsview2.birthdateYear.value =
// //                               (widget.change_data?.birthDate != null)
// //                                   ? controller_TravellerDetailsview2
// //                                       .getFormattedDateYear(
// //                                           widget.change_data?.birthDate ?? '')
// //                                   : controller_TravellerDetailsview2
// //                                       .birthdateYear.value;

// //                           controller_TravellerDetailsview2.expiredateDay.value =
// //                               (widget.change_data?.expiration != null)
// //                                   ? controller_TravellerDetailsview2
// //                                       .getFormattedDateDay(
// //                                           widget.change_data?.expiration ?? '')
// //                                   : controller_TravellerDetailsview2
// //                                       .expiredateDay.value;

// //                           controller_TravellerDetailsview2
// //                                   .expiredateMonth.value =
// //                               (widget.change_data?.expiration != null)
// //                                   ? controller_TravellerDetailsview2
// //                                       .getFormattedDateMonth(
// //                                           widget.change_data?.expiration ?? '')
// //                                   : controller_TravellerDetailsview2
// //                                       .expiredateMonth.value;
// //                           controller_TravellerDetailsview2
// //                                   .expiredateYear.value =
// //                               (widget.change_data?.expiration != null)
// //                                   ? controller_TravellerDetailsview2
// //                                       .getFormattedDateYear(
// //                                           widget.change_data?.expiration ?? '')
// //                                   : controller_TravellerDetailsview2
// //                                       .expiredateYear.value;
// //                         });
// //                       }
// //                     }
// //                     if (TravellerData != null)
// //                       setState(() {
// //                         isBirthDateSelected = true;
// //                         isNationalitySelected = true;
// //                         isGenderSelected = true;
// //                         isBirthDateDaySelected = true;
// //                         isBirthDateMonthSelected = true;
// //                         isBirthDateYearSelected = true;
// //                         isExpireDaySelected = true;
// //                         isExpireDateMonthSelected = true;
// //                         isExpireDateYearSelected = true;
// //                         isissuingcountrySelected = true;
// //                       });
// //                     if (widget.change_data != null) {
// //                       setState(() {
// //                         widget.change_data?.birthDate =
// //                             TravellerData?.birthDate;
// //                         widget.change_data?.expiration =
// //                             TravellerData?.expiration;
// //                       });
// //                     }
// //                   }
// //                 },
// //                 child: Expanded(
// //                   child: ListView(
// //                     scrollDirection: Axis.vertical,
// //                     children: [
// //                       Container(
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               width: size.width,
// //                               padding: EdgeInsets.all(10),
// //                               decoration: BoxDecoration(
// //                                 color: AppColors.babyblueColor,
// //                                 borderRadius:
// //                                     BorderRadiusDirectional.circular(25),
// //                               ),
// //                               child: Column(
// //                                 children: [
// //                                   Text(
// //                                     'Use your passport or GCC National ID to quickly and securely auto-fill traveller details',
// //                                     style: TextStyle(
// //                                       fontWeight: FontWeight.w500,
// //                                       color: Color.fromRGBO(96, 96, 96, 1),
// //                                       fontSize: TextSize.header1,
// //                                     ),
// //                                     textAlign: TextAlign.center,
// //                                   ),
// //                                   SizedBox(height: 10),
// //                                   GestureDetector(
// //                                     child: Container(
// //                                       width: screenWidth(1.3),
// //                                       height: screenWidth(10),
// //                                       decoration: BoxDecoration(
// //                                         color: AppColors.backgroundgrayColor,
// //                                         borderRadius: BorderRadius.circular(20),
// //                                       ),
// //                                       child: Padding(
// //                                         padding: EdgeInsetsDirectional.all(10),
// //                                         child: Center(
// //                                           child: Text(
// //                                             'Scan ID to add travellar',
// //                                             style: TextStyle(
// //                                               color: AppColors.mainColorBlue,
// //                                               fontSize: screenWidth(25),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             const Row(
// //                               children: [
// //                                 Text(
// //                                   'First Name',
// //                                   style: TextStyle(
// //                                       fontSize: 13,
// //                                       color: AppColors.grayText,
// //                                       fontWeight: FontWeight.w500),
// //                                 ),
// //                               ],
// //                             ),
// //                             Container(
// //                               height: 40,
// //                               child: CustomTextField(
// //                                 controller: firstname_con,
// //                                 validator: (value) {
// //                                   if (value!.isEmpty || value.length < 3) {
// //                                     return 'Please enter your first name';
// //                                   }
// //                                   return null;
// //                                 },
// //                                 prefIcon: Icons.person_2,
// //                                 colorIcon: AppColors.Blue,
// //                                 style: TextStyle(),
// //                               ),
// //                             ),
// //                             (errorFirstName != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       errorFirstName!,
// //                                       style: TextStyle(
// //                                           fontSize: 11,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(
// //                                     height: 20,
// //                                   ),
// //                             const Row(
// //                               children: [
// //                                 Text(
// //                                   'Last Name',
// //                                   style: TextStyle(
// //                                       fontSize: 13,
// //                                       color: AppColors.grayText,
// //                                       fontWeight: FontWeight.w500),
// //                                 ),
// //                               ],
// //                             ),
// //                             // CustomTextField(

// //                             //   controller: lastname_con,
// //                             //   validator: (value) {
// //                             //     if (value!.isEmpty || value.length < 3) {
// //                             //       return 'Please enter your last name';
// //                             //     }
// //                             //     return null;
// //                             //   },
// //                             //   prefIcon: Icons.person_2,
// //                             //   colorIcon: AppColors.Blue,
// //                             //   hintText: 'Last Name',
// //                             //   hintTextColor: Colors.grey,
// //                             // ),
// //                             // (errorLastName != null)
// //                             //     ? Padding(
// //                             //         padding: EdgeInsetsDirectional.only(
// //                             //             start: 6, top: 10),
// //                             //         child: Text(
// //                             //           errorLastName!,
// //                             //           style: TextStyle(
// //                             //               fontSize: 11,
// //                             //               color:
// //                             //                   Color.fromARGB(255, 215, 16, 2)),
// //                             //         ),
// //                             //       )
// //                             //     : SizedBox(
// //                             //         height: 20,
// //                             //       ),
// //                             // InkWell(
// //                             //   onTap: () {
// //                             //     showGenderOptions();
// //                             //   },
// //                             //   child: Container(
// //                             //     padding: EdgeInsetsDirectional.only(
// //                             //         start: 15, end: 15),
// //                             //     height: (size.height / 16) - 5,
// //                             //     width: size.width - 40,
// //                             //     decoration: BoxDecoration(
// //                             //       color: Colors.white,
// //                             //       borderRadius: BorderRadius.circular(20),
// //                             //     ),
// //                             //     child: Row(
// //                             //       mainAxisAlignment: MainAxisAlignment.start,
// //                             //       children: [
// //                             //         Icon(Icons.person, color: AppColors.Blue),
// //                             //         SizedBox(width: 10),
// //                             //         Obx(
// //                             //           () => Text(
// //                             //             controller_TravellerDetailsView2
// //                             //                     .gender.value ??
// //                             //                 '',
// //                             //             style: TextStyle(
// //                             //               color:
// //                             //                   (controller_TravellerDetailsView2
// //                             //                               .gender.value ==
// //                             //                           'gender')
// //                             //                       ? Colors.grey
// //                             //                       : Colors.black,
// //                             //             ),
// //                             //           ),
// //                             //         ),
// //                             //         Spacer(),
// //                             //         Icon(Icons.circle_outlined,
// //                             //             size: 12, color: AppColors.grayText),
// //                             //       ],
// //                             //     ),
// //                             //   ),
// //                             // ),
// //                             // (errorMessageGender != null)
// //                             //     ? Padding(
// //                             //         padding: EdgeInsetsDirectional.only(
// //                             //             start: 6, top: 10),
// //                             //         child: Text(
// //                             //           errorMessageGender!,
// //                             //           style: TextStyle(
// //                             //               fontSize: 11,
// //                             //               color:
// //                             //                   Color.fromARGB(255, 215, 16, 2)),
// //                             //         ),
// //                             //       )
// //                             //     : SizedBox(
// //                             //         height: 20,
// //                             //       ),
// //                             Container(
// //                               decoration: BoxDecoration(
// //                                   color: Colors.white,
// //                                   borderRadius: BorderRadius.circular(20)),
// //                               padding: EdgeInsetsDirectional.only(
// //                                 start: 12,
// //                                 end: 12,
// //                               ),
// //                               height: (size.height / 16) - 5,
// //                               width: size.width - 40,
// //                               child: DropdownButtonHideUnderline(
// //                                 child: DropdownButton<String?>(
// //                                   isExpanded: true,
// //                                   hint: Row(
// //                                     children: [
// //                                       SizedBox(
// //                                         width: 6,
// //                                       ),
// //                                       Icon(
// //                                         Icons.public,
// //                                         size: 22,
// //                                         color: AppColors.Blue,
// //                                       ),
// //                                       SizedBox(
// //                                         width: 12,
// //                                       ),
// //                                       Obx(
// //                                         () => Text(
// //                                           controller_TravellerDetailsview2
// //                                                   .Nationality.value ??
// //                                               'Nationality',
// //                                           style: TextStyle(
// //                                             color:
// //                                                 (controller_TravellerDetailsView2
// //                                                             .Nationality
// //                                                             .value ==
// //                                                         'Nationality')
// //                                                     ? Colors.grey
// //                                                     : Colors.black,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   items: items_Nationality
// //                                       .map((item) => DropdownMenuItem<String?>(
// //                                           value: (item),
// //                                           child: Row(
// //                                             children: [
// //                                               Icon(
// //                                                 Icons.public,
// //                                                 size: 22,
// //                                                 color: AppColors.Blue,
// //                                               ),
// //                                               SizedBox(
// //                                                 width: 12,
// //                                               ),
// //                                               Text(
// //                                                 item,
// //                                                 style: const TextStyle(
// //                                                   fontSize: 14,
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           )))
// //                                       .toList(),
// //                                   value: selectedValueNationality,
// //                                   onChanged: (value) {
// //                                     setState(() {
// //                                       selectedValueNationality = value;
// //                                       controller_TravellerDetailsView2
// //                                           .setNationality(value ?? '');
// //                                       isNationalitySelected = true;
// //                                     });
// //                                   },
// //                                   icon: Icon(
// //                                     Icons.arrow_drop_down_outlined,
// //                                     color: Colors.grey,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             (errorMessageNationality != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       errorMessageNationality!,
// //                                       style: TextStyle(
// //                                           fontSize: 11,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(
// //                                     height: 20,
// //                                   ),
// //                             CustomTextField(
// //                               controller: dateofbirth_con,
// //                               prefIcon: Icons.calendar_today,
// //                               colorIcon: AppColors.IconPurpleColor,
// //                               hintText: 'Date of Birth',
// //                               hintTextColor: Colors.grey,
// //                             ),
// //                             SizedBox(
// //                               height: 6,
// //                             ),
// //                             Text('Birth date',
// //                                 style: TextStyle(color: Colors.grey)),
// //                             SizedBox(
// //                               height: 4,
// //                             ),
// //                             Row(
// //                               children: <Widget>[
// //                                 Container(
// //                                   width: 90.0,
// //                                   padding: EdgeInsetsDirectional.only(
// //                                       start: 20, end: 10),
// //                                   decoration:
// //                                       BoxDecoration(color: Colors.white),
// //                                   child: DropdownButton<int>(
// //                                     hint: Obx(
// //                                       () => (selectedBirthDateDay == null)
// //                                           ? Text(
// //                                               controller_TravellerDetailsview2
// //                                                       .birthdateDay.value ??
// //                                                   '',
// //                                               style: TextStyle(
// //                                                 color:
// //                                                     (controller_TravellerDetailsView2
// //                                                                 .birthdateDay
// //                                                                 .value ==
// //                                                             'Day')
// //                                                         ? Colors.grey
// //                                                         : Colors.black,
// //                                               ),
// //                                             )
// //                                           : Text(
// //                                               selectedBirthDateDay.toString()),
// //                                     ),
// //                                     value: selectedBirthDateDay,
// //                                     items: daysListBirthDate.map((int value) {
// //                                       return DropdownMenuItem<int>(
// //                                         value: value,
// //                                         child: Text(value.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (newValue) {
// //                                       setState(() {
// //                                         selectedBirthDateDay = newValue;
// //                                         isBirthDateDaySelected = true;
// //                                       });
// //                                     },
// //                                     icon: Icon(
// //                                       Icons.arrow_drop_down,
// //                                       color: Colors.grey,
// //                                       size: 24.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 30,
// //                                 ),
// //                                 Container(
// //                                   width: 110.0,
// //                                   padding: EdgeInsetsDirectional.only(
// //                                       start: 20, end: 10),
// //                                   decoration:
// //                                       BoxDecoration(color: Colors.white),
// //                                   child: DropdownButton<int>(
// //                                     hint: Obx(
// //                                       () => (selectedBirthDateMonth == null)
// //                                           ? Text(
// //                                               controller_TravellerDetailsview2
// //                                                       .birthdateMonth.value ??
// //                                                   '',
// //                                               style: TextStyle(
// //                                                   color:
// //                                                       (controller_TravellerDetailsView2
// //                                                                   .birthdateMonth
// //                                                                   .value ==
// //                                                               'Month')
// //                                                           ? Colors.grey
// //                                                           : Colors.black),
// //                                             )
// //                                           : Text(selectedBirthDateMonth
// //                                               .toString()),
// //                                     ),
// //                                     value: selectedBirthDateMonth,
// //                                     items: monthListBirthDate.map((int value) {
// //                                       return DropdownMenuItem<int>(
// //                                         value: value,
// //                                         child: Text(value.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (newValue) {
// //                                       setState(() {
// //                                         selectedBirthDateMonth = newValue;
// //                                         isBirthDateMonthSelected = true;
// //                                       });
// //                                     },
// //                                     icon: Icon(
// //                                       Icons.arrow_drop_down,
// //                                       color: Colors.grey,
// //                                       size: 24.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 30,
// //                                 ),
// //                                 Container(
// //                                   width: 110.0,
// //                                   padding: EdgeInsetsDirectional.only(
// //                                       start: 20, end: 10),
// //                                   decoration:
// //                                       BoxDecoration(color: Colors.white),
// //                                   child: DropdownButton<int>(
// //                                     hint: Obx(
// //                                       () => (selectedBirthDateYear == null)
// //                                           ? Text(
// //                                               controller_TravellerDetailsview2
// //                                                       .birthdateYear.value ??
// //                                                   '',
// //                                               style: TextStyle(
// //                                                 color:
// //                                                     (controller_TravellerDetailsView2
// //                                                                 .birthdateYear
// //                                                                 .value ==
// //                                                             'Year')
// //                                                         ? Colors.grey
// //                                                         : Colors.black,
// //                                               ),
// //                                             )
// //                                           : Text(
// //                                               selectedBirthDateDay.toString()),
// //                                     ),
// //                                     value: selectedBirthDateYear,
// //                                     items: yearListBirthDate.map((int value) {
// //                                       return DropdownMenuItem<int>(
// //                                         value: value,
// //                                         child: Text(value.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (newValue) {
// //                                       setState(() {
// //                                         selectedBirthDateYear = newValue;
// //                                         isBirthDateYearSelected = true;
// //                                       });
// //                                     },
// //                                     icon: Icon(
// //                                       Icons.arrow_drop_down,
// //                                       color: Colors.grey,
// //                                       size: 24.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             (errorMessageBirthDate != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       errorMessageBirthDate!,
// //                                       style: TextStyle(
// //                                           fontSize: 11,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(
// //                                     height: 20,
// //                                   ),
// //                             Padding(
// //                               padding: EdgeInsetsDirectional.only(start: 0),
// //                               child: Align(
// //                                 alignment: Alignment.topLeft,
// //                                 child: Text(
// //                                   'Travel document',
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w500,
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(height: 15),
// //                             CustomTextField(
// //                               controller: passportnumber_con,
// //                               validator: (value) {
// //                                 if (value!.isEmpty || value.length < 3) {
// //                                   return 'Please enter your passport number';
// //                                 }
// //                                 return null;
// //                               },
// //                               prefIcon: Icons.person_2,
// //                               colorIcon: AppColors.pinkColor2,
// //                               hintText: 'Passport Number',
// //                               style: TextStyle(),
// //                             ),
// //                             (errorPassport != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       errorPassport!,
// //                                       style: TextStyle(
// //                                           fontSize: 11,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(
// //                                     height: 20,
// //                                   ),
// //                             Container(
// //                               decoration: BoxDecoration(
// //                                   color: Colors.white,
// //                                   borderRadius: BorderRadius.circular(20)),
// //                               padding: EdgeInsetsDirectional.only(
// //                                 start: 12,
// //                                 end: 12,
// //                               ),
// //                               height: (size.height / 16) - 5,
// //                               width: size.width - 40,
// //                               child: DropdownButtonHideUnderline(
// //                                 child: DropdownButton<String>(
// //                                   isExpanded: true,
// //                                   hint: Row(
// //                                     children: [
// //                                       SizedBox(
// //                                         width: 6,
// //                                       ),
// //                                       Icon(
// //                                         Icons.public,
// //                                         size: 22,
// //                                         color: AppColors.Blue,
// //                                       ),
// //                                       SizedBox(
// //                                         width: 12,
// //                                       ),
// //                                       Obx(
// //                                         () => Text(
// //                                           controller_TravellerDetailsView2
// //                                                   .issuingcountry.value ??
// //                                               '',
// //                                           style: TextStyle(
// //                                             color:
// //                                                 (controller_TravellerDetailsView2
// //                                                             .issuingcountry
// //                                                             .value ==
// //                                                         'issuing Country')
// //                                                     ? Colors.grey
// //                                                     : Colors.black,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   items: items_issuingCountry
// //                                       .map((item) => DropdownMenuItem(
// //                                             value: item,
// //                                             child: Text(
// //                                               item,
// //                                               style: const TextStyle(
// //                                                 fontSize: 14,
// //                                               ),
// //                                             ),
// //                                           ))
// //                                       .toList(),
// //                                   value: selectedValueIssuingCountry,
// //                                   onChanged: (value) {
// //                                     setState(() {
// //                                       selectedValueIssuingCountry = value;
// //                                       controller_TravellerDetailsView2
// //                                           .setissuingcountry(value ?? '');
// //                                       isissuingcountrySelected = true;
// //                                     });
// //                                   },
// //                                   icon: Icon(
// //                                     Icons.arrow_drop_down_outlined,
// //                                     color: Colors.grey,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             (errorMessageissuingcountry != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       errorMessageissuingcountry!,
// //                                       style: TextStyle(
// //                                           fontSize: 11,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(
// //                                     height: 20,
// //                                   ),
// //                             SizedBox(
// //                               height: 15,
// //                             ),
// //                             SizedBox(
// //                               width: 50,
// //                             ),
// //                             Text('Expire date',
// //                                 style: TextStyle(color: Colors.grey)),
// //                             SizedBox(
// //                               height: 4,
// //                             ),
// //                             Row(
// //                               children: <Widget>[
// //                                 Container(
// //                                   width: 90.0,
// //                                   padding: EdgeInsetsDirectional.only(
// //                                       start: 20, end: 10),
// //                                   decoration:
// //                                       BoxDecoration(color: Colors.white),
// //                                   child: DropdownButton<int>(
// //                                     hint: Obx(
// //                                       () => (selectedExpireDateDay == null)
// //                                           ? Text(
// //                                               controller_TravellerDetailsview2
// //                                                       .expiredateDay.value ??
// //                                                   '',
// //                                               style: TextStyle(
// //                                                 color:
// //                                                     (controller_TravellerDetailsView2
// //                                                                 .expiredateDay
// //                                                                 .value ==
// //                                                             'Day')
// //                                                         ? Colors.grey
// //                                                         : Colors.black,
// //                                               ),
// //                                             )
// //                                           : Text(
// //                                               selectedExpireDateDay.toString()),
// //                                     ),
// //                                     value: selectedExpireDateDay,
// //                                     items: daysListExpireDate.map((int value) {
// //                                       return DropdownMenuItem<int>(
// //                                         value: value,
// //                                         child: Text(value.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (newValue) {
// //                                       setState(() {
// //                                         selectedExpireDateDay = newValue;
// //                                         isExpireDaySelected = true;
// //                                       });
// //                                     },
// //                                     icon: Icon(
// //                                       Icons.arrow_drop_down,
// //                                       color: Colors.grey,
// //                                       size: 24.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 30,
// //                                 ),
// //                                 Container(
// //                                   width: 110.0,
// //                                   padding: EdgeInsetsDirectional.only(
// //                                       start: 20, end: 10),
// //                                   decoration:
// //                                       BoxDecoration(color: Colors.white),
// //                                   child: DropdownButton<int>(
// //                                     hint: Obx(
// //                                       () => (selectedExpireDateMonth == null)
// //                                           ? Text(
// //                                               controller_TravellerDetailsview2
// //                                                       .expiredateMonth.value ??
// //                                                   '',
// //                                               style: TextStyle(
// //                                                   color:
// //                                                       (controller_TravellerDetailsView2
// //                                                                   .expiredateMonth
// //                                                                   .value ==
// //                                                               'Month')
// //                                                           ? Colors.grey
// //                                                           : Colors.black),
// //                                             )
// //                                           : Text(selectedExpireDateMonth
// //                                               .toString()),
// //                                     ),
// //                                     value: selectedExpireDateMonth,
// //                                     items: monthListExpireDate.map((int value) {
// //                                       return DropdownMenuItem<int>(
// //                                         value: value,
// //                                         child: Text(value.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (newValue) {
// //                                       setState(() {
// //                                         selectedExpireDateMonth = newValue;
// //                                         isExpireDateMonthSelected = true;
// //                                       });
// //                                     },
// //                                     icon: Icon(
// //                                       Icons.arrow_drop_down,
// //                                       color: Colors.grey,
// //                                       size: 24.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(
// //                                   width: 30,
// //                                 ),
// //                                 Container(
// //                                   width: 110.0,
// //                                   padding: EdgeInsetsDirectional.only(
// //                                       start: 20, end: 10),
// //                                   decoration:
// //                                       BoxDecoration(color: Colors.white),
// //                                   child: DropdownButton<int>(
// //                                     hint: Obx(
// //                                       () => (selectedExpireDateYear == null)
// //                                           ? Text(
// //                                               controller_TravellerDetailsview2
// //                                                       .expiredateYear.value ??
// //                                                   '',
// //                                               style: TextStyle(
// //                                                 color:
// //                                                     (controller_TravellerDetailsView2
// //                                                                 .expiredateYear
// //                                                                 .value ==
// //                                                             'Year')
// //                                                         ? Colors.grey
// //                                                         : Colors.black,
// //                                               ),
// //                                             )
// //                                           : Text(selectedExpireDateYear
// //                                               .toString()),
// //                                     ),
// //                                     value: selectedExpireDateYear,
// //                                     items: yearListExpireDate.map((int value) {
// //                                       return DropdownMenuItem<int>(
// //                                         value: value,
// //                                         child: Text(value.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (newValue) {
// //                                       setState(() {
// //                                         selectedExpireDateYear = newValue;
// //                                         isExpireDateYearSelected = true;
// //                                       });
// //                                     },
// //                                     icon: Icon(
// //                                       Icons.arrow_drop_down,
// //                                       color: Colors.grey,
// //                                       size: 24.0,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             (errorMessageExpireDate != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       errorMessageExpireDate!,
// //                                       style: TextStyle(
// //                                           fontSize: 11,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(),
// //                             (generalErrorMessage != null)
// //                                 ? Padding(
// //                                     padding: EdgeInsetsDirectional.only(
// //                                         start: 6, top: 10),
// //                                     child: Text(
// //                                       generalErrorMessage!,
// //                                       style: TextStyle(
// //                                           fontSize: 14,
// //                                           color:
// //                                               Color.fromARGB(255, 215, 16, 2)),
// //                                     ),
// //                                   )
// //                                 : SizedBox(
// //                                     height: 10,
// //                                   ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Row(
// //                               children: [
// //                                 SizedBox(width: 10),
// //                                 InkWell(
// //                                     onTap: _confirm,
// //                                     child: Container(
// //                                       width: 115,
// //                                       height: 40,
// //                                       decoration: BoxDecoration(
// //                                         color: AppColors.mainColorBlue,
// //                                       ),
// //                                       child: Center(
// //                                         child: Text(
// //                                           'Set as traveller',
// //                                           style: TextStyle(
// //                                               color: Colors.white,
// //                                               fontWeight: FontWeight.bold,
// //                                               fontSize: screenWidth(28)),
// //                                         ),
// //                                       ),
// //                                     )),
// //                                 SizedBox(width: 10),
// //                                 InkWell(
// //                                     onTap: () {
// //                                       Get.back();
// //                                     },
// //                                     child: Container(
// //                                       width: 115,
// //                                       height: 40,
// //                                       decoration: BoxDecoration(),
// //                                       child: Center(
// //                                         child: Text(
// //                                           'Cancel',
// //                                           style: TextStyle(
// //                                               color: Colors.grey,
// //                                               fontWeight: FontWeight.bold,
// //                                               fontSize: screenWidth(28)),
// //                                         ),
// //                                       ),
// //                                     )),
// //                                 SizedBox(width: 10),
// //                               ],
// //                             ),
// //                             SizedBox(height: 10),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<Gender?> showGenderOptions() async {
// //     selectedOption = selectedgender;

// //     selectedgender = await showModalBottomSheet<Gender>(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (BuildContext context) {
// //         return StatefulBuilder(
// //           builder: (BuildContext context, StateSetter setState) {
// //             return Container(
// //               height: MediaQuery.of(context).size.height * 0.3 + 80,
// //               child: DraggableScrollableSheet(
// //                 initialChildSize: 0.5,
// //                 minChildSize: 0.2,
// //                 maxChildSize: 0.8,
// //                 builder: (_, controller) {
// //                   return Container(
// //                     height: MediaQuery.of(context).size.height *
// //                         0.2, // This is 50% of the screen height
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(25),
// //                         topRight: Radius.circular(25),
// //                       ),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         SizedBox(height: 8),
// //                         Center(
// //                           child: Container(
// //                             width: 40,
// //                             height: 5,
// //                             decoration: BoxDecoration(
// //                               color: Colors.grey[300],
// //                               borderRadius: BorderRadius.all(
// //                                 Radius.circular(2.5),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Row(
// //                           children: [
// //                             SizedBox(
// //                               width: 15,
// //                             ),
// //                             const Text(
// //                               'Gender',
// //                               style: TextStyle(
// //                                   fontWeight: FontWeight.w500, fontSize: 18),
// //                             ),
// //                             SizedBox(
// //                               height: 15,
// //                             ),
// //                           ],
// //                         ),
// //                         ListTile(
// //                           key: UniqueKey(),
// //                           title: Text('Male'),
// //                           leading: Radio<Gender>(
// //                             value: Gender.Male,
// //                             groupValue: selectedOption,
// //                             onChanged: (Gender? value) {
// //                               setState(() {
// //                                 selectedOption = value;
// //                                 controller_TravellerDetailsView2.setgender('M');
// //                                 isGenderSelected = true;
// //                               });
// //                               Navigator.pop(context, selectedOption);
// //                             },
// //                           ),
// //                         ),
// //                         ListTile(
// //                           title: Text('Famale'),
// //                           leading: Radio<Gender>(
// //                             value: Gender.Famle,
// //                             groupValue: selectedOption,
// //                             onChanged: (Gender? value) {
// //                               setState(() {
// //                                 selectedOption = value;
// //                                 controller_TravellerDetailsView2.setgender('F');
// //                                 isGenderSelected = true;
// //                               });
// //                               Navigator.pop(context, selectedOption);
// //                             },
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           height: 20,
// //                         ),
// //                         InkWell(
// //                           onTap: () async {
// //                             TravellerData = await Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => ScanId(
// //                                     firstname_con: firstname_con,
// //                                     lastname_con: lastname_con,
// //                                     dateofbirth_con: dateofbirth_con,
// //                                     passportnumber_con: passportnumber_con,
// //                                     issuingcountry_con: issuingcountry_con,
// //                                     expiredate_con: expiredate_con,
// //                                     nationality_con: nationality_con,
// //                                     gender: TravellerData?.gender),
// //                               ),
// //                             );
// //                           },
// //                           child: SizedBox(
// //                             child: Text('fggg'),
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_key_in_widget_constructors, use_build_context_synchronously, library_private_types_in_public_api, unnecessary_null_comparison, sized_box_for_whitespace, body_might_complete_normally_nullable, curly_braces_in_flow_control_structures, prefer_is_empty, prefer_conditional_assignment

// import 'package:flutter/material.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:traveling/controllers/flight_info_controller.dart';
// import 'package:traveling/controllers/traveller_details_view1_controller.dart';
// import 'package:traveling/controllers/traveller_details_view2_controller.dart';
// import 'package:traveling/ui/shared/colors.dart';
// import 'package:traveling/ui/shared/custom_widgets/custom_textfiled.dart';
// import 'package:traveling/ui/shared/text_size.dart';
// import 'package:traveling/ui/shared/utils.dart';
// import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/scan_traveller_id/traveller_scan_id_view.dart';
// import 'scan_traveller_id/global.dart';

// class TravellerDetaisView2 extends StatefulWidget {
//   MrzResult? change_data;
//   final TextEditingController? firstname_con;
//   final TextEditingController? lastname_con;
//   final TextEditingController? nationality_con;
//   final TextEditingController? dateofbirth_con;
//   final TextEditingController? passportnumber_con;
//   final TextEditingController? issuingcountry_con;
//   final TextEditingController? expiredate_con;
//   final TextEditingController? gender;

//   TravellerDetailsView2(
//       {this.change_data,
//       this.firstname_con,
//       this.lastname_con,
//       this.nationality_con,
//       this.dateofbirth_con,
//       this.passportnumber_con,
//       this.issuingcountry_con,
//       this.expiredate_con,
//       this.gender});

//   @override
//   _TravellerDetailsView2State createState() => _TravellerDetailsView2State();
// }

// class _TravellerDetailsView2State extends State<TravellerDetailsView2> {
//   final firstname_con = TextEditingController();
//   final lastname_con = TextEditingController();
//   final nationality_con = TextEditingController();
//   final dateofbirth_con = TextEditingController();
//   final passportnumber_con = TextEditingController();
//   final issuingcountry_con = TextEditingController();
//   final expiredate_con = TextEditingController();
//   final controller_TravellerDetailsView2 =
//       Get.put(TravellerDetailsView2Controller());
//   TravellerDetailsView2Controller controller_TravellerDetailsview2 =
//       Get.find<TravellerDetailsView2Controller>();
//   TravellerDetailsView1Controller controller_TravellerDetailsview1 =
//       Get.find<TravellerDetailsView1Controller>();
//   final FlightInfoController flightInfoController =
//       Get.put(FlightInfoController());
//   bool isNationalitySelected = false;
//   bool isGenderSelected = false;
//   bool isBirthDateSelected = false;
//   bool isBirthDateDaySelected = false;
//   bool isBirthDateMonthSelected = false;
//   bool isBirthDateYearSelected = false;
//   bool isExpireDaySelected = false;
//   bool isExpireDateMonthSelected = false;
//   bool isExpireDateYearSelected = false;
//   bool isissuingcountrySelected = false;
//   String? errorMessageNationality = '';
//   String? errorMessageGender = '';
//   String? errorMessageBirthDate = '';
//   String? errorMessageExpireDate = '';
//   String? errorMessageissuingcountry = '';
//   String? errorFirstName = '';
//   String? errorLastName = '';
//   String? errorPassport = '';
//   String? generalErrorMessage = '';

//   var selectedgender;
//   MrzResult? TravellerData;
//   Gender? selectedOption;
//   String? selectedValueIssuingCountry;
//   String? selectedValueNationality;
//   final List<String> items_Nationality = ['Syrian - SYR', 'Algeria - DZA'];
//   final List<String> items_issuingCountry = ['SYR - Syrian', 'DZA - Algeria'];
//   final List<String> genderItems = [
//     'Male',
//     'Female',
//   ];

//   DateTime now = DateTime.now();
//   late List<int> daysListBirthDate;
//   late List<int> monthListBirthDate;
//   late List<int> yearListBirthDate;
//   late List<int> daysListExpireDate;
//   late List<int> monthListExpireDate;
//   late List<int> yearListExpireDate;

//   int? selectedBirthDateDay;
//   int? selectedBirthDateMonth;
//   int? selectedBirthDateYear;
//   int? selectedExpireDateDay;
//   int? selectedExpireDateMonth;
//   int? selectedExpireDateYear;
//   Future<int> loadData() async {
//     return await initMRZSDK();
//   }

//   @override
//   void initState() {
//     super.initState();

//     daysListBirthDate = List<int>.generate(31, (i) => i + 1);
//     monthListBirthDate = List<int>.generate(12, (i) => i + 1);
//     yearListBirthDate = List<int>.generate(2006 - 1940 + 1, (i) => i + 1940);
//     daysListExpireDate = List<int>.generate(31, (i) => i + 1);
//     monthListExpireDate = List<int>.generate(12, (i) => i + 1);
//     yearListExpireDate = List<int>.generate(2055 - 2024 + 1, (i) => i + 2024);

//     if (TravellerData == null && widget.change_data == null) {
//       setState(() {
//         controller_TravellerDetailsView2.setgender('gender');
//         controller_TravellerDetailsview2.setNationality('Nationality');
//         controller_TravellerDetailsview2.setbirthdateDay('Day');
//         controller_TravellerDetailsview2.setbirthdateMonth('Month');
//         controller_TravellerDetailsview2.setbirthdateYear('Year');
//         controller_TravellerDetailsview2.setexpiredateDay('Day');
//         controller_TravellerDetailsview2.setexpiredateMonth('Month');
//         controller_TravellerDetailsview2.setexpiredateYear('Year');
//         controller_TravellerDetailsview2.setissuingcountry('issuing Country');
//       });
//     } else if (widget.change_data != null) {
//       setState(() {
//         firstname_con.text = widget.change_data!.givenName!;
//         lastname_con.text = widget.change_data!.surname!;
//         passportnumber_con.text = widget.change_data!.passportNumber!;
//         issuingcountry_con.text = widget.change_data!.issuingCountry!;
//         controller_TravellerDetailsView2
//             .setgender(widget.change_data?.gender ?? '');
//         controller_TravellerDetailsView2
//             .setNationality(widget.change_data?.nationality ?? '');
//         controller_TravellerDetailsview2
//             .setissuingcountry(widget.change_data?.issuingCountry ?? '');
//         String? birthDate = widget.change_data?.birthDate;
//         String? expiration = widget.change_data?.expiration;
//         List<String> BirthDate = birthDate!.split('/');
//         List<String> expirationDate = expiration!.split('/');
//         int yearBirthDate = int.parse(BirthDate[0]);
//         int monthBirthDate = int.parse(BirthDate[1]);
//         int dayBirthDate = int.parse(BirthDate[2]);
//         int yearExpirationDate = int.parse(expirationDate[0]);
//         int monthExpirationDate = int.parse(expirationDate[1]);
//         int dayExpirationDate = int.parse(expirationDate[2]);
//         controller_TravellerDetailsview2
//             .setbirthdateDay(dayBirthDate.toString());
//         controller_TravellerDetailsview2
//             .setbirthdateMonth(monthBirthDate.toString());
//         controller_TravellerDetailsview2
//             .setbirthdateYear(yearBirthDate.toString());
//         controller_TravellerDetailsview2
//             .setexpiredateDay(dayExpirationDate.toString());
//         controller_TravellerDetailsview2
//             .setexpiredateMonth(monthExpirationDate.toString());
//         controller_TravellerDetailsview2
//             .setexpiredateYear(yearExpirationDate.toString());
//         isBirthDateSelected = true;
//         isNationalitySelected = true;
//         isGenderSelected = true;
//         isBirthDateDaySelected = true;
//         isBirthDateMonthSelected = true;
//         isBirthDateYearSelected = true;
//         isExpireDaySelected = true;
//         isExpireDateMonthSelected = true;
//         isExpireDateYearSelected = true;
//         isissuingcountrySelected = true;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _confirm() async {
//     setState(() {
//       if (firstname_con.text.isEmpty &&
//           lastname_con.text.isEmpty &&
//           passportnumber_con.text.isEmpty &&
//           !isBirthDateDaySelected &&
//           !isBirthDateMonthSelected &&
//           !isBirthDateYearSelected &&
//           !isExpireDateMonthSelected &&
//           !isExpireDateYearSelected &&
//           !isExpireDaySelected &&
//           !isGenderSelected &&
//           !isNationalitySelected &&
//           !isissuingcountrySelected) {
//         generalErrorMessage = 'Please enter all fields';
//       } else {
//         errorFirstName = (firstname_con.text.length < 2)
//             ? 'Please Enter a First name more than two characters'
//             : null;
//         errorLastName = (lastname_con.text.length < 2)
//             ? 'Please Enter a last name more than two characters'
//             : null;
//         errorPassport = (passportnumber_con.text.length == 0)
//             ? 'Please Enter a valid Passport number'
//             : null;
//         errorMessageNationality =
//             isNationalitySelected ? null : 'Please choose your Nationality';
//         errorMessageissuingcountry =
//             isissuingcountrySelected ? null : 'Please choose issuing country';
//         errorMessageGender =
//             isGenderSelected ? null : 'Please choose your Gender';
//         errorMessageExpireDate = (isExpireDaySelected &&
//                 isExpireDateMonthSelected &&
//                 isExpireDateYearSelected)
//             ? null
//             : 'Please choose your Expire date';
//         errorMessageBirthDate = (isBirthDateDaySelected &&
//                 isBirthDateMonthSelected &&
//                 isBirthDateYearSelected)
//             ? null
//             : 'Please choose your Birth date';
//       }
//     });
//     if (isBirthDateDaySelected &&
//         isBirthDateMonthSelected &&
//         isBirthDateYearSelected &&
//         isExpireDateMonthSelected &&
//         isExpireDateYearSelected &&
//         isExpireDaySelected &&
//         isGenderSelected &&
//         isNationalitySelected &&
//         isissuingcountrySelected) {
//       setState(() {
//         if (TravellerData == null) {
//           TravellerData = MrzResult();
//         }
//         TravellerData?.givenName = firstname_con.text;
//         TravellerData?.surname = lastname_con.text;
//         TravellerData?.gender = controller_TravellerDetailsView2.gender.value;
//         TravellerData?.passportNumber = passportnumber_con.text;
//         TravellerData?.birthDate =
//             '${selectedBirthDateYear ?? controller_TravellerDetailsview2.birthdateYear.value}/${selectedBirthDateMonth ?? controller_TravellerDetailsview2.birthdateMonth.value}/${selectedBirthDateDay ?? controller_TravellerDetailsview2.birthdateDay.value}';
//         TravellerData?.nationality =
//             controller_TravellerDetailsview2.Nationality.value;
//         TravellerData?.expiration =
//             '${(selectedExpireDateYear != null) ? selectedExpireDateYear.toString() : controller_TravellerDetailsview2.expiredateYear.value}/${(selectedExpireDateMonth != null) ? selectedExpireDateMonth.toString() : controller_TravellerDetailsview2.expiredateMonth.value}/${(selectedExpireDateDay != null) ? selectedExpireDateDay.toString() : controller_TravellerDetailsview2.expiredateDay.value}';
//         TravellerData?.issuingCountry =
//             controller_TravellerDetailsview2.issuingcountry.value;

//         if (controller_TravellerDetailsview1.AdultList.isEmpty) {
//           Navigator.pop(context, TravellerData);
//         } else if (controller_TravellerDetailsview1.AdultList.isNotEmpty &&
//             controller_TravellerDetailsview1.ChildList.isEmpty) {
//           if (widget.change_data != null) {
//             bool isTravellerAdded =
//                 controller_TravellerDetailsview1.AdultList.any((element) =>
//                     element.passportNumber == passportnumber_con.text &&
//                     widget.change_data?.passportNumber !=
//                         passportnumber_con.text);

//             if (!isTravellerAdded) {
//               setState(() {
//                 widget.change_data?.givenName = firstname_con.text;
//                 widget.change_data?.surname = lastname_con.text;
//                 widget.change_data?.gender =
//                     controller_TravellerDetailsview2.gender.value;
//                 widget.change_data?.nationality =
//                     controller_TravellerDetailsview2.Nationality.value;
//                 widget.change_data?.passportNumber = passportnumber_con.text;
//                 widget.change_data?.issuingCountry =
//                     controller_TravellerDetailsview2.issuingcountry.value;
//                 widget.change_data?.birthDate =
//                     '${selectedBirthDateYear ?? controller_TravellerDetailsview2.birthdateYear.value}/${selectedBirthDateMonth ?? controller_TravellerDetailsview2.birthdateMonth.value}/${selectedBirthDateDay ?? controller_TravellerDetailsview2.birthdateDay.value}';
//                 widget.change_data?.expiration =
//                     '${(selectedExpireDateYear != null) ? selectedExpireDateYear.toString() : controller_TravellerDetailsview2.expiredateYear.value}/${(selectedExpireDateMonth != null) ? selectedExpireDateMonth.toString() : controller_TravellerDetailsview2.expiredateMonth.value}/${(selectedExpireDateDay != null) ? selectedExpireDateDay.toString() : controller_TravellerDetailsview2.expiredateDay.value}';
//                 Navigator.pop(context, widget.change_data);
//               });
//             } else {
//               Fluttertoast.showToast(
//                   msg: 'The traveler is already aded',
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: Colors.grey,
//                   textColor: Colors.white,
//                   fontSize: 16.0);
//             }
//           } else {
//             bool isTravellerAdded = false;
//             for (var AdultTraveller
//                 in controller_TravellerDetailsview1.AdultList) {
//               for (var ChildTraveller
//                   in controller_TravellerDetailsview1.ChildList) {
//                 if (AdultTraveller.passportNumber ==
//                     ChildTraveller.passportNumber) {
//                   isTravellerAdded = true;
//                 }
//                 if (ChildTraveller.passportNumber == passportnumber_con.text) {
//                   isTravellerAdded = true;
//                 }
//                 if (AdultTraveller.passportNumber == passportnumber_con.text) {
//                   isTravellerAdded = true;
//                 }
//               }
//             }
//             if (isTravellerAdded == true) {
//               Fluttertoast.showToast(
//                   msg: 'The traveler is already added',
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: Colors.grey,
//                   textColor: Colors.white,
//                   fontSize: 16.0);
//             } else {
//               Navigator.pop(context, TravellerData);
//             }
//           }
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.Blue,
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 15, right: 15, top: 35),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Flight Details',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.backgroundgrayColor),
//                 ),
//                 SizedBox(),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 70,
//             ),
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('assets/image/png/background1.png'),
//                     fit: BoxFit.fill),
//               ),
//             ),
//           ),
//           Column(
//             children: <Widget>[
//               SizedBox(height: 80),
//               InkWell(
//                 onTap: () async {
//                   int data = await loadData();
//                   if (data != null) {
//                     TravellerData = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ScanId(
//                             firstname_con: firstname_con,
//                             lastname_con: lastname_con,
//                             dateofbirth_con: dateofbirth_con,
//                             passportnumber_con: passportnumber_con,
//                             issuingcountry_con: issuingcountry_con,
//                             expiredate_con: expiredate_con,
//                             nationality_con: nationality_con,
//                             gender: TravellerData?.gender),
//                       ),
//                     );
//                     if (TravellerData != null) {
//                       setState(() {
//                         controller_TravellerDetailsview2
//                             .setgender(TravellerData?.gender ?? '');
//                         controller_TravellerDetailsview2.setissuingcountry(
//                             TravellerData?.issuingCountry ?? '');
//                         controller_TravellerDetailsView2
//                             .setNationality(TravellerData?.nationality ?? '');
//                         controller_TravellerDetailsview2.setbirthdateDay(
//                             controller_TravellerDetailsview2
//                                 .getFormattedDateDay(
//                                     TravellerData?.birthDate ?? ''));
//                         controller_TravellerDetailsview2.setbirthdateMonth(
//                             controller_TravellerDetailsview2
//                                 .getFormattedDateMonth(
//                                     TravellerData?.birthDate ?? ''));
//                         controller_TravellerDetailsview2.setbirthdateYear(
//                             controller_TravellerDetailsview2
//                                 .getFormattedDateYear(
//                                     TravellerData?.birthDate ?? ''));
//                         controller_TravellerDetailsview2.setexpiredateDay(
//                             controller_TravellerDetailsview2
//                                 .getFormattedDateDay(
//                                     TravellerData?.expiration ?? ''));
//                         controller_TravellerDetailsview2.setexpiredateMonth(
//                             controller_TravellerDetailsview2
//                                 .getFormattedDateMonth(
//                                     TravellerData?.expiration ?? ''));
//                         controller_TravellerDetailsview2.setexpiredateYear(
//                             controller_TravellerDetailsview2
//                                 .getFormattedDateYear(
//                                     TravellerData?.expiration ?? ''));
//                       });
//                     }
//                     if (TravellerData == null) {
//                       if (widget.change_data != null) {
//                         setState(() {
//                           controller_TravellerDetailsview2.gender.value =
//                               widget.change_data?.gender;
//                           controller_TravellerDetailsview2.Nationality.value =
//                               widget.change_data?.nationality;
//                           controller_TravellerDetailsview2.issuingcountry
//                               .value = widget.change_data?.issuingCountry;
//                           controller_TravellerDetailsview2.birthdateDay.value =
//                               (widget.change_data?.birthDate != null)
//                                   ? controller_TravellerDetailsview2
//                                       .getFormattedDateDay(
//                                           widget.change_data?.birthDate ?? '')
//                                   : controller_TravellerDetailsview2
//                                       .birthdateDay.value;
//                           controller_TravellerDetailsview2
//                                   .birthdateMonth.value =
//                               (widget.change_data?.birthDate != null)
//                                   ? controller_TravellerDetailsview2
//                                       .getFormattedDateMonth(
//                                           widget.change_data?.birthDate ?? '')
//                                   : controller_TravellerDetailsview2
//                                       .birthdateMonth.value;

//                           controller_TravellerDetailsview2.birthdateYear.value =
//                               (widget.change_data?.birthDate != null)
//                                   ? controller_TravellerDetailsview2
//                                       .getFormattedDateYear(
//                                           widget.change_data?.birthDate ?? '')
//                                   : controller_TravellerDetailsview2
//                                       .birthdateYear.value;

//                           controller_TravellerDetailsview2.expiredateDay.value =
//                               (widget.change_data?.expiration != null)
//                                   ? controller_TravellerDetailsview2
//                                       .getFormattedDateDay(
//                                           widget.change_data?.expiration ?? '')
//                                   : controller_TravellerDetailsview2
//                                       .expiredateDay.value;

//                           controller_TravellerDetailsview2
//                                   .expiredateMonth.value =
//                               (widget.change_data?.expiration != null)
//                                   ? controller_TravellerDetailsview2
//                                       .getFormattedDateMonth(
//                                           widget.change_data?.expiration ?? '')
//                                   : controller_TravellerDetailsview2
//                                       .expiredateMonth.value;
//                           controller_TravellerDetailsview2
//                                   .expiredateYear.value =
//                               (widget.change_data?.expiration != null)
//                                   ? controller_TravellerDetailsview2
//                                       .getFormattedDateYear(
//                                           widget.change_data?.expiration ?? '')
//                                   : controller_TravellerDetailsview2
//                                       .expiredateYear.value;
//                         });
//                       }
//                     }
//                     if (TravellerData != null)
//                       setState(() {
//                         isBirthDateSelected = true;
//                         isNationalitySelected = true;
//                         isGenderSelected = true;
//                         isBirthDateDaySelected = true;
//                         isBirthDateMonthSelected = true;
//                         isBirthDateYearSelected = true;
//                         isExpireDaySelected = true;
//                         isExpireDateMonthSelected = true;
//                         isExpireDateYearSelected = true;
//                         isissuingcountrySelected = true;
//                       });
//                     if (widget.change_data != null) {
//                       setState(() {
//                         widget.change_data?.birthDate =
//                             TravellerData?.birthDate;
//                         widget.change_data?.expiration =
//                             TravellerData?.expiration;
//                       });
//                     }
//                   }
//                 },
//                 child: Expanded(
//                   child: ListView(
//                     scrollDirection: Axis.vertical,
//                     children: [
//                       Container(
//                         child: Column(
//                           children: [
//                             Container(
//                               width: size.width,
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: AppColors.babyblueColor,
//                                 borderRadius:
//                                     BorderRadiusDirectional.circular(25),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Use your passport or GCC National ID to quickly and securely auto-fill traveller details',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       color: Color.fromRGBO(96, 96, 96, 1),
//                                       fontSize: TextSize.header1,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   SizedBox(height: 10),
//                                   GestureDetector(
//                                     child: Container(
//                                       width: screenWidth(1.3),
//                                       height: screenWidth(10),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.backgroundgrayColor,
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsetsDirectional.all(10),
//                                         child: Center(
//                                           child: Text(
//                                             'Scan ID to add travellar',
//                                             style: TextStyle(
//                                               color: AppColors.mainColorBlue,
//                                               fontSize: screenWidth(25),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Row(
//                               children: [
//                                 Text(
//                                   'First Name',
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       color: AppColors.grayText,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               height: 40,
//                               child: CustomTextField(
//                                 controller: firstname_con,
//                                 validator: (value) {
//                                   if (value!.isEmpty || value.length < 3) {
//                                     return 'Please enter your first name';
//                                   }
//                                   return null;
//                                 },
//                                 prefIcon: Icons.person_2,
//                                 colorIcon: AppColors.Blue,
//                                 style: TextStyle(),
//                               ),
//                             ),
//                             (errorFirstName != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       errorFirstName!,
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 20,
//                                   ),
//                             const Row(
//                               children: [
//                                 Text(
//                                   'Last Name',
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       color: AppColors.grayText,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                             // CustomTextField(

//                             //   controller: lastname_con,
//                             //   validator: (value) {
//                             //     if (value!.isEmpty || value.length < 3) {
//                             //       return 'Please enter your last name';
//                             //     }
//                             //     return null;
//                             //   },
//                             //   prefIcon: Icons.person_2,
//                             //   colorIcon: AppColors.Blue,
//                             //   hintText: 'Last Name',
//                             //   hintTextColor: Colors.grey,
//                             // ),
//                             // (errorLastName != null)
//                             //     ? Padding(
//                             //         padding: EdgeInsetsDirectional.only(
//                             //             start: 6, top: 10),
//                             //         child: Text(
//                             //           errorLastName!,
//                             //           style: TextStyle(
//                             //               fontSize: 11,
//                             //               color:
//                             //                   Color.fromARGB(255, 215, 16, 2)),
//                             //         ),
//                             //       )
//                             //     : SizedBox(
//                             //         height: 20,
//                             //       ),
//                             // InkWell(
//                             //   onTap: () {
//                             //     showGenderOptions();
//                             //   },
//                             //   child: Container(
//                             //     padding: EdgeInsetsDirectional.only(
//                             //         start: 15, end: 15),
//                             //     height: (size.height / 16) - 5,
//                             //     width: size.width - 40,
//                             //     decoration: BoxDecoration(
//                             //       color: Colors.white,
//                             //       borderRadius: BorderRadius.circular(20),
//                             //     ),
//                             //     child: Row(
//                             //       mainAxisAlignment: MainAxisAlignment.start,
//                             //       children: [
//                             //         Icon(Icons.person, color: AppColors.Blue),
//                             //         SizedBox(width: 10),
//                             //         Obx(
//                             //           () => Text(
//                             //             controller_TravellerDetailsView2
//                             //                     .gender.value ??
//                             //                 '',
//                             //             style: TextStyle(
//                             //               color:
//                             //                   (controller_TravellerDetailsView2
//                             //                               .gender.value ==
//                             //                           'gender')
//                             //                       ? Colors.grey
//                             //                       : Colors.black,
//                             //             ),
//                             //           ),
//                             //         ),
//                             //         Spacer(),
//                             //         Icon(Icons.circle_outlined,
//                             //             size: 12, color: AppColors.grayText),
//                             //       ],
//                             //     ),
//                             //   ),
//                             // ),
//                             // (errorMessageGender != null)
//                             //     ? Padding(
//                             //         padding: EdgeInsetsDirectional.only(
//                             //             start: 6, top: 10),
//                             //         child: Text(
//                             //           errorMessageGender!,
//                             //           style: TextStyle(
//                             //               fontSize: 11,
//                             //               color:
//                             //                   Color.fromARGB(255, 215, 16, 2)),
//                             //         ),
//                             //       )
//                             //     : SizedBox(
//                             //         height: 20,
//                             //       ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               padding: EdgeInsetsDirectional.only(
//                                 start: 12,
//                                 end: 12,
//                               ),
//                               height: (size.height / 16) - 5,
//                               width: size.width - 40,
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton<String?>(
//                                   isExpanded: true,
//                                   hint: Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 6,
//                                       ),
//                                       Icon(
//                                         Icons.public,
//                                         size: 22,
//                                         color: AppColors.Blue,
//                                       ),
//                                       SizedBox(
//                                         width: 12,
//                                       ),
//                                       Obx(
//                                         () => Text(
//                                           controller_TravellerDetailsview2
//                                                   .Nationality.value ??
//                                               'Nationality',
//                                           style: TextStyle(
//                                             color:
//                                                 (controller_TravellerDetailsView2
//                                                             .Nationality
//                                                             .value ==
//                                                         'Nationality')
//                                                     ? Colors.grey
//                                                     : Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   items: items_Nationality
//                                       .map((item) => DropdownMenuItem<String?>(
//                                           value: (item),
//                                           child: Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.public,
//                                                 size: 22,
//                                                 color: AppColors.Blue,
//                                               ),
//                                               SizedBox(
//                                                 width: 12,
//                                               ),
//                                               Text(
//                                                 item,
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                             ],
//                                           )))
//                                       .toList(),
//                                   value: selectedValueNationality,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedValueNationality = value;
//                                       controller_TravellerDetailsView2
//                                           .setNationality(value ?? '');
//                                       isNationalitySelected = true;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     Icons.arrow_drop_down_outlined,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             (errorMessageNationality != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       errorMessageNationality!,
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 20,
//                                   ),
//                             CustomTextField(
//                               controller: dateofbirth_con,
//                               prefIcon: Icons.calendar_today,
//                               colorIcon: AppColors.IconPurpleColor,
//                               hintText: 'Date of Birth',
//                               hintTextColor: Colors.grey,
//                             ),
//                             SizedBox(
//                               height: 6,
//                             ),
//                             Text('Birth date',
//                                 style: TextStyle(color: Colors.grey)),
//                             SizedBox(
//                               height: 4,
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Container(
//                                   width: 90.0,
//                                   padding: EdgeInsetsDirectional.only(
//                                       start: 20, end: 10),
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   child: DropdownButton<int>(
//                                     hint: Obx(
//                                       () => (selectedBirthDateDay == null)
//                                           ? Text(
//                                               controller_TravellerDetailsview2
//                                                       .birthdateDay.value ??
//                                                   '',
//                                               style: TextStyle(
//                                                 color:
//                                                     (controller_TravellerDetailsView2
//                                                                 .birthdateDay
//                                                                 .value ==
//                                                             'Day')
//                                                         ? Colors.grey
//                                                         : Colors.black,
//                                               ),
//                                             )
//                                           : Text(
//                                               selectedBirthDateDay.toString()),
//                                     ),
//                                     value: selectedBirthDateDay,
//                                     items: daysListBirthDate.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text(value.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedBirthDateDay = newValue;
//                                         isBirthDateDaySelected = true;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.grey,
//                                       size: 24.0,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 30,
//                                 ),
//                                 Container(
//                                   width: 110.0,
//                                   padding: EdgeInsetsDirectional.only(
//                                       start: 20, end: 10),
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   child: DropdownButton<int>(
//                                     hint: Obx(
//                                       () => (selectedBirthDateMonth == null)
//                                           ? Text(
//                                               controller_TravellerDetailsview2
//                                                       .birthdateMonth.value ??
//                                                   '',
//                                               style: TextStyle(
//                                                   color:
//                                                       (controller_TravellerDetailsView2
//                                                                   .birthdateMonth
//                                                                   .value ==
//                                                               'Month')
//                                                           ? Colors.grey
//                                                           : Colors.black),
//                                             )
//                                           : Text(selectedBirthDateMonth
//                                               .toString()),
//                                     ),
//                                     value: selectedBirthDateMonth,
//                                     items: monthListBirthDate.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text(value.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedBirthDateMonth = newValue;
//                                         isBirthDateMonthSelected = true;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.grey,
//                                       size: 24.0,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 30,
//                                 ),
//                                 Container(
//                                   width: 110.0,
//                                   padding: EdgeInsetsDirectional.only(
//                                       start: 20, end: 10),
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   child: DropdownButton<int>(
//                                     hint: Obx(
//                                       () => (selectedBirthDateYear == null)
//                                           ? Text(
//                                               controller_TravellerDetailsview2
//                                                       .birthdateYear.value ??
//                                                   '',
//                                               style: TextStyle(
//                                                 color:
//                                                     (controller_TravellerDetailsView2
//                                                                 .birthdateYear
//                                                                 .value ==
//                                                             'Year')
//                                                         ? Colors.grey
//                                                         : Colors.black,
//                                               ),
//                                             )
//                                           : Text(
//                                               selectedBirthDateDay.toString()),
//                                     ),
//                                     value: selectedBirthDateYear,
//                                     items: yearListBirthDate.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text(value.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedBirthDateYear = newValue;
//                                         isBirthDateYearSelected = true;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.grey,
//                                       size: 24.0,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             (errorMessageBirthDate != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       errorMessageBirthDate!,
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 20,
//                                   ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.only(start: 0),
//                               child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Travel document',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 15),
//                             CustomTextField(
//                               controller: passportnumber_con,
//                               validator: (value) {
//                                 if (value!.isEmpty || value.length < 3) {
//                                   return 'Please enter your passport number';
//                                 }
//                                 return null;
//                               },
//                               prefIcon: Icons.person_2,
//                               colorIcon: AppColors.pinkColor2,
//                               hintText: 'Passport Number',
//                               style: TextStyle(),
//                             ),
//                             (errorPassport != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       errorPassport!,
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 20,
//                                   ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20)),
//                               padding: EdgeInsetsDirectional.only(
//                                 start: 12,
//                                 end: 12,
//                               ),
//                               height: (size.height / 16) - 5,
//                               width: size.width - 40,
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   hint: Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 6,
//                                       ),
//                                       Icon(
//                                         Icons.public,
//                                         size: 22,
//                                         color: AppColors.Blue,
//                                       ),
//                                       SizedBox(
//                                         width: 12,
//                                       ),
//                                       Obx(
//                                         () => Text(
//                                           controller_TravellerDetailsView2
//                                                   .issuingcountry.value ??
//                                               '',
//                                           style: TextStyle(
//                                             color:
//                                                 (controller_TravellerDetailsView2
//                                                             .issuingcountry
//                                                             .value ==
//                                                         'issuing Country')
//                                                     ? Colors.grey
//                                                     : Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   items: items_issuingCountry
//                                       .map((item) => DropdownMenuItem(
//                                             value: item,
//                                             child: Text(
//                                               item,
//                                               style: const TextStyle(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ))
//                                       .toList(),
//                                   value: selectedValueIssuingCountry,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedValueIssuingCountry = value;
//                                       controller_TravellerDetailsView2
//                                           .setissuingcountry(value ?? '');
//                                       isissuingcountrySelected = true;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     Icons.arrow_drop_down_outlined,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             (errorMessageissuingcountry != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       errorMessageissuingcountry!,
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 20,
//                                   ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             SizedBox(
//                               width: 50,
//                             ),
//                             Text('Expire date',
//                                 style: TextStyle(color: Colors.grey)),
//                             SizedBox(
//                               height: 4,
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Container(
//                                   width: 90.0,
//                                   padding: EdgeInsetsDirectional.only(
//                                       start: 20, end: 10),
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   child: DropdownButton<int>(
//                                     hint: Obx(
//                                       () => (selectedExpireDateDay == null)
//                                           ? Text(
//                                               controller_TravellerDetailsview2
//                                                       .expiredateDay.value ??
//                                                   '',
//                                               style: TextStyle(
//                                                 color:
//                                                     (controller_TravellerDetailsView2
//                                                                 .expiredateDay
//                                                                 .value ==
//                                                             'Day')
//                                                         ? Colors.grey
//                                                         : Colors.black,
//                                               ),
//                                             )
//                                           : Text(
//                                               selectedExpireDateDay.toString()),
//                                     ),
//                                     value: selectedExpireDateDay,
//                                     items: daysListExpireDate.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text(value.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedExpireDateDay = newValue;
//                                         isExpireDaySelected = true;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.grey,
//                                       size: 24.0,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 30,
//                                 ),
//                                 Container(
//                                   width: 110.0,
//                                   padding: EdgeInsetsDirectional.only(
//                                       start: 20, end: 10),
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   child: DropdownButton<int>(
//                                     hint: Obx(
//                                       () => (selectedExpireDateMonth == null)
//                                           ? Text(
//                                               controller_TravellerDetailsview2
//                                                       .expiredateMonth.value ??
//                                                   '',
//                                               style: TextStyle(
//                                                   color:
//                                                       (controller_TravellerDetailsView2
//                                                                   .expiredateMonth
//                                                                   .value ==
//                                                               'Month')
//                                                           ? Colors.grey
//                                                           : Colors.black),
//                                             )
//                                           : Text(selectedExpireDateMonth
//                                               .toString()),
//                                     ),
//                                     value: selectedExpireDateMonth,
//                                     items: monthListExpireDate.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text(value.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedExpireDateMonth = newValue;
//                                         isExpireDateMonthSelected = true;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.grey,
//                                       size: 24.0,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 30,
//                                 ),
//                                 Container(
//                                   width: 110.0,
//                                   padding: EdgeInsetsDirectional.only(
//                                       start: 20, end: 10),
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   child: DropdownButton<int>(
//                                     hint: Obx(
//                                       () => (selectedExpireDateYear == null)
//                                           ? Text(
//                                               controller_TravellerDetailsview2
//                                                       .expiredateYear.value ??
//                                                   '',
//                                               style: TextStyle(
//                                                 color:
//                                                     (controller_TravellerDetailsView2
//                                                                 .expiredateYear
//                                                                 .value ==
//                                                             'Year')
//                                                         ? Colors.grey
//                                                         : Colors.black,
//                                               ),
//                                             )
//                                           : Text(selectedExpireDateYear
//                                               .toString()),
//                                     ),
//                                     value: selectedExpireDateYear,
//                                     items: yearListExpireDate.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text(value.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedExpireDateYear = newValue;
//                                         isExpireDateYearSelected = true;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.grey,
//                                       size: 24.0,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             (errorMessageExpireDate != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       errorMessageExpireDate!,
//                                       style: TextStyle(
//                                           fontSize: 11,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                             (generalErrorMessage != null)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start: 6, top: 10),
//                                     child: Text(
//                                       generalErrorMessage!,
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color:
//                                               Color.fromARGB(255, 215, 16, 2)),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 10,
//                                   ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 InkWell(
//                                     onTap: _confirm,
//                                     child: Container(
//                                       width: 115,
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                         color: AppColors.mainColorBlue,
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'Set as traveller',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: screenWidth(28)),
//                                         ),
//                                       ),
//                                     )),
//                                 SizedBox(width: 10),
//                                 InkWell(
//                                     onTap: () {
//                                       Get.back();
//                                     },
//                                     child: Container(
//                                       width: 115,
//                                       height: 40,
//                                       decoration: BoxDecoration(),
//                                       child: Center(
//                                         child: Text(
//                                           'Cancel',
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: screenWidth(28)),
//                                         ),
//                                       ),
//                                     )),
//                                 SizedBox(width: 10),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Gender?> showGenderOptions() async {
//     selectedOption = selectedgender;

//     selectedgender = await showModalBottomSheet<Gender>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               height: MediaQuery.of(context).size.height * 0.3 + 80,
//               child: DraggableScrollableSheet(
//                 initialChildSize: 0.5,
//                 minChildSize: 0.2,
//                 maxChildSize: 0.8,
//                 builder: (_, controller) {
//                   return Container(
//                     height: MediaQuery.of(context).size.height *
//                         0.2, // This is 50% of the screen height
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(height: 8),
//                         Center(
//                           child: Container(
//                             width: 40,
//                             height: 5,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(2.5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 15,
//                             ),
//                             const Text(
//                               'Gender',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500, fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                           ],
//                         ),
//                         ListTile(
//                           key: UniqueKey(),
//                           title: Text('Male'),
//                           leading: Radio<Gender>(
//                             value: Gender.Male,
//                             groupValue: selectedOption,
//                             onChanged: (Gender? value) {
//                               setState(() {
//                                 selectedOption = value;
//                                 controller_TravellerDetailsView2.setgender('M');
//                                 isGenderSelected = true;
//                               });
//                               Navigator.pop(context, selectedOption);
//                             },
//                           ),
//                         ),
//                         ListTile(
//                           title: Text('Famale'),
//                           leading: Radio<Gender>(
//                             value: Gender.Famle,
//                             groupValue: selectedOption,
//                             onChanged: (Gender? value) {
//                               setState(() {
//                                 selectedOption = value;
//                                 controller_TravellerDetailsView2.setgender('F');
//                                 isGenderSelected = true;
//                               });
//                               Navigator.pop(context, selectedOption);
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
