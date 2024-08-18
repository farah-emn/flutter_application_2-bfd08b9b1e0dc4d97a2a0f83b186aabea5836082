// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, library_private_types_in_public_api, deprecated_member_use, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, unused_import, avoid_print
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/search_oneway_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textgray.dart';
import 'package:traveling/ui/shared/custom_widgets/tab_item.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_explore_view.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_info_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/DepartureDateReturnDateDetails.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_arrival_city_round.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_oneway.dart';
import 'package:traveling/ui/views/traveller_side_views/search_flight/list_departure_city_round.dart';

import '../../../../controllers/hotel_search_controller.dart';
import 'departure_date_arrival_date.dart';
import 'list_destonation_hotel.dart';
// import 'package:traveling/ui/views/traveller_side_views/traveller_details_view/traveller_details_view2.dart';

class SearchHotelView extends StatefulWidget {
  String? Destination;
  var lastFlightKey = ''.obs;

  SearchHotelView({this.Destination, Key? key}) : super(key: key);

  @override
  SearchHotelViewState createState() => SearchHotelViewState();
}

class SearchHotelViewState extends State<SearchHotelView> {
  final TextEditingController DeparturedateController = TextEditingController();
  final TextEditingController ArrivalDateController = TextEditingController();

  void _handleDateSelection(String dateText) {
    controller.updateSelectedDate();
    DeparturedateController.text = dateText;
  }

  final SearchHotelController controller = Get.put(SearchHotelController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _searchForHotel() async {
    if (widget.Destination != null) {
      controller.setDestnation(widget.Destination!);
    }
    if (controller.Destnation.value != '') {
      controller.searchForHotel();
    } else {
      controller.isloading.value = false;
      Fluttertoast.showToast(
          msg: "Please select all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
      ),
      Stack(
        children: [
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Destonation',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                width: size.width,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: AppColors.gray,
                    foregroundColor: Colors.black, elevation: 0,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: AppColors.LightGrayColor, width: 1),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListDestonationHotel(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        widget.Destination = result['Destination'];
                      });
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_rounded, color: AppColors.purple),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.Destination ?? '',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DepartureDateArrivalDateDetails(
                  onDateSelected: _handleDateSelection,
                  DepartureDate: controller.departureDate,
                  ArrivalDate: controller.ArrivalDate,
                  DeparturedateController: DeparturedateController,
                  ArrivalDateController: ArrivalDateController),
              SizedBox(
                height: 20,
              ),
              Row(
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
                            'Adult Number',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        width: size.width / 2 - 20,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.LightGrayColor, width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.group, color: AppColors.purple),
                            SizedBox(
                              width: 10,
                            ),
                            GetBuilder<SearchHotelController>(
                              init: SearchHotelController(),
                              builder: (controller) {
                                return Text(
                                  '${controller.Adultcounter} Adult',
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      fontWeight: FontWeight.w500),
                                );
                              },
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.incrementAdult();
                                  },
                                  child: Icon(Icons.arrow_drop_up_sharp,
                                      color: AppColors.purple, size: 20),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.decrementAdult();
                                  },
                                  child: Icon(Icons.arrow_drop_down_sharp,
                                      color: AppColors.purple, size: 20),
                                ),
                              ],
                            )
                          ],
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
                            'Children Number',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        width: size.width / 2 - 20,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.LightGrayColor, width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.group, color: AppColors.purple),
                            SizedBox(
                              width: 10,
                            ),
                            GetBuilder<SearchHotelController>(
                              init: SearchHotelController(),
                              builder: (controller) {
                                return Text(
                                  '${controller.Childcounter} Children',
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      fontWeight: FontWeight.w500),
                                );
                              },
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.incrementChild();
                                  },
                                  child: Icon(Icons.arrow_drop_up_sharp,
                                      color: AppColors.purple, size: 20),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.decrementChild();
                                  },
                                  child: Icon(Icons.arrow_drop_down_sharp,
                                      color: AppColors.purple, size: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: _searchForHotel,
                child: CustomButton(
                  text: 'Search',
                  textColor: AppColors.backgroundgrayColor,
                  backgroundColor: AppColors.lightPurple,
                  widthPercent: size.width,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 20,
                height: 20,
                child: Obx(
                  () => (controller.isloading.value == true)
                      ? CircularProgressIndicator(
                          color: AppColors.purple,
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
