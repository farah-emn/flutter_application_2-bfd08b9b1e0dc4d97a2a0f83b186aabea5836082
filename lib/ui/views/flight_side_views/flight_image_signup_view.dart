// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:traveling/ui/views/flight_side_views/flight_home_screen.dart';

import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../../shared/text_size.dart';
import 'flight_home_view.dart';

class FlightImageSignUpView extends StatefulWidget {
  // const FlightImageSignUpView({super.key});
  String email;
  String password;

  // String Mobilenumber;
  String comapnyname;
  FlightImageSignUpView(
      {super.key,
      // required this.Mobilenumber,
      required this.comapnyname,
      required this.email,
      required this.password});

  @override
  _FlightImageSignUpViewState createState() => _FlightImageSignUpViewState();
}

class _FlightImageSignUpViewState extends State<FlightImageSignUpView> {
  final picker = ImagePicker();
  User? AirelineCompany;
  var AirelineCompanyId = '';
  var AirelineCompanyName = '';
  late String errorText = '';
  var isloading = false.obs;

  final _auth = FirebaseAuth.instance;
  var uid;
  var currentUser;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? photo;
  @override
  void initState() {
    super.initState();
    setState(() {
      AirelineCompany = _auth.currentUser;
      AirelineCompanyId = AirelineCompany?.uid.toString() ?? '';
    });
  }

  void _uploadImageToFirebase(XFile image) async {
    print(widget.email);
    print(widget.password);
    final auth = FirebaseAuth.instance;
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref("Airline_company");

    try {
      isloading.value = true;
      final newAirelineCompany = await auth.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );
      User? AirelineCompany = auth.currentUser;

      if (AirelineCompany != null) {
        File file = File(image.path);
        var imagename = basename(image.path);
        var firebaseStorageRef = FirebaseStorage.instance.ref(imagename);
        await firebaseStorageRef.putFile(file);
        String url = await firebaseStorageRef.getDownloadURL();

        ref.child(AirelineCompany.uid.toString()).set({
          "image": url,
          "AirlineCompanyName": widget.comapnyname,
          "mobile_number": '',
          "email": widget.email,
          "password": widget.password,
          "logo": url
        });

        Get.offAll(FlightHome());
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        isloading.value = false;

        switch (e.code) {
          case 'invalid-email':
            setState(() {
              // Show an error message to the user
              print('The email address is badly formatted.');
            });
            break;
          case 'weak-password':
            setState(() {
              // errorText = 'Password is too weak.';
            });
            break;
          case 'email-already-in-use':
            setState(() {
              // errorText = 'Email is already registered.';
            });
            break;
          // Add more cases as needed
          default:
          // Use the default error message
        }
      }
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
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.photo_size_select_actual_rounded,
                            color: AppColors.mainColorBlue,
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
                            Navigator.pop(context);
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
                            color: AppColors.mainColorBlue,
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
      backgroundColor: AppColors.StatusBarColor,
      body: Stack(
        children: [
          SizedBox(
            height: 18,
          ),
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.mainColorBlue,
                  ),
                ),
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 350),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: _image == null
                          ? InkWell(
                              onTap: _showModalSheet,
                              child: Container(
                                height: 200,
                                width: 180,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.gray,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(120),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: AppColors.mainColorBlue,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: _showModalSheet,
                              child: SizedBox(
                                width: 200,
                                height: 200,
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
                                            color: AppColors.mainColorBlue,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign in ',
                          style: TextStyle(
                              color: Colors.transparent,
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w700),
                        ),
                        Obx(
                          () => (isloading.value == true)
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  child: Obx(
                                    () => (isloading.value == true)
                                        ? CircularProgressIndicator(
                                            color: AppColors.mainColorBlue,
                                          )
                                        : SizedBox(),
                                  ),
                                )
                              : SizedBox(),
                        ),
                        const Text(
                          'Sign in ',
                          style: TextStyle(
                              color: Colors.transparent,
                              fontSize: TextSize.header1,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    //   height: 40,
                    //   width: size.width,
                    //   child: TextField(
                    //     controller: _Country,
                    //     decoration: textFielDecoratiom.copyWith(
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(18)),
                    //         borderSide:
                    //             BorderSide(color: AppColors.purple, width: 1.5),
                    //       ),
                    //       prefixIcon: const Icon(
                    //         Icons.location_on_rounded,
                    //         color: AppColors.purple,
                    //       ),
                    //     ),
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const Row(
                    //   children: [
                    //     Text(
                    //       'City',
                    //       style: TextStyle(
                    //           fontSize: 13,
                    //           color: AppColors.grayText,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 40,
                    //   width: size.width,
                    //   child: TextField(
                    //     controller: _City,
                    //     keyboardType: TextInputType.number,
                    //     decoration: textFielDecoratiom.copyWith(
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(18)),
                    //         borderSide:
                    //             BorderSide(color: AppColors.purple, width: 1.5),
                    //       ),
                    //       prefixIcon: const Icon(
                    //         Icons.location_on_rounded,
                    //         color: AppColors.purple,
                    //       ),
                    //     ),
                    //     onChanged: (value) {},
                    //   ),
                    // ),

                    //   height: 40,
                    //   width: size.width,
                    //   child: TextField(
                    //     controller: _Address,
                    //     keyboardType: TextInputType.number,
                    //     decoration: textFielDecoratiom.copyWith(
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(18)),
                    //         borderSide:
                    //             BorderSide(color: AppColors.purple, width: 1.5),
                    //       ),
                    //       prefixIcon: const Icon(
                    //         Icons.location_on_rounded,
                    //         color: AppColors.purple,
                    //       ),
                    //     ),
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // Text(
                    //   errorText,
                    //   style: const TextStyle(color: Colors.red),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 110,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            if (photo != null) {
                              _uploadImageToFirebase(photo!);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please choose image",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromARGB(255, 158, 165, 174),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: CustomButton(
                            text: 'Save',
                            textColor: AppColors.backgroundgrayColor,
                            backgroundColor: AppColors.mainColorBlue,
                            widthPercent: size.width,
                          ),
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
