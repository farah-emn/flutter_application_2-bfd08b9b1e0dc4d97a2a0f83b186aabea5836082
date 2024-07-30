// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';

class DepartureDateDetails extends StatefulWidget {
  final Function(String) onDateSelected;
  final Rx<DateTime> Departure_date;
  final TextEditingController datecontroller;
  const DepartureDateDetails({
    super.key,
    required this.onDateSelected,
    required this.Departure_date,
    required this.datecontroller,
  });

  @override
  State<DepartureDateDetails> createState() => _CheckInCheckOutDetailsState();
}

class _CheckInCheckOutDetailsState extends State<DepartureDateDetails> {
  DateTime minDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        DateTime? newDepartureDate = await showDatePicker(
            context: context,
            initialDate: widget.Departure_date.value,
            firstDate: minDate,
            lastDate: DateTime(2026));

        if (newDepartureDate != null) {
          setState(
            () {
              setState(() => widget.Departure_date.value = newDepartureDate);
            },
          );
        }
      },
      child: Container(
        width: size.width / 2 - 20,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.calendar_month_rounded, color: AppColors.gold),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.Departure_date.value.day}. ${widget.Departure_date.value?.month}, ${widget.Departure_date.value?.year}',
                  style: TextStyle(
                    fontSize: TextSize.header2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
