// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:traveling/classes/contact_details_passenger_class.dart';
import 'package:traveling/classes/travellars_class.dart';
import '../../../cards/travellar_datails_card.dart';
import '../../shared/colors.dart';

class FlightBookingDetails extends StatefulWidget {
  ContactDetailsClass ContactDetails;
  int NumberOfAdult;
  int NumberOfChild;

  FlightBookingDetails(
      {super.key,
      required this.ContactDetails,
      required this.NumberOfAdult,
      required this.NumberOfChild});
  @override
  State<FlightBookingDetails> createState() => _FlightBookingDetailsState();
}

class _FlightBookingDetailsState extends State<FlightBookingDetails> {
  bool? isChecked = false;
  List<TravellarsClass> TravellerDetails = [];
  List<ContactDetailsClass> ContactPassengerDetails = [];
  Map<dynamic, dynamic> TravellerData = {};

  String? sorteBy;
  User? AirelineCompany;
  final _auth = FirebaseAuth.instance;
  var AirelineCompanyId = '';
  var AirelineCompanyName = '';
  var uid;
  var currentUser;
  double TotalPrice = 0.0;
  String BookingDate = '';
  String BookingNumber = '';
  int Adult = 1;
  int Child = 0;

  @override
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

  String Booking_Number(String bookingnumber) {
    List<String> parts = bookingnumber.split(':');
    return bookingnumber = parts[0];
  }

  Future<void> fetchFlights() async {
    print('gggggggggggggggggggggg');
    await FirebaseDatabase.instance
        .reference()
        .child('booking')
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var bookingData =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        bookingData.forEach((key, value) {
          if (key == '-O4_Kl51_IDydAh6VdvW') {
            print('heeeeeeeeeeee');
          }
          print(key);
          print(widget.ContactDetails.bookingId);
          if (key == widget.ContactDetails.bookingId) {
            print(key);
            print('dddddd');
            setState(() {
              BookingDate = bookingData[key]['bookingdate'];
              BookingNumber = Booking_Number(widget.ContactDetails.bookingId);
            });
            Adult = bookingData[key]['passengerIds'].length;
            for (var adult in bookingData[key]['passengerIds']) {
              FirebaseDatabase.instance
                  .reference()
                  .child('passenger')
                  .child(adult)
                  .once()
                  .then((DatabaseEvent event) {
                if (event.snapshot.exists) {
                  print('oooooooooooooooooooooooooooooooogggggg');
                  // Initialize the map outside the loop

// Inside the loop
                  var Travellerdetails =
                      Map<dynamic, dynamic>.from(event.snapshot.value as Map);
                  if (mounted) {
                    setState(() {
                      TravellerData[adult] =
                          Travellerdetails; // Use the passenger id (adult) as the key
                    });
                  }
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
    setState(() {
      TravellerDetails = TravellerData.entries.map((entry) {
        return TravellarsClass.fromMap({
          'Firstname': entry.value['Firstname'],
          'Lastname': entry.value['Lastname'],
          'birthDate': entry.value['birthDate'],
          'Nationality': entry.value['Nationality'],
          'bookingid': entry.value['bookingid'],
          'issuingCountryPassport': entry.value['issuingCountryPassport'],
          'PassportNumber': entry.value['PassportNumber'],
          'Gender': entry.value['Gender'],
          'ExpirationDatePassport': entry.value['ExpirationDatePassport']
        });
      }).toList();
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Booking details',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.man,
                                      color: AppColors.darkBlue,
                                    ),
                                    Text(
                                      'Adults:',
                                      style: TextStyle(
                                          color: AppColors.TextBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.NumberOfAdult.toString(),
                                      style: TextStyle(
                                        color: AppColors.TextBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.boy,
                                      color: AppColors.darkBlue,
                                    ),
                                    Text(
                                      'Children:',
                                      style: TextStyle(
                                          color: AppColors.TextBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.NumberOfChild.toString(),
                                      style: TextStyle(
                                        color: AppColors.TextBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Booking Number',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  BookingNumber,
                                  style: TextStyle(
                                    color: AppColors.TextBlackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Booking Date',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  BookingDate,
                                  style: TextStyle(
                                    color: AppColors.TextBlackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: AppColors.darkBlue,
                                ),
                                Text(
                                  'Total price:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  TotalPrice.toString(),
                                  style: TextStyle(
                                    color: AppColors.TextBlackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'User details',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        'assets/image/png/girlUser1.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${widget.ContactDetails.firstname} ${widget.ContactDetails.lastname}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.ContactDetails.Email,
                                  style: TextStyle(
                                    color: AppColors.BlueText,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Mobile:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.ContactDetails.mobilenumber,
                                  style: TextStyle(
                                    color: AppColors.BlueText,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Nationality:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Syria',
                                  style: TextStyle(
                                    color: AppColors.TextBlackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Travellars',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: TravellerDetails.length,
                          itemBuilder: (context, index) => TravellarDetailsCard(
                            itemIndex: index,
                            travellarsModel: TravellerDetails[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
