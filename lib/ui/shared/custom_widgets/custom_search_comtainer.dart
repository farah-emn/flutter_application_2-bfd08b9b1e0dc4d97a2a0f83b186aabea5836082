import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';

class CustomSearchContainer extends StatelessWidget {
  const CustomSearchContainer({super.key, 
  required this.widthPercent,
 required this.heightPercent,
  required this.icon,
   required this.text, required this.boldtext,
   required this.IconColor});
  final double widthPercent;
  final double heightPercent;
   final IconData? icon;
   final String text;
   final String boldtext;
   final Color IconColor;
   
  @override
  Widget build(BuildContext context) {
    return Container(
                          width: screenWidth(widthPercent),
                          height: screenWidth(heightPercent),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                         child: Padding(
                           padding:  EdgeInsetsDirectional.only(start: screenWidth(30),top: screenWidth(50),),
                           child: Row(
                            
                            children: [
                           Icon(icon, color: IconColor,),
                           SizedBox(width: screenWidth(30),),
                           Column(
                            children: [
                              CustomTextGray(mainText: text),
                              Text(boldtext,
                              style: TextStyle(
                                fontSize: screenWidth(25),
                                fontWeight: FontWeight.w500
                              ),
                              )
                            ],
                           )
                            ],
                           ),
                         ),
                         );
  }
}