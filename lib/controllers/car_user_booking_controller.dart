// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison, deprecated_member_use, prefer_collection_literals, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/hotel1.dart';
import '../classes/car_side_upcoming_class1.dart';

class CarBookingsController extends GetxController {
  var bookingsDetailsUpcoming = <carSideBookingsClass1>[].obs;
  var bookingsDetailsFinished = <carSideBookingsClass1>[].obs;
  var NewbookingRoom = false.obs;
  var Hotels = <HotelClass1>[].obs;
  var validHotels = <HotelClass1>[].obs;
  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  String CompanyName = '';
  late final User? user;
  late DatabaseReference ref;
  var HotelId = '';
  var CompanyId = '';
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    ref = FirebaseDatabase.instance.ref('user');
    user = _auth.currentUser;
    bookingsDetailsUpcoming.clear();
    bookingsDetailsFinished.clear();

    getCurrentUser();
    update();
  }

  void getCurrentUser() async {
    isLoading.value = true;
    getUserBookingUpcoming();
    // getUserBookingFinished();
    isLoading.value = false;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {}
  }

  double _MinPrice = double.infinity;
  get MinPrice => _MinPrice;
  Set<String> addedRoomIds = Set<String>();
  void getUserBookingUpcoming() async {
    isLoading.value = true;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('CarBooking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      for (var bookingKey in bookingDetails.keys) {
        var bookingData = bookingDetails[bookingKey];
        final DateFormat formatter = DateFormat('d. M, y');
        final String formattedDropOffDate = bookingData['PickupDate'];
        final String formattedNow = formatter.format(DateTime.now());
        DateTime dropOffDate = formatter.parse(formattedDropOffDate);
        DateTime now = formatter.parse(formattedNow);
        if (dropOffDate.isAfter(now)) {
          if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
            await getBookingDetailsUpcoming(bookingData, bookingData['CarId']);
          }
        }
      }
      isLoading.value = false;
    }
  }

  Set<String> addedIdsFinished = Set<String>();

  Future<void> getBookingDetailsUpcoming(
      Map<dynamic, dynamic> bookingData, carId) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    // Fetch car details
    final carEvent = await ref.child('Car').child(carId).once();
    if (carEvent.snapshot.exists) {
      Map<dynamic, dynamic> carData =
          Map<dynamic, dynamic>.from(carEvent.snapshot.value as Map);

      // Fetch car rental company details
      final companyEvent = await ref.child('Car_Rental_Company').once();
      if (companyEvent.snapshot.exists) {
        Map<dynamic, dynamic> companyData =
            Map<dynamic, dynamic>.from(companyEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsEvent = await ref.child('RatingsCars').once();
        double ratingValue = 0.0;
        if (ratingsEvent.snapshot.exists) {
          var ratingsData = ratingsEvent.snapshot.value;
          if (ratingsData is Map) {
            ratingsData = Map<dynamic, dynamic>.from(ratingsData);
            if (ratingsData['CarId'] == carId) {
              ratingValue = ratingsData['Rating'];
            }
          } else if (ratingsData is List) {
            ratingsData = List<dynamic>.from(ratingsData);
            for (var rating in ratingsData) {
              if (rating != null && rating['CarId'] == carId) {
                ratingValue = rating['Rating'];
                break;
              }
            }
          }
        }

        // Add booking details
        if (!addedIdsFinished.contains(carId)) {
          bookingsDetailsUpcoming.add(carSideBookingsClass1.fromMap({
            'companyRentalName': companyData['car_name_company'],
            'company': carData['CarCompany'],
            'model': carData['model'],
            'pickupDate': bookingData['PickupDate'],
            'dropoffDate': bookingData['DropOffDate'],
            'plateNumber': carData['PlateNumber'],
            'totalPrice': bookingData['TotalPrice'],
            'image': carData['CarPhoto'][1].toString(),
            'location': companyData['location'],
            'bookingDate': bookingData['BookingDate'],
            'carId': carId,
            'RatingCar': ratingValue,
            'customerName': bookingData['FirstName'],
            'email': bookingData['Email'],
            'rentalInDay': carData['RentalInDay'].toString()
          }));
          addedIdsFinished.add(carId);
        }
      }
    }
    update();
    isLoading.value = false;
  }

  Set<String> addedRoomIdsFinished = Set<String>();

  void getUserBookingFinished() async {
    isLoading.value = true;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('CarBooking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bookingDetails.forEach((bookingKey, value) async {
        Map<dynamic, dynamic> bookingData = value;
        final DateFormat formatter = DateFormat('d. M, y');
        final String formattedDropOffDate = value['DropOffDate'];
        final String formattedNow = formatter.format(DateTime.now());
        DateTime DropOffDate = formatter.parse(formattedDropOffDate);
        DateTime now = formatter.parse(formattedNow);
        if (DropOffDate.isBefore(now) || DropOffDate == now) {
          // if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
          await getBookingDetailsFinished(bookingData, bookingData['CarId']);
          // }
        } else {
          isLoading.value = false;
        }
      });
    }
  }

  Future<void> getBookingDetailsFinished(
      Map<dynamic, dynamic> bookingData, carId) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    // Fetch room details
    final roomEvent = await ref.child('Car').child(carId).once();
    if (roomEvent.snapshot.exists) {
      Map<dynamic, dynamic> roomData =
          Map<dynamic, dynamic>.from(roomEvent.snapshot.value as Map);

      // Fetch hotel details
      final hotelEvent = await ref.child('Car_Rental_Company').once();
      if (hotelEvent.snapshot.exists) {
        Map<dynamic, dynamic> hotelData =
            Map<dynamic, dynamic>.from(hotelEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsHotel = await ref.child('RatingsCars').once();
        if (ratingsHotel.snapshot.exists) {
          var ratingsHotelData;
          if (ratingsHotel.snapshot.value is Map) {
            ratingsHotelData =
                Map<dynamic, dynamic>.from(ratingsHotel.snapshot.value as Map);
          } else if (ratingsHotel.snapshot.value is List) {
            ratingsHotelData =
                List<dynamic>.from(ratingsHotel.snapshot.value as List);
            List<double> ratings = [];
            for (var data in ratingsHotelData) {
              if (data != null && data['Rating'] != null) {
                ratings.add((data['Rating'] as num).toDouble());
              }
            }
          }

          double ratingValue = 0.0;
          if (ratingsHotelData is Map && ratingsHotelData['CarId'] == carId) {
            ratingValue = ratingsHotelData['Rating'];
          } else if (ratingsHotelData is List) {
            for (var rating in ratingsHotelData) {
              if (rating != null && rating['CarId'] == carId) {
                break;
              }
            }
          }

          if (!addedRoomIdsFinished.contains(carId)) {
            addBookingDetails(
                hotelData, roomData, bookingData, carId, ratingValue);
            addedRoomIdsFinished.add(carId);
          }
        } else {
          if (!addedRoomIdsFinished.contains(carId)) {
            addBookingDetails(hotelData, roomData, bookingData, carId, 0.0);
            addedRoomIdsFinished.add(carId);
          }
        }

        update();
        isLoading.value = false;
      }
    }
  }

  void addBookingDetails(
      Map<dynamic, dynamic> hotelData,
      Map<dynamic, dynamic> roomData,
      Map<dynamic, dynamic> bookingData,
      String carId,
      double ratingValue) {
    hotelData.forEach((comanykey, value) async {
      if (!bookingsDetailsFinished.any((booking) => booking.carId == carId)) {
        bookingsDetailsFinished.add(carSideBookingsClass1.fromMap({
          'companyRentalName': hotelData['car_name_company'],
          'company': roomData['CarCompany'],
          'model': roomData['model'],
          'pickupDate': bookingData['PickupDate'],
          'dropoffDate': bookingData['DropOffDate'],
          'plateNumber': roomData['PlateNumber'],
          'totalPrice': bookingData['TotalPrice'],
          'image': roomData['CarPhoto'][1].toString(),
          'location': value['location'],
          'bookingDate': bookingData['BookingDate'],
          'carId': carId,
          'RatingCar': ratingValue,
          'customerName': bookingData['FirstName'],
          'email': bookingData['Email']
        }));
      }
    });
  }
}
