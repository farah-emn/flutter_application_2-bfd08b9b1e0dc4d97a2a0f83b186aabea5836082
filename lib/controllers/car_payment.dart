// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unused_local_variable, avoid_print, unused_element, unnecessary_brace_in_string_interps
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/currency_controller.dart';

class CarStep3paymentController extends GetxController {
  CurrencyController currencyController = Get.find<CurrencyController>();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController MMexpiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController YYexpiryDateController = TextEditingController();
  var errorTextcardHolder = ''.obs;
  var errorTextMMexpiryDate = ''.obs;
  var errorTextcardNumber = ''.obs;
  var errorTextcvv = ''.obs;
  var errorTextYYexpiryDate = ''.obs;
  double totalPriceTicketFlight = 0;
  var isloading = false.obs;

  String Currency = 'USD';
  final List<String> currencies = [
    'AED',
    'KWD',
    'BHD',
    'EUR',
    'GBP',
    'USD',
    'INR',
    'OMR'
  ];

  Future<bool> validateCreditCard(num price) async {
    isloading.value = true;
    if (cardNumberController.text!.length < 10) {
      errorTextcardNumber.value = 'Please enter valid Card Number';
    } else {
      errorTextcardNumber.value = '';
    }
    if (cardHolderController.text!.length < 3) {
      errorTextcardHolder.value = 'Please enter valid Name of card holder';
    } else {
      errorTextcardHolder.value = '';
    }
    final RegExp regex = RegExp(r'^\d{2}/\d{2}$');

    if (MMexpiryDateController == null || MMexpiryDateController.text.isEmpty) {
      errorTextMMexpiryDate.value = 'Expiry date (MM) is required';
    } else {
      errorTextMMexpiryDate.value = '';
    }
    if (!regex.hasMatch(MMexpiryDateController.text)) {
      errorTextMMexpiryDate.value == 'Please enter valid Expiry date (MM) ';
    } else {
      errorTextMMexpiryDate.value = '';
    }
    if (YYexpiryDateController == null || YYexpiryDateController.text.isEmpty) {
      errorTextYYexpiryDate.value = 'Expiry date (YY) is required';
    } else {
      errorTextYYexpiryDate.value = '';
    }
    if (!regex.hasMatch(YYexpiryDateController.text)) {
      errorTextYYexpiryDate == 'Please enter valid Expiry date (YY) ';
    } else {
      errorTextYYexpiryDate.value = '';
    }
    if (cvvController.text.length < 3) {
      errorTextcvv.value = 'Please enter a valid CVV';
    } else {
      errorTextcvv.value = '';
    }
    if (errorTextMMexpiryDate.value.isEmpty &&
        errorTextYYexpiryDate.value.isEmpty &&
        errorTextcardHolder.value.isEmpty &&
        errorTextcardNumber.value.isEmpty &&
        errorTextcvv.value.isEmpty) {
      var collection = FirebaseFirestore.instance.collection('CreditCard');
      var docSnapshots = await collection.get();
      for (var docSnapshot in docSnapshots.docs) {
        Map<String, dynamic>? data = docSnapshot.data();
        if (data['CardNumber'] == cardNumberController.text &&
            _getFormattedExpiryDateMM(data['expiryDate']) ==
                MMexpiryDateController.text &&
            _getFormattedExpiryDateYY(data['expiryDate']) ==
                YYexpiryDateController.text &&
            data['cvvCode'] == cvvController.text &&
            data['balance'] >= price &&
            data['cardholder name'] == cardHolderController.text) {
          await docSnapshot.reference.update({'balance': data['balance']});
          isloading.value = false;

          return true;
        }
      }
    }
    return false;
  }

  String _getFormattedExpiryDateMM(String expiryDate) {
    final List<String> parts = expiryDate.split('/');
    if (parts.length >= 2) {
      final String expiryMonth = parts[0];
      return '$expiryMonth';
    } else {
      return '';
    }
  }

  String _getFormattedExpiryDateYY(String expiryDate) {
    final List<String> parts = expiryDate.split('/');
    if (parts.length >= 2) {
      // final String expiryMonth = parts[0];
      final String expiryYear = parts[1];
      return '$expiryYear';
    } else {
      return '';
    }
  }

  void clearData() {
    cardHolderController.clear();
    cardNumberController.clear();
    MMexpiryDateController.clear();
    YYexpiryDateController.clear();
    cvvController.clear();
    // Currency = 'USD';
    update();
  }
}
