import 'package:flutter/material.dart';

import '../colors.dart';

const searchTextFielDecoratiom = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: AppColors.TextgrayColor),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    borderSide: BorderSide(color: AppColors.backgroundgrayColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    borderSide: BorderSide(
      color: Colors.white,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    borderSide: BorderSide(color: AppColors.mainColorBlue, width: 1.5),
  ),
);
