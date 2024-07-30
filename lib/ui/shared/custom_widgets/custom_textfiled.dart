import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/utils.dart';

class CustomTextField extends StatefulWidget {
  final IconData prefIcon;
  final IconData? suffIcon;
  final Color colorIcon;
  final Color? suffColor;
  final String? hintText;
  final double? maxHeight;
  final double? maxWidth;
  final TextStyle? style;
  final Color? hintTextColor;
  final Color? textColor;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator; // Add this line
  // Add this line
// Add this line // Add this line

  const CustomTextField({
    super.key,
    required this.prefIcon,
    required this.colorIcon,
    this.hintText,
    this.maxHeight,
    this.maxWidth,
    this.suffIcon,
    this.suffColor,
    this.hintTextColor,
    this.style,
    this.textColor,
    this.controller,
    this.validator, // Add this line
    // Add this line
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator, // Use the validator parameter
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxHeight: 50,
          maxWidth: widget.maxWidth ?? screenWidth(1.1),
        ),

        fillColor: AppColors.TextFieldcolor,
        filled: true,
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: BorderSide.none,
        // ),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.suffIcon != null
            ? Icon(
                widget.suffIcon,
                color: widget.suffColor,
              )
            : SizedBox(),
        prefixIcon: widget.prefIcon != null
            ? Icon(
                widget.prefIcon,
                color: widget.colorIcon,
              )
            : SizedBox(),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintTextColor ??
              AppColors.TextgrayColor, // Use the hintTextColor parameter
          // fontSize: size.width / 18,
        ),
      ),
    );
  }
}
