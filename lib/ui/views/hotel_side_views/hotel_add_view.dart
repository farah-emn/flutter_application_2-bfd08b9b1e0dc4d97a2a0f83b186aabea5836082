// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_field, unused_local_variable, unnecessary_nullable_for_final_variable_declarations, deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_element, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, avoid_print, unnecessary_new

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class HotelAddView extends StatefulWidget {
  const HotelAddView({super.key});
  @override
  State<HotelAddView> createState() => _HotelAddViewState();
}

class _HotelAddViewState extends State<HotelAddView> {
  bool? isCheckedFreeWifi = false;
  bool? isCheckedPrivatePool = false;
  bool? isCheckedFoodAnddrink = false;
  bool? isCheckedPrivateParking = false;
  bool? isCheckedCleaningServices = false;
  final _Overview = TextEditingController();
  final _price = TextEditingController();
  final _RoomNumber = TextEditingController();
  final _Adults = TextEditingController();
  final _Children = TextEditingController();
  final _BedRooms = TextEditingController();
  final _NumberOfRoomAvilable = TextEditingController();
  final _Bathrooms = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late String errorTextRoomPhoto = '';

  List<XFile> _images = [];
  int _current = 0;
  int IdRoom = 0;
  int IdAirport = 0;
  int IdPlane = 0;
  int IdStop_location = 0;
  User? Hotel;
  var HotelId = '';
  var uid;
  final _auth = FirebaseAuth.instance;
  var currentUser;
  int selectedIndex = 0;
  DatabaseReference HotelRoom =
      FirebaseDatabase.instance.reference().child('Room');
  List<String?> selectedValues = List.filled(0, null);
  final List<String> ChildrenAge = [
    'Under 1 year old',
    '2 year old',
    '3 year old',
    '4 year old',
    '5 year old',
    '6 year old',
    '7 year old',
    '8 year old',
    '9 year old',
    '10 year old',
    '11 year old',
    '12 year old',
    '13 year old',
    '14 year old',
    '15 year old',
    '16 year old',
    '17 year old',
  ];
  bool _isWidgetActive = true;

