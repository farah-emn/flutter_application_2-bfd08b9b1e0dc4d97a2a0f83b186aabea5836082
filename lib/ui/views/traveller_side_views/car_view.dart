// ignore_for_file: non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/car_card.dart';
import 'package:traveling/cards/car_card2.dart';
import 'package:traveling/classes/car_class.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import '../../shared/colors.dart';

class CarView extends StatefulWidget {
  const CarView({super.key});
  @override
  State<CarView> createState() => _CarViewState();
}

class _CarViewState extends State<CarView> {
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());
  ValueNotifier<List<RoomDetailsClass>> HotelRooms =
      ValueNotifier<List<RoomDetailsClass>>([]);
  final _SearchController = TextEditingController();
  Map<dynamic, dynamic> HotelRoom = {};
  bool? isChecked = false;
  late User loggedinUser;
  final _auth = FirebaseAuth.instance;
  late final User? user;
  var Companylogo;
  var HotelId = '';
  String sorteBy = '';
  String CompanyName = '';
  late DatabaseReference ref;
  bool? isCheckedFreeWifi = false;
  bool? isCheckedPrivatePool = false;
  bool? isCheckedPrivateParking = false;
  bool? isCheckedCleaningServices = false;
  bool? isCheckedFoodDrink = false;
  int NumberOfResultFilteredHotelRooms = 0;
  double MinPrice = 0.0;
  double MaxPrice = 0.0;
  Color selectedColor = Colors.black;
  List<Color> colors = [
    Colors.black,
    Color.fromARGB(255, 255, 249, 249),
    Colors.grey,
    AppColors.darkBlue,
    Colors.red,
    Colors.brown,
  ];
  List<bool> isSelected = [true, false, false];
  String dropdownValue2 = 'Toyota';

  @override
  void initState() {
    super.initState();
    // ref = FirebaseDatabase.instance.ref('Hotel');
    // user = _auth.currentUser;
    // getData();
    // super.initState();
  }

  // void getData() async {
  //   HotelId = user!.uid.toString();
  //   final event = await ref.child(HotelId).get();
  //   final userData = Map<dynamic, dynamic>.from(event.value as Map);
  //   if (mounted) {
  //     HotelRoomsList();
  //   }
  // }

  // Future<void> HotelRoomsList() async {
  //   List<RoomDetailsClass> rooms = [];
  //   await FirebaseDatabase.instance
  //       .reference()
  //       .child('Room')
  //       .orderByChild('HotelId')
  //       .equalTo(user!.uid.toString())
  //       .once()
  //       .then((DatabaseEvent event) {
  //     if (event.snapshot.exists) {
  //       var RoomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
  //       RoomData.forEach((Roomkey, value) {
  //         rooms.add(RoomDetailsClass.fromMap({
  //           "id": Roomkey,
  //           'Adults': value['Adults'],
  //           "Children": value['Children'],
  //           "Overview": value['Overview'],
  //           "Price": value['Price'],
  //           "NumberOfBedrooms": value['NumberOfBedrooms'],
  //           "NumberOfBeds": value['NumberOfBeds'],
  //           "RoomNumber": value['RoomNumber'],
  //           "NumberOfRooms": value['NumberOfRooms'],
  //           "RoomPhoto": value['RoomPhoto'],
  //           "isCheckedPrivateParking": value['isCheckedPrivateParking'],
  //           "isCheckedCleaningServices": value['isCheckedCleaningServices'],
  //           "isCheckedFoodAnddrink": value['isCheckedFoodAnddrink'],
  //           "isCheckedFreeWifi": value['isCheckedFreeWifi'],
  //           "isCheckedPrivatePool": value['isCheckedPrivatePool'],
  //           "is_reserved": value['is_reserved']
  //         }));
  //       });
  //     }
  //   });
  //   if (mounted) {
  //     setState(() {
  //       HotelRooms.value = rooms;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double convert(String from, String to, double amount) {
      Map<String, double> rates = {
        'AED': 3.67,
        'KWD': 0.30,
        'BHD': 0.38,
        'EUR': 0.85,
        'GBP': 0.75,
        'USD': 1.00,
        'INR': 74.25,
        'OMR': 0.39,
      };
      double amountInUsd = amount / rates[from]!;
      double convertedAmount = amountInUsd * rates[to]!;
      String resultAsString = convertedAmount.toStringAsFixed(2);
      double finalResult = double.parse(resultAsString);
      return finalResult;
    }

    void _showBottomShest() {
      var filteredEntries;
      var HotelRoomPrice =
          HotelRooms.value.map((entry) => entry.Price.toDouble()).toList();

      if (HotelRoomPrice.isNotEmpty) {
        MinPrice = convert(
            'USD',
            HotelCurrency_Controller.selectedCurrency.value,
            HotelRoomPrice.reduce(
                (value, element) => value < element ? value : element));
        MaxPrice = convert(
            'USD',
            HotelCurrency_Controller.selectedCurrency.value,
            HotelRoomPrice.reduce(
                (value, element) => value > element ? value : element));
      }
      RangeValues _currentRangeValues = RangeValues(MinPrice, MaxPrice);
      Future<void> _Confirm() async {
        List<RoomDetailsClass> filteredRooms = [];
        for (var Room in HotelRooms.value) {
          var HotelRoomPrice = convert(
              'USD',
              HotelCurrency_Controller.selectedCurrency.value,
              double.parse(Room.Price.toString()));
          bool matchesFreeWifi = ((Room.isCheckedFreeWifi == true) &&
                  (isCheckedFreeWifi == true)) ||
              (isCheckedFreeWifi == false);
          bool CheckedPrivatePool = ((Room.isCheckedPrivatePool == true) &&
                  (Room.isCheckedPrivatePool == true)) ||
              (isCheckedPrivatePool == false);
          bool CheckedFoodAnddrink = ((Room.isCheckedFoodAnddrink == true) &&
                  (isCheckedFoodDrink == true)) ||
              (isCheckedFoodDrink == false);
          bool CheckedCleaningServices =
              ((Room.isCheckedCleaningServices == true) &&
                      (isCheckedCleaningServices == true)) ||
                  (isCheckedCleaningServices == false);
          bool Checked24HourFrontDesk =
              ((Room.isCheckedPrivateParking == true) &&
                      (isCheckedPrivateParking == true)) ||
                  (isCheckedPrivateParking == false);
          bool PriceRange =
              (HotelRoomPrice >= _currentRangeValues.start.round() &&
                  HotelRoomPrice <= _currentRangeValues.end.round());
          if (matchesFreeWifi &&
              CheckedPrivatePool &&
              CheckedFoodAnddrink &&
              CheckedCleaningServices &&
              Checked24HourFrontDesk &&
              PriceRange) {
            filteredRooms.add(Room);
          }
        }
        setState(() {
          HotelRooms.value = filteredRooms;
        });
        Navigator.pop(context);
      }

      void NumberOfHotelRooms() {
        int NumberOfResultFilteredHotelRooms = HotelRooms.value.length;
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightOrange,
        // appBar: AppBar(
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('Search'),
        //     ],
        //   ),
        // ),
        body: SafeArea(
          child: Stack(children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Search',
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
                top: 50,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),

                      // (HotelRooms.value.isEmpty)
                      //     ? const CircularProgressIndicator()
                      //     : (HotelRooms.value.isNotEmpty)
                      //         ? Expanded(
                      // child:
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: cars.length,
                          itemBuilder: (context, index) => CarCard2(
                            size: size,
                            itemIndex: index,
                            carDetails: cars[index],
                          ),
                        ),
                      ),
                      // )
                      // : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  void _SearchRoomController(String value) {
    setState(() {
      HotelRooms.value = HotelRoom.entries.where((Room) {
        bool HotelRoom = (_SearchController.text.isEmpty) ||
            (Room.value['Overview']
                .toLowerCase()
                .contains(_SearchController.text.toLowerCase()));
        return HotelRoom;
      }).map((entry) {
        return RoomDetailsClass.fromMap({
          "id": entry.key,
          'Adults': entry.value['Adults'],
          "Children": entry.value['Children'],
          "Overview": entry.value['Overview'],
          "Price": entry.value['Price'],
          "NumberOfBedrooms": entry.value['NumberOfBedrooms'],
          "NumberOfBeds": entry.value['NumberOfBeds'],
          "RoomPhoto": entry.value['RoomPhoto'],
          "isChecked24-hourFrontDesk": entry.value['isChecked24-hourFrontDesk'],
          "isCheckedCleaningServices": entry.value['isCheckedCleaningServices'],
          "isCheckedFoodAnddrink": entry.value['isCheckedFoodAnddrink'],
          "isCheckedFreeWifi": entry.value['isCheckedFreeWifi'],
          "isCheckedPrivatePool": entry.value['isCheckedPrivatePool'],
        });
      }).toList();
    });
  }
}
