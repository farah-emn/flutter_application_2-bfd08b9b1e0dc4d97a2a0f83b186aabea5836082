// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_home_screen.dart';
// import 'package:traveling/ui/views/hotel_side_views/map_view.dart';

class HotelSignUpImageView extends StatefulWidget {
  const HotelSignUpImageView({super.key});

  @override
  _HotelSignUpImageViewState createState() => _HotelSignUpImageViewState();
}

class _HotelSignUpImageViewState extends State<HotelSignUpImageView> {
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
      // var Firebase_Storage = FirebaseStorage.instance.ref(imagename);
      // await Firebase_Storage.putFile(file);
      // String url = await Firebase_Storage.getDownloadURL();
      FirebaseDatabase.instance.ref("Hotel").child(AirelineCompanyId).update({
        "image": url,
        "location": '${_City.text}, ${_Country.text}',
        "address": '${_Address.text}'
      });
      Get.offAll(HoteltHome());
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

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
              child: _image == null
                  ? Container(
                      width: size.width,
                      height: 50,
                    )
                  : SizedBox(
                      width: size.width - 40,
                      height: size.height / 4,
                      child: _image != null
                          ? Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    )),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              // Get.to(MapView(
              //   onLocationSelected: (newLocality, newStreet, newCountry) {
              //     setState(() {
              //       _City.text = newLocality;
              //       _Address.text = newStreet;
              //       _Country.text = newCountry;
              //     });
              //   },
              // ));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Show on map',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Country',
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grayText,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 45,
            width: size.width - 50,
            child: TextField(
              controller: _Country,
              decoration: textFielDecoratiom.copyWith(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightPurple,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
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
            height: 30,
          ),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
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
            height: 45,
            width: size.width - 50,
            child: TextField(
              controller: _City,
              keyboardType: TextInputType.number,
              decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.lightPurple,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    color: AppColors.purple,
                  )),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
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
            height: 45,
            width: size.width - 50,
            child: TextField(
              controller: _Address,
              keyboardType: TextInputType.number,
              decoration: textFielDecoratiom.copyWith(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.lightPurple,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    color: AppColors.purple,
                  )),
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       // if (photo != null) {
          //       //   _uploadImageToFirebase(photo!);
          //       //   Get.offAll(HoteltHome());
          //       // } else {
          //       //   Fluttertoast.showToast(
          //       //       msg: "Please choose image",
          //       //       toastLength: Toast.LENGTH_SHORT,
          //       //       gravity: ToastGravity.BOTTOM,
          //       //       timeInSecForIosWeb: 1,
          //       //       backgroundColor: const Color.fromARGB(255, 158, 165, 174),
          //       //       textColor: Colors.white,
          //       //       fontSize: 16.0);
          //       // }
          //     },
          //     child: Text('Save')),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text('Pick from gallery'),
                  onPressed: () async {
                    photo =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      _image = photo;
                    });

                    if (photo != null) {
                      _uploadImageToFirebase(photo!);
                    }
                  }),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text('Capture from camera'),
                onPressed: () async {
                  // PermissionStatus cameraPermission =
                  //     await Permission.camera.status;
                  // if (!cameraPermission.isGranted) {
                  //   cameraPermission = await Permission.camera.request();
                  // }
                  // if (cameraPermission.isGranted) {
                  //   photo = await _picker.pickImage(source: ImageSource.camera);
                  //   setState(() {
                  //     _image = photo;
                  //   });
                  // } else {
                  //   print("Camera permission is not granted");
                  // }
                },
              ),
              // SizedBox(
              //   height: size.height - 600,
              // ),
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
                    text: 'Confirm location',
                    textColor: AppColors.backgroundgrayColor,
                    backgroundColor: AppColors.purple,
                    widthPercent: size.width,
                    heightPercent: 15),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       if (photo != null) {
              //         _uploadImageToFirebase(photo!);
              //         Get.offAll(HoteltHome());
              //       } else {
              //         Fluttertoast.showToast(
              //             msg: "Please choose image",
              //             toastLength: Toast.LENGTH_SHORT,
              //             gravity: ToastGravity.BOTTOM,
              //             timeInSecForIosWeb: 1,
              //             backgroundColor:
              //                 const Color.fromARGB(255, 158, 165, 174),
              //             textColor: Colors.white,
              //             fontSize: 16.0);
              //       }
              //     },
              //     child: Text('Save'))
            ],
          )
        ],
      ),
    );
  }
}
