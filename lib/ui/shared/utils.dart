import 'package:traveling/core/data/repository/post_repository.dart';
import 'package:traveling/core/data/repository/prodcut_repository.dart';
import 'package:traveling/core/data/repository/shared_prefrence_repository.dart';
import 'package:traveling/core/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isValidPassword(String password) {
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}

Future<XFile?> chooseImage(ImageSource imageSource) async {
  return await ImagePicker().pickImage(source: imageSource);
}

double screenWidth2() {
  return Get.size.width;
}
double screenHeight2() {
  return Get.size.height;
}

double screenWidth(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.width / percent;
  else
    return Get.size.height / percent;
}

double screenHeight(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.height / percent;
  else
    return Get.size.width / percent;
}

SharedPrefrenceRepository get storege => Get.find<SharedPrefrenceRepository>();
PostRepository get post => Get.find<PostRepository>();
// ConnectivityService get connectivityService => Get.find<ConnectivityService>();
// Connectivity get connectivity => Get.find<Connectivity>();
ProductRepository get productRepository => Get.find<ProductRepository>();
