import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    this.borderColor,
    required this.widthPercent,
    required this.backgroundColor,
  });

  final String text;
  final double widthPercent;
  final Color? borderColor;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthPercent,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: TextSize.header2),
        ),
      ),
    );
  }
}
