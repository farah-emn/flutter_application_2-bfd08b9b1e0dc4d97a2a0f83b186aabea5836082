import 'package:flutter/material.dart';

import '../colors.dart';

const textFielDecoratiom = InputDecoration(
  // hintStyle: TextStyle(fontSize: 15, color: AppColors.TextgrayColor),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(color: Colors.red, width: 1.5),
  ),
  prefixIconColor: AppColors.mainColorBlue,
  filled: true,
  fillColor: AppColors.backgroundgrayColor,
  labelStyle: TextStyle(fontSize: 18, color: AppColors.grayText),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(
      color: AppColors.TextgrayColor,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(color: AppColors.mainColorBlue, width: 1.5),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(color: AppColors.grayText),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(color: Colors.red, width: 1.5),
  ),
);
