import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagename;
  const CustomImage({super.key, required this.imagename});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/image/png/$imagename.png');
;
  }
}