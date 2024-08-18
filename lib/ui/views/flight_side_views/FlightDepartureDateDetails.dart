// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/flight_add_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/utils.dart';

class DepartureDateArrivalDateDetails extends StatefulWidget {
  final Function(String) onDateSelected;
  final Rx<DateTime> Departure_date;
  final TextEditingController datecontroller;
  final Rx<DateTime> Return_date;
  final TextEditingController returnDateController;
  const DepartureDateArrivalDateDetails({
    super.key,
    required this.onDateSelected,
    required this.Departure_date,
    required this.datecontroller,
    required this.Return_date,
    required this.returnDateController,
  });

  @override
  State<DepartureDateArrivalDateDetails> createState() =>
      _CheckInCheckOutDetailsState();
}

class _CheckInCheckOutDetailsState
    extends State<DepartureDateArrivalDateDetails> {
  final FlightAddController FlightAdd_Controller =
      Get.put(FlightAddController());
  DateTime minDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: [
          SizedBox(
            height: 45,
            width: size.width / 2 - 15,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                backgroundColor: Colors.white,
              ),
              onPressed: () async {
                FlightAdd_Controller.newDepartureDate = await showDatePicker(
                    context: context,
                    initialDate: widget.Departure_date.value,
                    firstDate: minDate,
                    lastDate: DateTime(2026));

                if (FlightAdd_Controller.newDepartureDate != null) {
                  setState(() {
                    setState(() => widget.Departure_date.value =
                        FlightAdd_Controller.newDepartureDate!);
                    if (widget.Return_date.value
                        .isBefore(FlightAdd_Controller.newDepartureDate!)) {
                      widget.Return_date.value =
                          FlightAdd_Controller.newDepartureDate!;
                      widget.returnDateController.text =
                          widget.datecontroller.text;
                      String formattedDate =
                          '${widget.Departure_date.value.month}/${widget.Departure_date.value.day}';
                      widget.onDateSelected(formattedDate);
                    }
                    if (widget.Return_date.value
                        .isAfter(FlightAdd_Controller.newDepartureDate!)) {
                      String formattedDate =
                          '${widget.Departure_date.value.month}/${widget.Departure_date.value.day}';
                      widget.onDateSelected(formattedDate);
                    }
                  });
                }
              },
              child: SizedBox(
                height: 45,
                width: size.width / 2 - 15,
                // decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range_rounded,
                              color: AppColors.mainColorBlue),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // CustomTextGray(mainText: 'Departure date'),
                              (FlightAdd_Controller.newDepartureDate != null)
                                  ? Text(
                                      '${widget.Departure_date.value.day ?? ''}. ${widget.Departure_date.value?.month ?? ''}, ${widget.Departure_date.value?.year ?? ""}' ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // SizedBox(
                      //   width: size.width / 2 - 15,
                      //   height: 2, // Give the Divider a width
                      //   child:
                      Divider(
                        height: 1,
                        color: AppColors.grayText,
                      ),
                      //      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: size.width / 2 - 15,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.white,
              ),
              onPressed: () async {
                FlightAdd_Controller.newReturnDate = await showDatePicker(
                    context: context,
                    initialDate: widget.Return_date.value,
                    firstDate: widget.Departure_date.value,
                    lastDate: DateTime(2026));
                if (FlightAdd_Controller.newReturnDate != null) {
                  setState(() {
                    widget.Return_date.value =
                        FlightAdd_Controller.newReturnDate!;
                    widget.returnDateController.text =
                        '${widget.Return_date.value.day}. ${widget.Return_date.value.month}, ${widget.Return_date.value.year} ';
                  });
                }
              },
              child: SizedBox(
                height: 45,
                width: size.width / 2 - 15,
                // decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range_rounded,
                              color: AppColors.mainColorBlue),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // CustomTextGray(mainText: 'Departure date'),
                              (FlightAdd_Controller.newReturnDate != null)
                                  ? Text(
                                      '${widget.Return_date.value.day ?? ''}. ${widget.Return_date.value?.month ?? ''}, ${widget.Return_date.value?.year ?? ""}' ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // SizedBox(
                      //   width: size.width / 2 - 30,
                      //   height: 2, // Give the Divider a width
                      //   child: Divider(
                      //     height: 1,
                      //     color: AppColors.grayText,
                      //   ),
                      // ),
                      Container(
                        width: size.width / 2 - 30,
                        height: 0.5,
                        color: AppColors.grayText,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
