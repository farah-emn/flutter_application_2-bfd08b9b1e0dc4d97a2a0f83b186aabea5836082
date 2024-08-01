// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables, sized_box_for_whitespace

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
import 'package:traveling/ui/views/hotel_side_views/hotel_home_screen.dart';

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
  @override
  void initState() {
    super.initState();
    setState(() {
      AirelineCompany = _auth.currentUser;
      AirelineCompanyId = AirelineCompany?.uid.toString() ?? '';
    });
  }

  Future<void> _uploadImageToFirebase(XFile image) async {
    File file = File(image.path);
    var imagename = basename(image.path);
    // var Firebase_Storage = FirebaseStorage.instance.ref(imagename);
    // await Firebase_Storage.putFile(file);
    // String url = await Firebase_Storage.getDownloadURL();

    FirebaseDatabase.instance
        .ref("Hotel")
        .child(AirelineCompanyId)
        .update({"image": url});
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
            height: 300,
          ),
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (photo != null) {
                      _uploadImageToFirebase(photo!);
                      Get.offAll(HoteltHome());
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
                  child: Text('Save'))
            ],
          )
        ],
      ),
    );
  }
}
