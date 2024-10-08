// ignore_for_file: prefer_const_constructors, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import '../../shared/colors.dart';

class CarPhotos extends StatefulWidget {
  List<String>? carPhotos;
  CarPhotos({super.key, required this.carPhotos});
  @override
  State<CarPhotos> createState() => _CarPhotosState();
}

class _CarPhotosState extends State<CarPhotos> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(
                      widget.carPhotos![selectedIndex],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  left: -14,
                  bottom: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      color: AppColors.purple,
                    ),
                    onPressed: () {
                      setState(() {
                        if (selectedIndex > 0) {
                          selectedIndex--;
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  right: -14,
                  bottom: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: AppColors.purple,
                    ),
                    onPressed: () {
                      setState(() {
                        if (selectedIndex < widget.carPhotos!.length - 1) {
                          selectedIndex++;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.carPhotos!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedIndex == index
                            ? Colors.purple
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Image.network(widget.carPhotos![index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
