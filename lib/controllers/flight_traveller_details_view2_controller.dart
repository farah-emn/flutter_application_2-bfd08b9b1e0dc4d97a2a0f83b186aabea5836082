// ignore_for_file: unused_local_variable, unnecessary_string_interpolations, avoid_print, constant_identifier_names, curly_braces_in_flow_control_structures, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Gender { Famle, Male }

class TravellerDetailsView2Controller extends GetxController {
  late GlobalKey<FormState> formKey;
  final RxString formValue = ''.obs;
  var _gender = ''.obs;
  get gender => _gender;

  var _Nationality = ''.obs;
  get Nationality => _Nationality;

  var _issuingcountry = ''.obs;
  get issuingcountry => _issuingcountry;

  var _birthdateDay = ''.obs;
  get birthdateDay => _birthdateDay;

  var _birthdateMonth = ''.obs;
  get birthdateMonth => _birthdateMonth;

  var _birthdateYear = ''.obs;
  get birthdateYear => _birthdateYear;

  var _expiredateDay = ''.obs;
  get expiredateDay => _expiredateDay;

  var _expiredateMonth = ''.obs;
  get expiredateMonth => _expiredateMonth;

  var _expiredateYear = ''.obs;
  get expiredateYear => _expiredateYear;
  bool validateForm() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void setgender(String value) {
    if (value == 'F') {
      _gender.value = 'Famale';
    } else if (value == 'M') {
      _gender.value = 'Male';
    } else if (value == 'gender') {
      _gender.value = 'gender';
    }

    update();
  }

  void setNationality(String value) {
    _Nationality.value = value;
    update();
  }

  void setissuingcountry(String value) {
    _issuingcountry.value = value;
    update();
  }

  void setbirthdateDay(String value) {
    _birthdateDay.value = value;

    update();
  }

  void setbirthdateMonth(String value) {
    _birthdateMonth.value = value;

    update();
  }

  void setbirthdateYear(String value) {
    _birthdateYear.value = value;

    update();
  }

  void setexpiredateDay(String value) {
    _expiredateDay.value = value;

    update();
  }

  void setexpiredateMonth(String value) {
    _expiredateMonth.value = value;

    update();
  }

  void setexpiredateYear(String value) {
    _expiredateYear.value = value;

    update();
  }

  String getFormattedCountry(String country) {
    final List<String> parts = country.split(' ');
    String countryCode = parts[0];
    return countryCode;
  }

  String getFormattedCountrySymbol(String country) {
    final List<String> parts = country.split(' ');
    String countryCode = parts[1];
    return countryCode;
  }

  String getFormattedDateYear(String date) {
    String year = '';

    final DateFormat inputFormat = DateFormat('yyyy/M/d');
    final List<String> parts = date.split('/');
    if (parts.length >= 2) {
      year = parts[0];
    }
    DateTime dateTime;
    try {
      dateTime = inputFormat.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
    print(parts[2]);

    return '$year';
  }

  String getFormattedDateMonth(String date) {
    String month = '';
    final DateFormat inputFormat = DateFormat('yyyy/M/d');
    final List<String> parts = date.split('/');
    if (parts.length >= 2) {
      month = parts[1];
    }
    DateTime dateTime;
    try {
      dateTime = inputFormat.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }

    return '$month';
  }

  String getFormattedDateDay(String date) {
    String day = '';
    final DateFormat inputFormat = DateFormat('yyyy/M/d');

    final List<String> parts = date.split('/');
    if (parts.length >= 2) {
      day = parts[2];
    }

    DateTime dateTime;
    try {
      dateTime = inputFormat.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }

    return '$day';
  }

  void clearData() {
    _gender = ''.obs;
    _Nationality = ''.obs;
  }

  @override
  void onInit() {
    super.onInit();
    setgender(''); // Reset the gender value
  }
}
