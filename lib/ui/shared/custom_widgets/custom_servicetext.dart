import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/utils.dart';

class CustomServiceText extends StatelessWidget {
  final String text;
  const CustomServiceText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth(25),
        fontWeight: FontWeight.w500
      ),
    );
  }
}