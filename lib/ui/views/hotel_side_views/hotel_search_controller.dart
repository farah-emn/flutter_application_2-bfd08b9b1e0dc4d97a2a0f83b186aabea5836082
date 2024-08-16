// ignore_for_file: non_constant_identifier_names, prefer_final_fields, prefer_collection_literals, deprecated_member_use, unnecessary_null_comparison, invalid_use_of_protected_member

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel1.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/ui/views/traveller_side_views/hotel_explore_view.dart';

class SearchHotelController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<DateTime> ArrivalDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  int _Adultcounter = 1;
  int _Roomscounter = 1;
  int _Childcounter = 0;
  var _Destnation = ''.obs;
  get Destnation => _Destnation;
  int get Adultcounter => _Adultcounter;
  int get Roomscounter => _Roomscounter;
  int get Childcounter => _Childcounter;
  int NumberOfHotels = 0;
  double totalflightprice = 0;
  var _minPricePerHotel = Map<String, double>().obs;
  Map<String, double> get minPricePerHotel => _minPricePerHotel;
  var Hotels = <HotelClass1>[].obs;
  var validHotels = <HotelClass1>[].obs;
  final HotelRoomsController HotelRooms_Controller =
      Get.put(HotelRoomsController());
  var hotelRooms = <RoomDetailsClass>[].obs;

  void setDestnation(String city) {
    _Destnation.value = city;
  }

  void incrementAdult() {
    _Adultcounter++;
    update();
  }

  void decrementAdult() {
    if (Adultcounter > 1) {
      _Adultcounter--;
      update();
    }
  }

  void incrementRooms() {
    _Roomscounter++;
    update();
  }

  void decrementRooms() {
    if (Roomscounter > 1) {
      _Roomscounter--;
      update();
    }
  }

  void incrementChild() {
    _Childcounter++;
    update();
  }

  void decrementChild() {
    if (Childcounter > 0) {
      _Childcounter--;
      update();
    }
  }

  void updateSelectedDate() {
    selectedDate.value =
        '${DateTime.now().day}. ${DateTime.now().month}, ${DateTime.now().year}';
  }

  String getFormattedDepartureDate() {
    return _formatDate(departureDate.value);
  }

  String _formatDate(DateTime date) {
    return '${date.day}. ${date.month}, ${date.year}';
  }

  String getFormattedArrivalDate() {
    return _formatDate(ArrivalDate.value);
  }

  Future<void> searchForHotel() async {
    Hotels.clear();
    validHotels.clear();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('Hotel').once();
    if (event.snapshot.exists) {
      var hotelDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      hotelDetails.forEach((hotelKey, value) {
        Map<dynamic, dynamic> hotelData = value;
        if (hotelData['location'].toString() == _Destnation.value) {
          searchForSpecificHotel(hotelKey);
        }
      });
    }
  }

  Future<void> searchForSpecificHotel(String specificHotelKey) async {
    Hotels.clear();
    validHotels.clear();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('Hotel').child(specificHotelKey).once();
    if (event.snapshot.exists != null) {
      Map<dynamic, dynamic> hotelData =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      Set<String> addedHotels = {};
      if (hotelData['location'].toString() == _Destnation.value) {
        searchRooms(specificHotelKey, hotelData, Adultcounter, Childcounter,
            addedHotels);
      }
    }
  }

  Future<void> searchRooms(String hotelKey, Map<dynamic, dynamic> hotelData,
      int adultCounter, int childCounter, Set<String> addedHotels) async {
    NumberOfHotels = 0;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('Room').once();
    if (event.snapshot.exists != null) {
      var roomDetails = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bool shouldAddHotel = false;
      double minPriceForThisHotel = double.infinity;
      roomDetails.forEach((key, room) {
        if (room['HotelId'] == hotelKey) {
          double price =
              double.tryParse(room['Price'].toString()) ?? double.infinity;
          if (price < minPriceForThisHotel) {
            minPriceForThisHotel = price;
          }
          bool adultCondition = room['Adults'] >= adultCounter;
          // bool isNotReserved = room['is_reserved'] == false;
          bool childrenCondition =
              childCounter == 0 || room['Children'] >= childCounter;
          if (adultCondition &&
              childrenCondition &&
              // isNotReserved &&
              !addedHotels.contains(hotelKey)) {
            addedHotels.add(hotelKey);
            shouldAddHotel = true;
          }
        }
      });

      if (shouldAddHotel) {
        _minPricePerHotel[hotelKey] = minPriceForThisHotel;
        update();

        validHotels.add(HotelClass1.fromMap({
          "Id": hotelKey,
          "HotelName": hotelData['HotelName'],
          'location': hotelData['location'],
          "image": hotelData['image'],
          "StartPrice": _minPricePerHotel[hotelKey],
          "email": hotelData['email'],
          "address": hotelData['address'],
          "mobilenumber": hotelData['mobile_number']
        }));
        minPriceForThisHotel = 0.0;
      }
      Hotels.value = validHotels;
      if (Hotels.value.isNotEmpty) {
        Get.to(() => AllHotelView(Hotels: Hotels.value));
        HotelRooms_Controller.HotelsRooms();
        NumberOfHotels = Hotels.value.length;
      } else {
        Fluttertoast.showToast(
            msg: "No hotels found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<void> getRoomRating(String RoomKey) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('Room').once();
    final refRatings =
        FirebaseDatabase.instance.reference().child('RatingsHotel');
    if (event.snapshot.exists != null) {
      var roomDetails = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bool shouldAddHotel = false;
      double minPriceForThisHotel = double.infinity;
      final event_ratings = await refRatings.once();

      roomDetails.forEach((key, room) {
        if (key == RoomKey) {}
      });

      // if (shouldAddHotel) {
      //   _minPricePerHotel[hotelKey] = minPriceForThisHotel;
      //   update();
      //   validHotels.add(HotelClass1.fromMap({
      //     "Id": hotelKey,
      //     "HotelName": hotelData['HotelName'],
      //     'location': hotelData['location'],
      //     "image": hotelData['image'],
      //     "StartPrice": _minPricePerHotel[hotelKey],
      //   }));
      //   minPriceForThisHotel = 0.0;
      // }
      Hotels.value = validHotels;
      if (Hotels.value.isNotEmpty) {
        Get.to(() => AllHotelView(Hotels: Hotels.value));
        HotelRooms_Controller.HotelsRooms();
        NumberOfHotels = Hotels.value.length;
      } else {
        Fluttertoast.showToast(
            msg: "No hotels found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void clearData() {
    departureDate.value = DateTime.now();
    ArrivalDate.value = DateTime.now();
    selectedDate.value = '${DateTime.now().month}/${DateTime.now().day}';
    _Adultcounter = 1;
    _Childcounter = 0;
    _Destnation.value = '';
    NumberOfHotels = 0;
    // _ArrivalCity.value = '';
    update();
  }
}
