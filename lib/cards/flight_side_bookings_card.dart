// ignore_for_file: must_be_immutable, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/contact_details_passenger_class.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/ui/views/flight_side_views/flight_booking_details_view.dart';
import '../ui/shared/colors.dart';

class BookingsCard extends StatefulWidget {
  BookingsCard(
      {super.key,
      required this.ContactDetailsPassengerData,
      required this.itemIndex});
  ContactDetailsClass ContactDetailsPassengerData;
  int itemIndex;

  @override
  State<BookingsCard> createState() => _BookingsCardState();
}

class _BookingsCardState extends State<BookingsCard> {
  bool? isChecked = false;
  String? sorteBy;
  User? AirelineCompany;
  final _auth = FirebaseAuth.instance;
  var AirelineCompanyId = '';
  var AirelineCompanyName = '';
  var uid;
  var currentUser;
  Map<dynamic, dynamic> PassengerAdultData = {};
  List<FlightInfoClass> flightsList = [];
  List<FlightInfoClass> filteredFlights = [];
  List<ContactDetailsClass> ContactPassengerDetails = [];
  int NumberOfAdult = 0;
  int NumberOfChild = 0;

  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    setState(() {
      getData();
      AirelineCompany = _auth.currentUser;
      AirelineCompanyId = AirelineCompany?.uid.toString() ?? '';
    });
    fetchFlights();
  }

  void getData() async {
    final event =
        await FirebaseDatabase.instance.ref('Airline_company').child(uid).get();
    final AirelineCompanyData = Map<dynamic, dynamic>.from(event.value as Map);
    AirelineCompanyName = AirelineCompanyData['AirlineCompanyName'];
  }

  Future<void> fetchFlights() async {
    await FirebaseDatabase.instance
        .reference()
        .child('booking')
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var bookingData =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        bookingData.forEach((key, value) {
          if (key == widget.ContactDetailsPassengerData.bookingId) {
            for (var adult in bookingData[key]['passengerIds']) {
              FirebaseDatabase.instance
                  .reference()
                  .child('passenger')
                  .child(adult)
                  .once()
                  .then((DatabaseEvent event) {
                if (event.snapshot.exists) {
                  var passengerData =
                      Map<dynamic, dynamic>.from(event.snapshot.value as Map);
                  final DateFormat formatter = DateFormat('y/M/d');
                  final DateTime birthDate =
                      formatter.parse(passengerData['birthDate']);
                  final DateTime now = DateTime.now();
                  final DateTime AdultDate = DateTime(2006, now.month, now.day);
                  if (birthDate.isBefore(AdultDate) || birthDate == AdultDate) {
                    NumberOfAdult += 1;
                  }
                  if (birthDate.isAfter(AdultDate) || birthDate == AdultDate) {
                    NumberOfChild += 1;
                  }

                  if (mounted)
                    setState(() {
                      PassengerAdultData[adult] = passengerData;
                    });
                }
              });
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Get.to(FlightBookingDetails(
            ContactDetails: widget.ContactDetailsPassengerData,
            NumberOfAdult: NumberOfAdult,
            NumberOfChild: NumberOfChild));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/image/png/girlUser1.png'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.ContactDetailsPassengerData.firstname}${' '}${widget.ContactDetailsPassengerData.lastname}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              SizedBox(
                                width: size.width / 4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.boy,
                                    color: AppColors.darkBlue,
                                  ),
                                  const Text(
                                    'Adult:',
                                    style: TextStyle(
                                        color: AppColors.TextBlackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    NumberOfAdult.toString() ?? "",
                                    style: const TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.boy,
                                    color: AppColors.darkBlue,
                                  ),
                                  const Text(
                                    'Children:',
                                    style: TextStyle(
                                        color: AppColors.TextBlackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    NumberOfChild.toString(),
                                    style: const TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 40,
            //   width: size.width,
            //   padding: EdgeInsets.only(right: 15),
            //   decoration: const BoxDecoration(
            //     color: AppColors.Blue,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(15),
            //       bottomRight: Radius.circular(15),
            //     ),
            //   ),
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text(
            //         'more details',
            //         style: TextStyle(
            //           color: Colors.white,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Icon(
            //         Icons.arrow_forward,
            //         color: Colors.white,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
