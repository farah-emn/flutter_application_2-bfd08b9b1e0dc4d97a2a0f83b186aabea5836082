// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, unnecessary_null_comparison, prefer_const_constructors_in_immutables, library_private_types_in_public_api, invalid_use_of_protected_member, non_constant_identifier_names, prefer_collection_literals, prefer_is_empty, unused_local_variable, unnecessary_brace_in_string_interps, prefer_final_fields, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ocr_sdk/mrz_result.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/traveller_details_view1_controller.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/controllers/traveller_details_view2_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:mrz_parser/mrz_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/scan_traveller_id/global.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/traveller_baggage.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/traveller_details_view4.dart';
import '../../../../controllers/text_only_input_formatter.dart';
import '../../../shared/custom_widgets/white_container.dart';
import 'traveller_details_view2.dart';

class TravellerDetailsView1 extends StatefulWidget {
  final ValueNotifier<bool>? isFormValid;
  final bool? change;
  String? type;

  TravellerDetailsView1({
    Key? key,
    this.type,
    required this.isFormValid,
    this.change,
  }) : super(key: key);

  @override
  _TravellerDetailsView1State createState() => _TravellerDetailsView1State();
}

class _TravellerDetailsView1State extends State<TravellerDetailsView1> {
  late final TextEditingController _mobileNumberController =
      TextEditingController();
  late final TextEditingController _firstNameController =
      TextEditingController();
  late final TextEditingController _lastNameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  final TravellerDetails_Controller =
      Get.find<TravellerDetailsView1Controller>();
  final controller_oneway = Get.put(SearchViewOneWayController());
  final controller_roundtrip = Get.put(SearchViewRoundTripController());

  final _auth = FirebaseAuth.instance;
  late final User? user;
  String? email;
  String? MobileNumber;
  String? FirstName;
  String? LastName;

  late DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('user');
    user = _auth.currentUser;

    getData();

