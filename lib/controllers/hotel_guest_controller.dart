// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:get/get.dart';

class GuestController extends GetxController {
  var AdultList = <dynamic>[].obs;
  var ChildList = <dynamic>[].obs;
  var _EmailContactDetails = ''.obs;
  get EmailContactDetails => _EmailContactDetails;
  var _MobileNumberContactDetails = ''.obs;
  get MobileNumberContactDetails => _MobileNumberContactDetails;
  var _FirstNameContactDetails = ''.obs;
  get FirstNameContactDetails => _FirstNameContactDetails;
  var _LastNameContactDetails = ''.obs;
  get LastNameContactDetails => _LastNameContactDetails;
  var errorTextEmail = ''.obs;
  var errorTextMobileNumber = ''.obs;
  var errorTextFirstName = ''.obs;
  var errorTextLastName = ''.obs;
  var errorText = ''.obs;
  void SetEmailContactDetails(String EmailContactDetails) {
    _EmailContactDetails.value = EmailContactDetails;
    update();
  }

  void SetFirstNameContactDetails(String FirstNameContactDetails) {
    _FirstNameContactDetails.value = FirstNameContactDetails;
    update();
  }

  void SetMobileNumberContactDetails(String MobileNumberContactDetails) {
    _MobileNumberContactDetails.value = MobileNumberContactDetails;
    update();
  }

  void SetLastNameContactDetails(String LastNameContactDetails) {
    _LastNameContactDetails.value = LastNameContactDetails;
    update();
  }

  void addAdult(dynamic result) {
    AdultList.add(result);
  }

  void addChild(dynamic child) {
    AdultList.add(child);
  }

  Future<bool> validateGuest() async {
    if (_EmailContactDetails.value.length == 0 &&
        _FirstNameContactDetails.value.length == 0 &&
        _LastNameContactDetails.value.length == 0 &&
        _MobileNumberContactDetails.value.length == 0) {
      errorText.value = 'Please enter all feilds';
    }
    if (_EmailContactDetails.value.length < 10 &&
        _LastNameContactDetails.value.length != 0 &&
        _MobileNumberContactDetails.value.length != 0 &&
        _MobileNumberContactDetails.value.length != 0) {
      errorTextEmail.value = 'Please enter valid a valid email';
    }
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(_EmailContactDetails.value) &&
        _LastNameContactDetails.value.length != 0 &&
        _MobileNumberContactDetails.value.length != 0 &&
        _MobileNumberContactDetails.value.length != 0) {
      errorTextEmail.value = 'Please enter a valid email';
    }

    return true;
  }

  void clearData() {
    AdultList.clear();
    ChildList.clear();
    _EmailContactDetails = ''.obs;
    _MobileNumberContactDetails = ''.obs;
    _FirstNameContactDetails = ''.obs;
    _LastNameContactDetails = ''.obs;
    update();
  }
}
