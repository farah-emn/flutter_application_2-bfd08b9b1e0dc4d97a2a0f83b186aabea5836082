// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, prefer_final_fields, unused_local_variable

import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/material/slider_theme.dart';
import 'package:get/get.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/classes/hotel1.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/hotel_controller.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import 'package:traveling/controllers/hotel_search_controller.dart';

class HotelFilterSearchController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().obs;
  Rx<DateTime> ArrivalDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  int _Adultcounter = 1;
  int _Roomscounter = 1;
  int _Childcounter = 0;
  var _Destnation = ''.obs;
  get Destnation => _Destnation;
  int _NumberOfHotels = 1;
  int get NumberOfHotels => _NumberOfHotels;
  int get Adultcounter => _Adultcounter;
  int get Roomscounter => _Roomscounter;
  int get Childcounter => _Childcounter;
  var isloadingSort = false.obs;
  var isloadingRatings = false.obs;
  var isloadingFilter = false.obs;

  var FiltersHotels = <String>[].obs;
  var HotelaverageRating = 1.1.obs;
  double totalflightprice = 0;
  var NumHotel = 0.obs;
  var _minPricePerHotel = Map<String, double>().obs;
  var Hotels = <HotelClass1>[].obs;
  var validHotels = <HotelClass1>[].obs;
  Map<String, double> get minPricePerHotel => _minPricePerHotel;
  final HotelController Hotel_Controller = Get.put(HotelController());
  final SearchHotelController SearchHotel_Controller =
      Get.put(SearchHotelController());
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());
  final HotelRoomsController HotelRooms_Controller =
      Get.put(HotelRoomsController());
  List<HotelClass1> Hotel(var hotels) {
    Hotels.value = hotels;
    return Hotels.value;
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

  void sortByForHotels(String? sortBy) async {
    double lowPrice =
        convert('USD', HotelCurrency_Controller.selectedCurrency.value, 220);
    var validHotels = SearchHotel_Controller.validHotels.value;

    // Create a list to store the updated hotels with ratings
    List<HotelClass1> updatedHotels = [];
    isloadingSort.value = true;
    for (var hotel in validHotels) {
      await getAllRoomRatings(hotel.Id); // Wait for the ratings to be computed

      var priceInSelectedCurrency = convert(
        'USD',
        HotelCurrency_Controller.selectedCurrency.value,
        double.parse(hotel.StartPrice.toString()),
      );

      bool matchesLowestPrice =
          (priceInSelectedCurrency <= lowPrice && sortBy == 'Lowest price') ||
              sortBy != 'Lowest price';
      bool matchesHighestPrice =
          (priceInSelectedCurrency > lowPrice && sortBy == 'Highest price') ||
              sortBy != 'Highest price';
      bool highestRating =
          (HotelaverageRating.value > 0.5) || sortBy != 'Highest Rated';

      if (matchesLowestPrice && matchesHighestPrice && highestRating) {
        updatedHotels.add(HotelClass1.fromMap({
          "Id": hotel.Id,
          "HotelName": hotel.Name,
          'location': hotel.location,
          "image": hotel.Image,
          "StartPrice": hotel.StartPrice,
        }));
        isloadingSort.value = false;
      }
    }

    SearchHotel_Controller.Hotels.value = updatedHotels;
  }

  Future<void> getAllRoomRatings(String hotelId) async {
    final ref = FirebaseDatabase.instance.reference().child('Room');
    final refRatings =
        FirebaseDatabase.instance.reference().child('RatingsHotel');
    final event = await ref.once();
    final eventRatings = await refRatings.once();

    if (event.snapshot.exists) {
      var roomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      var roomEntries = roomData.entries.toList();

      double totalHotelRating = 0.0;
      int totalRoomCount = 0;

      for (var entry in roomEntries) {
        if (entry.value['HotelId'] == hotelId) {
          double totalRating = 0.0;
          int ratingCount = 0;

          if (eventRatings.snapshot.exists) {
            var ratingsHotelData = eventRatings.snapshot.value;
            if (ratingsHotelData is Map) {
              ratingsHotelData.forEach((key, value) {
                if (value['RoomId'] == entry.key) {
                  totalRating += value['Rating'] is num
                      ? (value['Rating'] as num).toDouble()
                      : 0.0;
                  ratingCount++;
                }
              });
            } else if (ratingsHotelData is List) {
              for (var rating in ratingsHotelData) {
                if (rating != null && rating['RoomId'] == entry.key) {
                  totalRating += rating['Rating'] is num
                      ? (rating['Rating'] as num).toDouble()
                      : 0.0;
                  ratingCount++;
                }
              }
            }
          }

          double averageRating =
              ratingCount > 0 ? totalRating / ratingCount : 0.0;
          totalHotelRating += averageRating;
          totalRoomCount++;
        }
      }

      HotelaverageRating.value =
          totalRoomCount > 0 ? totalHotelRating / totalRoomCount : 0.0;
      update();
      print(
          'Overall average rating for hotel $hotelId: ${HotelaverageRating.value}');
    } else {
      print('No rooms found.');
    }
  }

  // void filterPropertyAmenityForHotel(
  //     bool? isCheckedFreeWifi,
  //     bool? isCheckedPrivatePool,
  //     bool? isCheckedCleaningServices,
  //     bool? isCheckedFoodDrink,
  //     bool? isCheckedPrivateParking,
  //     RangeValues currentRangeValues) {
  //   FiltersHotels.clear();

  //   for (var room in HotelRooms_Controller.hotelsRooms) {
  //     var hotelRoomPrice = convert(
  //         'USD',
  //         HotelCurrency_Controller.selectedCurrency.value,
  //         double.parse(room.Price.toString()));

  //     bool matchesFreeWifi = isCheckedFreeWifi == null ||
  //         room.isCheckedFreeWifi == isCheckedFreeWifi;
  //     bool matchesPrivatePool = isCheckedPrivatePool == null ||
  //         room.isCheckedPrivatePool == isCheckedPrivatePool;
  //     bool matchesCleaningServices = isCheckedCleaningServices == null ||
  //         room.isCheckedCleaningServices == isCheckedCleaningServices;
  //     bool matchesFoodDrink = isCheckedFoodDrink == null ||
  //         room.isCheckedFoodAnddrink == isCheckedFoodDrink;
  //     bool matchesPrivateParking = isCheckedPrivateParking == null ||
  //         room.isCheckedPrivateParking == isCheckedPrivateParking;
  //     bool matchesPriceRange =
  //         hotelRoomPrice >= currentRangeValues.start.round() &&
  //             hotelRoomPrice <= currentRangeValues.end.round();

  //     if (matchesFreeWifi &&
  //         matchesPrivatePool &&
  //         matchesCleaningServices &&
  //         matchesFoodDrink &&
  //         matchesPrivateParking &&
  //         matchesPriceRange) {
  //       if (!FiltersHotels.contains(room.HotelId)) {
  //         FiltersHotels.add(room.HotelId);
  //       }
  //     }
  //   }
  // }

  void ConfirmFiterPropertyAmentyForHotel(
      bool? isCheckedFreeWifi,
      bool? isCheckedPrivatePool,
      bool? isCheckedCleaningServices,
      bool? isCheckedFoodDrink,
      bool? isCheckedPrivateParking,
      RangeValues currentRangeValues) {
    FiltersHotels.clear();

    for (var room in HotelRooms_Controller.hotelsRooms) {
      isloadingFilter.value = true;
      print(HotelRooms_Controller.hotelRooms.length);
      var HotelRoomPrice = convert(
          'USD',
          HotelCurrency_Controller.selectedCurrency.value,
          double.parse(room.Price.toString()));
      bool matchesFreeWifi =
          (room.isCheckedFreeWifi == true && isCheckedFreeWifi == true) ||
              (isCheckedFreeWifi == false);
      bool matchesPrivatePool =
          (room.isCheckedPrivatePool == true && isCheckedPrivatePool == true) ||
              (isCheckedPrivatePool == false);
      bool matchesCleaningServices = (room.isCheckedCleaningServices == true &&
              isCheckedCleaningServices == true) ||
          (isCheckedCleaningServices == false);
      bool matchesFoodDrink =
          (room.isCheckedFoodAnddrink == true && isCheckedFoodDrink == true) ||
              (isCheckedFoodDrink == false);
      bool matchesPrivateParking = (room.isCheckedPrivateParking == true &&
              isCheckedPrivateParking == true) ||
          (isCheckedPrivateParking == false);
      bool matchesPriceRange =
          (HotelRoomPrice >= currentRangeValues.start.round() &&
              HotelRoomPrice <= currentRangeValues.end.round());

      if (matchesPrivateParking &&
          matchesCleaningServices &&
          matchesFoodDrink &&
          matchesPrivatePool &&
          matchesFreeWifi &&
          matchesPriceRange) {
        if (!FiltersHotels.contains(room.HotelId)) {
          FiltersHotels.add(room.HotelId);
        }
        if (FiltersHotels.value.isNotEmpty) {
          isloadingFilter.value = false;
        }
      }
    }
    NumHotel.value = SearchHotel_Controller.Hotels.value.length;

    SearchHotel_Controller.Hotels.value =
        SearchHotel_Controller.validHotels.value.where((hotel) {
      return FiltersHotels.contains(hotel.Id);
    }).map((entry) {
      return HotelClass1.fromMap({
        "Id": entry.Id,
        "HotelName": entry.Name,
        'location': entry.location,
        "image": entry.Image,
        "StartPrice": entry.StartPrice,
        "email": entry.email,
        "address": entry.address,
        "mobilenumber": entry.mobilenumber
      });
    }).toList();
  }
}