    super.initState();
    TravellerDetails_Controller.AdultList.clear();
    TravellerDetails_Controller.BaggageAdult.clear();
    TravellerDetails_Controller.BaggageChild.clear();
    TravellerDetails_Controller.ChildList.clear();
    final controller_TravellerDetailsView2 =
        Get.put(TravellerDetailsView2Controller());
    print(_emailController.text);
  }

  void getData() async {
    final userId = user!.uid.toString();
    final event = await ref.child(userId).get();
    print(event);
    final userData = Map<dynamic, dynamic>.from(event.value as Map);

    _emailController.text = userData['email'];
    _mobileNumberController.text = userData['mobile_number'];
    _firstNameController.text = userData['first_name'];
    _lastNameController.text = userData['last_name'];
  }

  late MRZResult receivedData;
  MrzResult? result;
  Future<int> loadData() async {
    return await initMRZSDK();
  }

  Set<int> selectedIndices = Set();
  Set<int> selectedIndices1 = Set();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
    ) {
      final RegExp regExp = RegExp(r'^[a-zA-Z\s]*$');
      if (regExp.hasMatch(newValue.text)) {
        return newValue;
      }
      return oldValue;
    }

    Size size = MediaQuery.of(context).size;
    return Form(
        child: Column(children: [
      Column(children: [
        Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add traveller details',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: TextSize.header1,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (controller_oneway.Adultcounter == 1 ||
                  controller_roundtrip.Adultcounter == 1)
                Container(
                  width: 400,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: (controller_roundtrip.Adultcounter != 1)
                        ? controller_roundtrip.Adultcounter
                        : (controller_oneway.Adultcounter != 1)
                            ? controller_oneway.Adultcounter
                            : controller_roundtrip.Adultcounter,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndices.contains(index);
                      return Container(
                        padding: EdgeInsetsDirectional.only(bottom: 10),
                        child: InkWell(
                            onTap: () {},
                            child: isSelected
                                ? Container(
                                    color: AppColors.TextFieldcolor,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10, bottom: 10, top: 10),
                                          width: size.width,
                                          color: AppColors.babyblueColor,
                                          child: Text(
                                            'Adult ${index + 1}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10,
                                              bottom: 10,
                                              top: 5,
                                              end: 10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      TravellerDetails_Controller
                                                                      .AdultList[
                                                                  index] !=
                                                              null
                                                          ? TravellerDetails_Controller
                                                                  .AdultList[
                                                                      index]
                                                                  .givenName ??
                                                              ''
                                                          : '',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Text(
                                                      TravellerDetails_Controller
                                                                      .AdultList[
                                                                  index] !=
                                                              null
                                                          ? TravellerDetails_Controller
                                                              .AdultList[index]
                                                              .birthDate
                                                          : '',
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              142, 141, 141)),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      print(
                                                          TravellerDetails_Controller
                                                              .AdultList);

                                                      result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TravellerDetailsView4(
                                                            change_data:
                                                                TravellerDetails_Controller
                                                                        .AdultList[
                                                                    index],
                                                          ),
                                                        ),
                                                      );
                                                      if (result != null) {
                                                        setState(() {
                                                          if (TravellerDetails_Controller
                                                                      .AdultList[
                                                                  index] !=
                                                              null) {
                                                            TravellerDetails_Controller
                                                                    .AdultList[
                                                                index] = result;
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_right_sharp,
                                                      color: AppColors
                                                          .LightGrayColor,
                                                    )),
                                              ]),
                                        ),
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              end: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.luggage,
                                                    color: const Color.fromARGB(
                                                        255, 215, 215, 215),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('View / Add bugagge'),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  print(index);
                                                  if (index <
                                                      TravellerDetails_Controller
                                                          .BaggageAdult
                                                          .value
                                                          .length) {
                                                    var resul =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TravellerBaggage(
                                                          Extrabaggage:
                                                              TravellerDetails_Controller
                                                                  .BaggageAdult
                                                                  .value[index],
                                                        ),
                                                      ),
                                                    );

                                                    if (resul != null &&
                                                        resul.length >= 2) {
                                                      setState(() {
                                                        print(
                                                            TravellerDetails_Controller
                                                                .BaggageAdult
                                                                .value);
                                                        if (resul[1] == true) {
                                                          TravellerDetails_Controller
                                                                  .BaggageAdult
                                                                  .value[
                                                              index] = resul[0];
                                                        } else {
                                                          TravellerDetails_Controller
                                                              .addBaggageAdult(
                                                                  resul[0]);
                                                        }
                                                      });
                                                    }
                                                  } else {
                                                    var travellerbaggage =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TravellerBaggage(),
                                                      ),
                                                    );
                                                    print(travellerbaggage);
                                                    if (travellerbaggage !=
                                                            null &&
                                                        travellerbaggage
                                                                .length >=
                                                            2) {
                                                      setState(() {
                                                        var ExtraBaggage =
                                                            travellerbaggage[0];

                                                        TravellerDetails_Controller
                                                            .addBaggageAdult(
                                                                travellerbaggage[
                                                                    0]);
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_right_sharp,
                                                  color:
                                                      AppColors.LightGrayColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    width: 100,
                                    color: AppColors.TextFieldcolor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.boy,
                                              color: AppColors.LightBlueColor,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Adult ${index + 1}',
                                              style: TextStyle(
                                                color: AppColors.TextgrayColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: AppColors.IconBlueColor,
                                          ),
                                          onPressed: () async {
                                            if (index == 0) {
                                              result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TravellerDetailsView4(),
                                                ),
                                              );
                                              if (result != null) {
                                                setState(() {
                                                  TravellerDetails_Controller
                                                      .AdultList.add(result);
                                                  if (isSelected) {
                                                    selectedIndices
                                                        .remove(index);
                                                  } else {
                                                    selectedIndices.add(index);
                                                  }
                                                });
                                              }
                                            } else if (index != null &&
                                                TravellerDetails_Controller
                                                        .AdultList.length !=
                                                    0) {
                                              result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TravellerDetailsView4(),
                                                ),
                                              );
                                              if (result != null) {
                                                setState(() {
                                                  TravellerDetails_Controller
                                                      .AdultList.add(result);
                                                  // .addAdult(result!);
                                                  if (isSelected) {
                                                    selectedIndices
                                                        .remove(index);
                                                  } else {
                                                    selectedIndices.add(index);
                                                  }
                                                });
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please add details for Adult ${index} first",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 158, 165, 174),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                      );
                    },
                  ),
                ),
              if (controller_oneway.Childcounter != 0 ||
                  controller_roundtrip.Childcounter != 0)
                Container(
                  width: 400,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: (controller_roundtrip.Childcounter != 0)
                        ? controller_roundtrip.Childcounter
                        : (controller_oneway.Childcounter != 0)
                            ? controller_oneway.Childcounter
                            : 0,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndices1.contains(index);
                      return Container(
                        padding: EdgeInsetsDirectional.only(bottom: 10),
                        child: InkWell(
                            onTap: () {},
                            child: isSelected
                                ? Container(
                                    color: AppColors.TextFieldcolor,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10, bottom: 10, top: 10),
                                          width: size.width,
                                          color: AppColors.babyblueColor,
                                          child: Text(
                                            'Child ${index + 1}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10,
                                              bottom: 10,
                                              top: 5,
                                              end: 10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      TravellerDetails_Controller
                                                                      .ChildList[
                                                                  index] !=
                                                              null
                                                          ? TravellerDetails_Controller
                                                                  .ChildList[
                                                                      index]
                                                                  .givenName ??
                                                              ''
                                                          : '',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Text(
                                                      TravellerDetails_Controller
                                                                      .ChildList[
                                                                  index] !=
                                                              null
                                                          ? TravellerDetails_Controller
                                                              .ChildList[index]
                                                              .birthDate
                                                          : '',
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              142, 141, 141)),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      print(
                                                          TravellerDetails_Controller
                                                              .ChildList);

                                                      result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TravellerDetailsView4(
                                                            change_data:
                                                                TravellerDetails_Controller
                                                                        .ChildList[
                                                                    index],
                                                          ),
                                                        ),
                                                      );
                                                      if (result != null) {
                                                        setState(() {
                                                          if (TravellerDetails_Controller
                                                                      .ChildList[
                                                                  index] !=
                                                              null) {
                                                            TravellerDetails_Controller
                                                                    .ChildList[
                                                                index] = result;
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_right_sharp,
                                                      color: AppColors
                                                          .LightGrayColor,
                                                    )),
                                              ]),
                                        ),
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              end: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.luggage,
                                                    color: const Color.fromARGB(
                                                        255, 215, 215, 215),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('View / Add bugagge'),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  print(index);
                                                  if (index <
                                                      TravellerDetails_Controller
                                                          .BaggageChild
                                                          .value
                                                          .length) {
                                                    var resul =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TravellerBaggage(
                                                          Extrabaggage:
                                                              TravellerDetails_Controller
                                                                  .BaggageChild
                                                                  .value[index],
                                                        ),
                                                      ),
                                                    );

                                                    if (resul != null &&
                                                        resul.length >= 2) {
                                                      setState(() {
                                                        print(
                                                            TravellerDetails_Controller
                                                                .BaggageChild
                                                                .value);
                                                        if (resul[1] == true) {
                                                          TravellerDetails_Controller
                                                                  .BaggageChild
                                                                  .value[
                                                              index] = resul[0];
                                                        } else {
                                                          TravellerDetails_Controller
                                                              .addBaggageChild(
                                                                  resul[0]);
                                                        }
                                                      });
                                                    }
                                                  } else {
                                                    var travellerbaggage =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TravellerBaggage(),
                                                      ),
                                                    );
                                                    print(travellerbaggage);
                                                    if (travellerbaggage !=
                                                            null &&
                                                        travellerbaggage
                                                                .length >=
                                                            2) {
                                                      setState(() {
                                                        var ExtraBaggage =
                                                            travellerbaggage[0];

                                                        TravellerDetails_Controller
                                                            .addBaggageChild(
                                                                travellerbaggage[
                                                                    0]);
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_right_sharp,
                                                  color:
                                                      AppColors.LightGrayColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    width: 100,
                                    color: AppColors.TextFieldcolor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.boy,
                                              color: AppColors.LightBlueColor,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Child ${index + 1}',
                                              style: TextStyle(
                                                color: AppColors.TextgrayColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: AppColors.IconBlueColor,
                                          ),
                                          onPressed: () async {
                                            if (index == 0) {
                                              print(TravellerDetails_Controller
                                                  .ChildList.length);

                                              result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TravellerDetailsView4(),
                                                ),
                                              );
                                              if (result != null) {
                                                setState(() {
                                                  TravellerDetails_Controller
                                                      .ChildList.add(result);
                                                  if (isSelected) {
                                                    selectedIndices1
                                                        .remove(index);
                                                  } else {
                                                    selectedIndices1.add(index);
                                                  }
                                                });
                                              }
                                            } else if (index != null &&
                                                TravellerDetails_Controller
                                                        .ChildList.length !=
                                                    0) {
                                              result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TravellerDetailsView4(),
                                                ),
                                              );
                                              if (result != null) {
                                                setState(() {
                                                  TravellerDetails_Controller
                                                      .ChildList.add(result);
                                                  // .addAdult(result!);
                                                  if (isSelected) {
                                                    selectedIndices1
                                                        .remove(index);
                                                  } else {
                                                    selectedIndices1.add(index);
                                                  }
                                                });
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please add details for Child ${index} first",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 158, 165, 174),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                      );
                    },
                  ),
                ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    'Contact details',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize.header1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: decoration.copyWith(),
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _firstNameController,
                        inputFormatters: <TextInputFormatter>[
                          TextOnlyInputFormatter(),
                        ],
                        onChanged: (value) {
                          TravellerDetails_Controller
                              .SetFirstNameContactDetails(
                                  value ?? _firstNameController.text);
                        },
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: AppColors.darkBlue,
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
                        keyboardType: TextInputType.text,
                        controller: _lastNameController,
                        inputFormatters: <TextInputFormatter>[
                          TextOnlyInputFormatter(),
                        ],
                        onChanged: (value) {
                          TravellerDetails_Controller.SetLastNameContactDetails(
                              value ?? _lastNameController.text);
                        },
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: AppColors.darkBlue,
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
                          'Email',
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: <TextInputFormatter>[
                          // EmailInputFormatter(),
                        ],
                        onChanged: (value) {
                          email = value;
                          TravellerDetails_Controller.SetEmailContactDetails(
                              value ?? _emailController.text);
                        },
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            TravellerDetails_Controller.errorTextEmail.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Mobile Number',
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
                        controller: _mobileNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          TravellerDetails_Controller
                              .SetMobileNumberContactDetails(
                                  value ?? _mobileNumberController.text);
                        },
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.purple, width: 1.5),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Obx(() => Text(
                            TravellerDetails_Controller.errorText.value,
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        )
      ])
    ]));
  }
}
