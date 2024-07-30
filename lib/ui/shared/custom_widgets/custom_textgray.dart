import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/utils.dart';

class CustomTextGray extends StatefulWidget {
  final String mainText;
  const CustomTextGray({super.key, required this.mainText});

  @override
  State<CustomTextGray> createState() => _CustomTextGrayState();
}

class _CustomTextGrayState extends State<CustomTextGray> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.mainText,
      style: TextStyle(
        color: AppColors.TextgrayColor,
        fontSize: screenWidth(25) 
      ),
    );
  }
}