  // @override
  // void dispose() {
  //   _isWidgetActive = false;
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    setState(() {
      Hotel = _auth.currentUser;
      HotelId = Hotel?.uid.toString() ?? '';
    });
    HotelRoom.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (mounted) {
        setState(() {
          IdRoom = event.snapshot.children.length + 1;
        });
      }
    });
    super.initState();
  }

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        if (!_images.any((x) => x.path == image.path)) {
          _images.add(image);
        }
      }
    }
    setState(() {});
  }

  bool _isLoading = false;

  Future<bool> _uploadToFirebase(
      List<XFile> images, BuildContext context) async {
    int IdOfRoomPhoto = 0;
    int IdOfChild = 0;
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('Room/$IdRoom:').set({
      "HotelId": HotelId,
      "Price": double.parse(_price.text.replaceAll('\u{00A0}', '')),
      "Overview": _Overview.text,
      "NumberOfRooms": int.parse(
          _NumberOfRoomAvilable.value.text.replaceAll('\u{00A0}', '')),
      "RoomNumber": _RoomNumber.text,
      "NumberOfBathrooms":
          int.parse(_Bathrooms.text.replaceAll('\u{00A0}', '')),
      "NumberOfBedrooms": int.parse(_BedRooms.text.replaceAll('\u{00A0}', '')),
      "Adults": int.parse(_Adults.text.replaceAll('\u{00A0}', '')),
      "Children": int.parse(_Children.text.replaceAll('\u{00A0}', '')),
      "isCheckedFreeWifi": isCheckedFreeWifi,
      "isCheckedPrivatePool": isCheckedPrivatePool,
      "isCheckedFoodAnddrink": isCheckedFoodAnddrink,
      "isCheckedCleaningServices": isCheckedCleaningServices,
      "isCheckedPrivateParking": isCheckedPrivateParking,
      "is_reserved": false,
    });
    //image
    if (images.isNotEmpty) {
      for (var image in images) {
        IdOfRoomPhoto += 1;
        File file = File(image.path);
        var imagename = basename(image.path);
        var Firebase_Storage = FirebaseStorage.instance.ref(imagename);
        await Firebase_Storage.putFile(file);
        String url = await Firebase_Storage.getDownloadURL();
        databaseReference
            .child('Room/$IdRoom:/RoomPhoto')
            .update({'$IdOfRoomPhoto': url});
      }
    }

    // if (selectedValues.isNotEmpty)
    //   for (var i in selectedValues) {
    //     IdOfChild++;
    //     databaseReference
    //         .child('Room/$IdRoom:/ChildrenAge')
    //         .update({'$IdOfChild': i});
    //   }
    setState(() {
      _isWidgetActive = false;
      _isLoading = false;
    });
    setState(() {
      _Adults.clear();
      _Bathrooms.clear();
      _BedRooms.clear();
      _Children.clear();
      _NumberOfRoomAvilable.clear();
      _Overview.clear();
      _RoomNumber.clear();
      _price.clear();
      _images.clear();
      ChildrenAge.clear();
      isCheckedCleaningServices = false;
      isCheckedFoodAnddrink = false;
      isCheckedFreeWifi = false;
      isCheckedPrivateParking = false;
      isCheckedPrivatePool = false;
      errorTextRoomPhoto = '';
    });

    return true;
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    void _confirm() async {
      if (_price.text.isNotEmpty &&
          _NumberOfRoomAvilable.text.isNotEmpty &&
          _RoomNumber.text.isNotEmpty &&
          _Overview.text.isNotEmpty &&
          _BedRooms.text.isNotEmpty &&
          _Adults.text.isNotEmpty &&
          _Bathrooms.text.isNotEmpty) {
        if (_images.length < 6) {
          setState(() {
            errorTextRoomPhoto = 'Please enter at least 6 photos';
          });
        } else if (_images.length >= 6) {
          // Show a dialog with a CircularProgressIndicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text("Loading"),
                  ],
                ),
              );
            },
          );

          // Call the _uploadToFirebase function
          bool uploadResult = await _uploadToFirebase(_images, context);

          // Dismiss the loading dialog regardless of the result
          if (uploadResult) {
            Navigator.pop(context);
          }
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please Add all fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    String dropdownValue = 'under 1';

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightPurple,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Room',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.purple),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Room Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(15),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Room photos',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: _pickImages,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.purple,
                                  ),
                                )
                              ],
                            ),
                            (errorTextRoomPhoto != null && _images.length == 0)
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 6, top: 0),
                                        child: Text(
                                          errorTextRoomPhoto,
                                          style: TextStyle(
                                              fontSize: 11, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 15,
                                  ),
                            SizedBox(
                              height: 12,
                            ),
                            if (_images.isNotEmpty)
                              SizedBox(
                                height: 280,
                                child: Column(
                                  children: [
                                    Column(children: [
                                      Stack(
                                        children: [
                                          Center(
                                            child: Image.file(
                                              File(_images[selectedIndex].path),
                                              fit: BoxFit.contain,
                                              height: size.height / 5 + 20,
                                            ),
                                          ),
                                          Positioned(
                                            left: -12,
                                            bottom: 0,
                                            top: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.keyboard_arrow_left_sharp,
                                                color: AppColors.purple,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (selectedIndex > 0) {
                                                    selectedIndex--;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            right: -12,
                                            bottom: 0,
                                            top: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_right_sharp,
                                                color: AppColors.purple,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (selectedIndex <
                                                      _images.length - 1) {
                                                    selectedIndex++;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                    Center(
                                      child: SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _images.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: selectedIndex ==
                                                              index
                                                          ? AppColors.purple
                                                          : Colors.transparent,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Image.file(File(
                                                      _images[index].path))),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    (errorTextRoomPhoto != null)
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 6, top: 0),
                                                child: Text(
                                                  errorTextRoomPhoto,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 15,
                                          ),
                                  ],
                                ),
                              ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              width: size.width - 50,
                              child: TextField(
                                controller: _Overview,
                                decoration: textFielDecoratiom.copyWith(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.lightPurple,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.description_rounded,
                                    color: AppColors.purple,
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        controller: _price,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.price_change,
                                              color: AppColors.purple,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Room number',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        controller: _RoomNumber,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightPurple,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.door_back_door_rounded,
                                              color: AppColors.purple,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (_isLoading)
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Amenities',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.wifi_rounded,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Free wi-fi',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: isCheckedFreeWifi,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isCheckedFreeWifi = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.pool_rounded,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Private pool',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: isCheckedPrivatePool,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isCheckedPrivatePool = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.coffee,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Food & drink',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: isCheckedFoodAnddrink,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isCheckedFoodAnddrink = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.bed,
                                  color: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Cleaning services',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                Spacer(),
                                Checkbox(
                                  value: isCheckedCleaningServices,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isCheckedCleaningServices = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_parking,
                                  color: AppColors.purple,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Private Parking',
                                  style: TextStyle(fontSize: TextSize.header2),
                                ),
                                Spacer(),
                                Checkbox(
                                  value: isCheckedPrivateParking,
                                  onChanged: (bool? newValue) {
                                    setState(
                                      () {
                                        isCheckedPrivateParking = newValue;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // const Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   children: [
                                    //     SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       'Guests',
                                    //       style: TextStyle(
                                    //           fontSize: 13,
                                    //           color: AppColors.grayText,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      'Adults',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .grayText,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: size.width / 2 - 35,
                                                  child: TextField(
                                                    controller: _Adults,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: textFielDecoratiom
                                                        .copyWith(
                                                            focusedBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: AppColors
                                                                    .lightPurple,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          18)),
                                                            ),
                                                            fillColor:
                                                                Colors.white,
                                                            prefixIcon:
                                                                const Icon(
                                                              Icons
                                                                  .people_alt_rounded,
                                                              color: AppColors
                                                                  .purple,
                                                            )),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      'Children',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: AppColors
                                                              .grayText,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: size.width / 2 - 35,
                                                  child: TextField(
                                                    controller: _Children,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: textFielDecoratiom
                                                        .copyWith(
                                                            focusedBorder:
                                                                const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: AppColors
                                                                    .lightPurple,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          18)),
                                                            ),
                                                            fillColor:
                                                                Colors.white,
                                                            prefixIcon:
                                                                const Icon(
                                                              Icons
                                                                  .people_alt_rounded,
                                                              color: AppColors
                                                                  .purple,
                                                            )),
                                                    // onChanged: (value) {
                                                    //   setState(() {
                                                    //     _Children.text = value;
                                                    //     selectedValues =
                                                    //         List.filled(
                                                    //             int.parse(
                                                    //                 value),
                                                    //             null);
                                                    //   });
                                                    // },
                                                    onSubmitted: (value) {
                                                      setState(() {
                                                        _Children.text = value;
                                                        selectedValues =
                                                            List.filled(
                                                                int.parse(
                                                                    _Children
                                                                        .text),
                                                                null);
                                                      });
                                                    },
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
                                // (_Children.text.isNotEmpty)
                                //     ? ListView.builder(
                                //         physics: NeverScrollableScrollPhysics(),
                                //         shrinkWrap: true,
                                //         itemCount: selectedValues.length,
                                //         itemBuilder: (context, index) {
                                //           return Container(
                                //             padding: EdgeInsetsDirectional.only(
                                //                 bottom: 0, top: 30),
                                //             child: Center(
                                //                 child: Column(
                                //               children: [
                                //                 Row(
                                //                   children: [
                                //                     Text(
                                //                       'Child age ${index + 1}',
                                //                       style: TextStyle(
                                //                           fontSize: 13,
                                //                           color: AppColors
                                //                               .grayText,
                                //                           fontWeight:
                                //                               FontWeight.w500),
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 DropdownButtonHideUnderline(
                                //                   child:
                                //                       DropdownButton2<String>(
                                //                     isExpanded: true,
                                //                     hint: const Row(
                                //                       children: [
                                //                         Icon(
                                //                           Icons
                                //                               .child_care_rounded,
                                //                           size: 16,
                                //                           color:
                                //                               AppColors.purple,
                                //                         ),
                                //                         SizedBox(
                                //                           width: 4,
                                //                         ),
                                //                       ],
                                //                     ),
                                //                     items: ChildrenAge.map(
                                //                         (String item) =>
                                //                             DropdownMenuItem<
                                //                                 String>(
                                //                               value: item,
                                //                               child: Text(
                                //                                 item,
                                //                                 style: const TextStyle(
                                //                                     fontSize:
                                //                                         13,
                                //                                     color: AppColors
                                //                                         .blackColor,
                                //                                     fontWeight:
                                //                                         FontWeight
                                //                                             .w500),
                                //                                 overflow:
                                //                                     TextOverflow
                                //                                         .ellipsis,
                                //                               ),
                                //                             )).toList(),
                                //                     value:
                                //                         selectedValues[index],
                                //                     onChanged: (value) {
                                //                       setState(() {
                                //                         selectedValues[index] =
                                //                             value;
                                //                       });
                                //                     },
                                //                     buttonStyleData:
                                //                         ButtonStyleData(
                                //                       height: 40,
                                //                       width: size.width - 50,
                                //                       padding:
                                //                           const EdgeInsets.only(
                                //                               left: 14,
                                //                               right: 14),
                                //                       decoration: BoxDecoration(
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(18),
                                //                         border: Border.all(
                                //                           color: AppColors
                                //                               .LightGrayColor,
                                //                         ),
                                //                         color: AppColors
                                //                             .TextFieldcolor,
                                //                       ),
                                //                       // elevation: 2,
                                //                     ),
                                //                     iconStyleData:
                                //                         const IconStyleData(
                                //                       // icon: Icon(
                                //                       //   Icons.arrow_forward_ios_outlined,
                                //                       // ),
                                //                       iconSize: 14,
                                //                       iconEnabledColor:
                                //                           Colors.black,
                                //                       iconDisabledColor:
                                //                           AppColors
                                //                               .babyblueColor,
                                //                     ),
                                //                     dropdownStyleData:
                                //                         DropdownStyleData(
                                //                       maxHeight: 180,
                                //                       width: size.width - 50,
                                //                       decoration: BoxDecoration(
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(18),
                                //                         border: Border.all(
                                //                           color: AppColors
                                //                               .LightGrayColor,
                                //                         ),
                                //                         color: AppColors
                                //                             .TextFieldcolor,
                                //                       ),
                                //                       offset:
                                //                           const Offset(-20, 0),
                                //                       scrollbarTheme:
                                //                           ScrollbarThemeData(
                                //                         radius: const Radius
                                //                             .circular(40),
                                //                         thickness:
                                //                             MaterialStateProperty
                                //                                 .all(6),
                                //                         thumbVisibility:
                                //                             MaterialStateProperty
                                //                                 .all(true),
                                //                       ),
                                //                     ),
                                //                     menuItemStyleData:
                                //                         const MenuItemStyleData(
                                //                       height: 40,
                                //                       padding: EdgeInsets.only(
                                //                           left: 14, right: 14),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             )),
                                //           );
                                //         },
                                //       )
                                //:
                                SizedBox(
                                  height: 30,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'Rooms',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.grayText,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: size.width / 3 - 25,
                                          child: TextField(
                                            controller: _NumberOfRoomAvilable,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                textFielDecoratiom.copyWith(
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .lightPurple,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  18)),
                                                    ),
                                                    fillColor: Colors.white,
                                                    prefixIcon: const Icon(
                                                      Icons.meeting_room,
                                                      color: AppColors.purple,
                                                    )),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bedrooms',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: size.width / 3 - 25,
                                          child: TextField(
                                            controller: _BedRooms,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                textFielDecoratiom.copyWith(
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.lightPurple,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(18)),
                                              ),
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                Icons.bed,
                                                color: AppColors.purple,
                                              ),
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bathrooms',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: size.width / 3 - 25,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _Bathrooms,
                                            decoration:
                                                textFielDecoratiom.copyWith(
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.lightPurple,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(18)),
                                              ),
                                              fillColor: Colors.white,
                                              prefixIcon: const Icon(
                                                Icons.bathtub,
                                                color: AppColors.purple,
                                              ),
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: _confirm,
                        child: CustomButton(
                          backgroundColor: AppColors.purple,
                          text: 'Add',
                          textColor: Colors.white,
                          widthPercent: size.width,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
