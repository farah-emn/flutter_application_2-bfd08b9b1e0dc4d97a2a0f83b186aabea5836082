// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:get/get.dart';

enum BaggageOption { option15kg, option20kg, option25kg }

class TravellerDetailsView1Controller extends GetxController {
  var AdultList = <dynamic>[].obs;
  var BaggageAdult = <dynamic>[].obs;
  var ChildList = <dynamic>[].obs;
  var BaggageChild = <dynamic>[].obs;
  var _EmailContactDetails = ''.obs;
  get EmailContactDetails => _EmailContactDetails;
  var _MobileNumberContactDetails = ''.obs;
  get MobileNumberContactDetails => _MobileNumberContactDetails;
  var _FirstNameContactDetails = ''.obs;
  get FirstNameContactDetails => _FirstNameContactDetails;
  var _LastNameContactDetails = ''.obs;
  get LastNameContactDetails => _LastNameContactDetails;
  void addBaggageAdult(dynamic result) {
    BaggageAdult.add(result);
  }

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

  void addBaggageChild(dynamic baggage) {
    BaggageChild.add(baggage);
  }

  void clearData() {
    AdultList.clear();
    BaggageAdult.clear();
    ChildList.clear();
    BaggageChild.clear();
    _EmailContactDetails = ''.obs;
    _MobileNumberContactDetails = ''.obs;
    _FirstNameContactDetails = ''.obs;
    _LastNameContactDetails = ''.obs;

    update();
  }
}
