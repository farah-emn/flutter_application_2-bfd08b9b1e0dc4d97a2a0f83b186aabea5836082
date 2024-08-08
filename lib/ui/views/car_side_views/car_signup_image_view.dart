// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/car_side_views/car_home_screen.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_home_screen.dart';
import 'package:traveling/ui/views/hotel_side_views/map_view.dart';

class CarSignUpImageView extends StatefulWidget {
  const CarSignUpImageView({super.key});

  @override
  _CarSignUpImageViewState createState() => _CarSignUpImageViewState();
}

class _CarSignUpImageViewState extends State<CarSignUpImageView> {
  final picker = ImagePicker();
  User? AirelineCompany;
  var AirelineCompanyId = '';
  var AirelineCompanyName = '';
  final _auth = FirebaseAuth.instance;
  var uid;
  var currentUser;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? photo;
  final _Country = TextEditingController();
  final _Address = TextEditingController();
  final _City = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      AirelineCompany = _auth.currentUser;
      AirelineCompanyId = AirelineCompany?.uid.toString() ?? '';
    });
  }

  void _uploadImageToFirebase(XFile image) async {
    if (_Address.text.isNotEmpty &&
        _Country.text.isNotEmpty &&
        _City.text.isNotEmpty) {
      File file = File(image.path);
      var imagename = basename(image.path);
      var Firebase_Storage = FirebaseStorage.instance.ref(imagename);
      await Firebase_Storage.putFile(file);
      String url = await Firebase_Storage.getDownloadURL();
      FirebaseDatabase.instance.ref("Hotel").child(AirelineCompanyId).update({
        "image": url,
        "location": '${_City.text}, ${_Country.text}',
        "address": '${_Address.text}'
      });
      Get.offAll(CarHome());
    } else {
      Fluttertoast.showToast(
          msg: "Please enter all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 158, 165, 174),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _showModalSheet() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.minimize_rounded,
                      size: 40,
                      color: AppColors.grayText,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Logo Photo',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        photo = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          _image = photo;
                        });

                        if (photo != null) {
                          _uploadImageToFirebase(photo!);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.photo_size_select_actual_rounded,
                            color: AppColors.lightOrange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Pick from gallery',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        PermissionStatus cameraPermission =
                            await Permission.camera.status;
                        if (!cameraPermission.isGranted) {
                          cameraPermission = await Permission.camera.request();
                        }
                        if (cameraPermission.isGranted) {
                          photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            _image = photo;
                          });
                        } else {
                          print("Camera permission is not granted");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.orange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Capture from camera',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightOrange,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 110,
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
                const SizedBox(
                  height: 100,
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
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 300,
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 330),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: _image == null
                          ? InkWell(
                              onTap: _showModalSheet,
                              child: Container(
                                height: 120,
                                width: 120,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.gray,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(120),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: AppColors.orange,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: _showModalSheet,
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: _image != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          File(_image!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: _showModalSheet,
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.grayText,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: AppColors.orange,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                  fontSize: TextSize.header1,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  MapView(
                                    onLocationSelected:
                                        (newLocality, newStreet, newCountry) {
                                      setState(() {
                                        _City.text = newLocality;
                                        _Address.text = newStreet;
                                        _Country.text = newCountry;
                                      });
                                    },
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Show on map',
                                    style: TextStyle(
                                        fontSize: TextSize.header2,
                                        color: AppColors.grayText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Country',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.grayText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width,
                      child: TextField(
                        controller: _Country,
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.orange, width: 1.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.orange,
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
                          'City',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width,
                      child: TextField(
                        controller: _City,
                        keyboardType: TextInputType.number,
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.orange, width: 1.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.orange,
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
                          'Address',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.grayText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width,
                      child: TextField(
                        controller: _Address,
                        keyboardType: TextInputType.number,
                        decoration: textFielDecoratiom.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(color: AppColors.orange, width: 1.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.orange,
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Get.offAll(CarHome());
                          },
                          // onTap: () {
                          //   if (photo != null) {
                          //     _uploadImageToFirebase(photo!);
                          //   } else {
                          //     Fluttertoast.showToast(
                          //         msg: "Please choose image",
                          //         toastLength: Toast.LENGTH_SHORT,
                          //         gravity: ToastGravity.BOTTOM,
                          //         timeInSecForIosWeb: 1,
                          //         backgroundColor:
                          //             const Color.fromARGB(255, 158, 165, 174),
                          //         textColor: Colors.white,
                          //         fontSize: 16.0);
                          //   }
                          // },
                          child: CustomButton(
                              text: 'Confirm location',
                              textColor: AppColors.backgroundgrayColor,
                              backgroundColor: AppColors.orange,
                              widthPercent: size.width,
                              heightPercent: 15),
                        ),
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
