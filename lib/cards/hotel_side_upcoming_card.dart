import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel_bookings_class.dart';
import 'package:traveling/classes/hotel_side_upcoming_class.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_button.dart';
import 'package:traveling/ui/shared/text_size.dart';

import '../classes/hotel_side_upcoming_class1.dart';
import '../controllers/currency_controller.dart';

class HotelSideUpcomingCard extends StatefulWidget {
  const HotelSideUpcomingCard({
    super.key,
    required this.size,
    required this.hotelBookingsDetails2,
    required this.itemIndex,
  });

  final Size size;
  final HotelSideBookingsClass1 hotelBookingsDetails2;
  final int itemIndex;

  @override
  State<HotelSideUpcomingCard> createState() => _HotelSideUpcomingCardState();
}

class _HotelSideUpcomingCardState extends State<HotelSideUpcomingCard> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late User loggedinUser;
  String CompanyName = '';
  late final User? user;
  late DatabaseReference ref;
  var Companyimage;
  String HotelName = '';
  var HotelPhoto;
  var HotelId = '';
  var CompanyId = '';
  double incoming = 0.0;
  int ReservedRooms = 0;
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Hotel');
    user = _auth.currentUser;
    getData();

    super.initState();
  }

  void getData() async {
    CompanyId = user!.uid.toString();
    final event = await ref.child(CompanyId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    if (mounted) {
      setState(() {
        CompanyName = userData['HotelName'];
        Companyimage = userData['image'];
      });
    }
  }

  CurrencyController currencyController = Get.put(CurrencyController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      // onTap: () {
      //   Get.to(
      //     RoomView(),
      //   );
      // },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: List.filled(
            10,
            const BoxShadow(
                color: AppColors.gray,
                blurRadius: BorderSide.strokeAlignOutside,
                blurStyle: BlurStyle.outer),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: widget.size.width - 30,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  width: widget.size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.hotelBookingsDetails2.image != null &&
                                  widget.hotelBookingsDetails2.image.isNotEmpty
                              ? widget.hotelBookingsDetails2.image
                              : ''),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                  widget.hotelBookingsDetails2.customerName ??
                                      '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: TextSize.header1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.email_rounded,
                                color: AppColors.gold,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.hotelBookingsDetails2.email ?? '',
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: size.width - 60,
                        height: 1,
                        color: AppColors.LightGrayColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 2 - 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Check In',
                              style: TextStyle(
                                  fontSize: TextSize.header2,
                                  color: AppColors.grayText),
                            ),
                            Text(
                              widget.hotelBookingsDetails2.checkinDate,
                              style: const TextStyle(
                                  fontSize: TextSize.header2,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width / 2 - 40,
                        child: Row(
                          children: [
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.LightGrayColor,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Check Out',
                                  style: TextStyle(
                                      fontSize: TextSize.header2,
                                      color: AppColors.grayText),
                                ),
                                Text(
                                  widget.hotelBookingsDetails2.checkoutDate,
                                  style: const TextStyle(
                                      fontSize: TextSize.header2,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: size.width - 60,
                        height: 1,
                        color: AppColors.LightGrayColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Room Number:",
                        style: TextStyle(
                            color: AppColors.grayText,
                            fontSize: TextSize.header2),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.hotelBookingsDetails2.roomNumber,
                        style: const TextStyle(
                            fontSize: TextSize.header2,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                            color: AppColors.grayText,
                            fontSize: TextSize.header2),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${currencyController.convert(currencyController.selectedCurrency.value, widget.hotelBookingsDetails2.totalPrice.toDouble()).toString()} ${currencyController.selectedCurrency.value}',
                        style: const TextStyle(
                            color: AppColors.purple,
                            fontSize: TextSize.header1,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
