// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';

class DepartureDateArrivalDateDetails extends StatefulWidget {
  final Function(String) onDateSelected;
  final Rx<DateTime> ArrivalDate;
  final Rx<DateTime> DepartureDate;
  final TextEditingController DeparturedateController;
  final TextEditingController ArrivalDateController;
  const DepartureDateArrivalDateDetails({
    super.key,
    required this.onDateSelected,
    required this.ArrivalDate,
    required this.DepartureDate,
    required this.ArrivalDateController,
    required this.DeparturedateController,
  });

  @override
  State<DepartureDateArrivalDateDetails> createState() =>
      _DepartureDateArrivalDateDetailsState();
}

class _DepartureDateArrivalDateDetailsState
    extends State<DepartureDateArrivalDateDetails> {
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
                  'Arrival Date',
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
                    initialDate: widget.ArrivalDate.value,
                    firstDate: minDate,
                    lastDate: DateTime(2026));

                if (newDepartureDate != null) {
                  setState(
                    () {
                      widget.ArrivalDate.value = newDepartureDate;
                      // Add one day to the newDepartureDate
                      DateTime nextDay =
                          newDepartureDate.add(Duration(days: 1));
                      widget.DepartureDate.value = nextDay;

                      String formattedDate =
                          '${widget.DepartureDate.value.day}. ${widget.DepartureDate.value.month},${widget.DepartureDate.value.year}';
                      widget.onDateSelected(formattedDate);
                    },
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: size.width / 2 - 20,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.LightGrayColor, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_month_rounded, color: AppColors.purple),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.ArrivalDate.value.day}. ${widget.ArrivalDate.value.month}, ${widget.ArrivalDate.value.year}',
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
                  'Departure Date',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                DateTime firstDate =
                    widget.ArrivalDate.value.add(Duration(days: 1));
                DateTime initialDate =
                    widget.DepartureDate.value.isBefore(firstDate)
                        ? firstDate
                        : widget.DepartureDate.value;

                DateTime? newReturnDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: firstDate,
                    lastDate: DateTime(2026));
                if (newReturnDate != null) {
                  setState(() {
                    widget.DepartureDate.value = newReturnDate;
                    widget.DeparturedateController.text =
                        '${widget.DepartureDate.value.day}. ${widget.DepartureDate.value.month}, ${widget.DepartureDate.value.year} ';
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: size.width / 2 - 20,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.LightGrayColor, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_rounded, color: AppColors.purple),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.DepartureDate.value.day}. ${widget.DepartureDate.value.month}, ${widget.DepartureDate.value.year}',
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
