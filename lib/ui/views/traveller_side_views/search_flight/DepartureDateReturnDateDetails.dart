// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';

class DepartureDateReturnDateDetails extends StatefulWidget {
  final Function(String) onDateSelected;
  final Rx<DateTime> Departure_date;
  final Rx<DateTime> Return_date;
  final TextEditingController datecontroller;
  final TextEditingController returnDateController;
  const DepartureDateReturnDateDetails({
    super.key,
    required this.onDateSelected,
    required this.Departure_date,
    required this.Return_date,
    required this.datecontroller,
    required this.returnDateController,
  });

  @override
  State<DepartureDateReturnDateDetails> createState() =>
      _CheckInCheckOutDetailsState();
}

class _CheckInCheckOutDetailsState
    extends State<DepartureDateReturnDateDetails> {
  DateTime minDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Depature Date',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                DateTime? newDepartureDate = await showDatePicker(
                    context: context,
                    initialDate: widget.Departure_date.value,
                    firstDate: minDate,
                    lastDate: DateTime(2026));

                if (newDepartureDate != null) {
                  setState(
                    () {
                      setState(
                          () => widget.Departure_date.value = newDepartureDate);
                      if (widget.Return_date.value.isBefore(newDepartureDate)) {
                        widget.Return_date.value = newDepartureDate;
                        widget.returnDateController.text =
                            widget.datecontroller.text;
                        String formattedDate =
                            '${widget.Departure_date.value.month}/${widget.Departure_date.value.day}';
                        widget.onDateSelected(formattedDate);
                      }
                      if (widget.Return_date.value.isAfter(newDepartureDate)) {
                        String formattedDate =
                            '${widget.Departure_date.value.month}//${widget.Departure_date.value.day}';
                        widget.onDateSelected(formattedDate);
                      }
                    },
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: size.width / 2 - 20,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_month_rounded, color: AppColors.gold),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.Departure_date.value.day}. ${widget.Departure_date.value.month}, ${widget.Departure_date.value.year}',
                      style: TextStyle(
                          fontSize: TextSize.header2,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Return Date',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grayText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
            InkWell(
              onTap: () async {
                DateTime? newReturnDate = await showDatePicker(
                    context: context,
                    initialDate: widget.Return_date.value,
                    firstDate: widget.Departure_date.value,
                    lastDate: DateTime(2026));
                if (newReturnDate != null) {
                  setState(() {
                    widget.Return_date.value = newReturnDate;
                    widget.returnDateController.text =
                        '${widget.Return_date.value.day}. ${widget.Return_date.value.month}, ${widget.Return_date.value.year} ';
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: size.width / 2 - 20,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_rounded, color: AppColors.gold),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.Return_date.value.day}. ${widget.Return_date.value.month}, ${widget.Return_date.value.year}',
                      style: TextStyle(
                          fontSize: TextSize.header2,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
