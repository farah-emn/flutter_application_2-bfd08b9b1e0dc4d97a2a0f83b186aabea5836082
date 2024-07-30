import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveling/classes/image.dart';

class ImageCard extends StatelessWidget {
  final ImageClass imageList;
  final int itemIndex;
  const ImageCard(
      {super.key, required this.imageList, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          margin: EdgeInsets.only(right: 15),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            image: DecorationImage(
              image: AssetImage(imageList.image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
