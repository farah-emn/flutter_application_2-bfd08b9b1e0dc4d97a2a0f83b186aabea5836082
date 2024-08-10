import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final RegExp regExp = RegExp(r'^[a-zA-Z\s]*$');
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
