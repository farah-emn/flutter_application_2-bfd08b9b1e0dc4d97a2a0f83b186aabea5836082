// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:traveling/classes/hotel1.dart';

import '../classes/car_side_upcoming_class1.dart';

class CarSideBookingsController extends GetxController {
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
  ItemScrollController _scrollController = ItemScrollController();

  @override
  void onInit() {
    super.onInit();
    ref = FirebaseDatabase.instance.ref('user');
    user = _auth.currentUser;
    getUserBookingUpcoming();
    getUserBookingFinished();
    print('kkkkkkkkkkkkk');
    getCurrentUser();
    update();
  }

  void getCurrentUser() async {
    isLoading.value = true;
    getUserBookingUpcoming();
    getUserBookingFinished();
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
      bookingDetails.forEach((bookingKey, value) async {
        Map<dynamic, dynamic> bookingData = value;
        final DateFormat formatter = DateFormat('d. M, y');
        final String formattedCheckoutDate = value['PickupDate'];
        final String formattedNow = formatter.format(DateTime.now());
        DateTime checkoutDate = formatter.parse(formattedCheckoutDate);
        DateTime now = formatter.parse(formattedNow);
        if (checkoutDate.isAfter(now)) {
          // if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
          await getBookingDetailsUpcoming(bookingData, bookingData['CarId']);
          //   print('wewewewe');
          //  }
        } else {
          isLoading.value = false;
        }
      });
    }
  }

  Future<void> getBookingDetailsUpcoming(
      Map<dynamic, dynamic> bookingData, roomId) async {
    print('Fetching room and hotel booking details...');
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    // Fetch room details
    final roomEvent = await ref.child('Car').child(roomId).once();
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
            print(ratingsHotelData);
          } else if (ratingsHotel.snapshot.value is List) {
            ratingsHotelData =
                List<dynamic>.from(ratingsHotel.snapshot.value as List);
            print('List of ratings:');
            print(ratingsHotelData);

            List<double> ratings = [];
            for (var data in ratingsHotelData) {
              if (data != null && data['Rating'] != null) {
                ratings.add((data['Rating'] as num).toDouble());
              }
            }
            print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
            print(ratings); // Output: [0.5, 2.5]
          }

          double ratingValue = 0.0;
          if (ratingsHotelData is Map && ratingsHotelData['CarId'] == roomId) {
            ratingValue = ratingsHotelData['Rating'];
            print(ratingValue);
            print('Map of ratings:');
            print(ratingsHotelData);
          } else if (ratingsHotelData is List) {
            for (var rating in ratingsHotelData) {
              if (rating != null && rating['CarId'] == roomId) {
                ratingValue = (rating['Rating'] as num).toDouble();

                break;
              }
            }
          }
          print('Final rating value:');
          print(ratingValue);
          if (!addedRoomIds.contains(roomId)) {
            hotelData.forEach((comanykey, value) async {
              if (comanykey == bookingData['CompanyId']) {
                bookingsDetailsUpcoming.add(carSideBookingsClass1.fromMap({
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
                  'carId': roomId,
                  'RatingCar': ratingValue,
                  'customerName': bookingData['FirstName'],
                  'email': bookingData['Email'],
                  'rentalInDay': roomData['RentalInDay'].toString()
                }));
              }
            });
            ;
            addedRoomIds.add(roomId);
          }
        } else {
          print('No ratings found.');
          if (!addedRoomIds.contains(roomId)) {
            hotelData.forEach((comanykey, value) async {
              if (comanykey == bookingData['CompanyId']) {
                bookingsDetailsUpcoming.add(carSideBookingsClass1.fromMap({
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
                  'carId': roomId,
                  'RatingCar': 0.0,
                  'customerName': bookingData['FirstName'],
                  'email': bookingData['Email'],
                  'rentalInDay': roomData['RentalInDay'].toString()
                }));
              }
            });
            addedRoomIds.add(roomId);
          }
        }

        update();
        isLoading.value = false;
      }
    }
  }

  Set<String> addedRoomIdsFinished = Set<String>();

  void getUserBookingFinished() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('CarBooking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bookingDetails.forEach((bookingKey, value) async {
        Map<dynamic, dynamic> bookingData = value;
        final DateFormat formatter = DateFormat('d. M, y');
        final String formattedCheckoutDate = value['PickupDate'];
        final String formattedNow = formatter.format(DateTime.now());
        DateTime checkoutDate = formatter.parse(formattedCheckoutDate);
        DateTime now = formatter.parse(formattedNow);
        if (checkoutDate.isBefore(now) || checkoutDate == now) {
          await getBookingDetailsFinished(bookingData, bookingData['CarId']);
        } else {
          isLoading.value = false;
        }
      });
    }
  }

  Future<void> getBookingDetailsFinished(
      Map<dynamic, dynamic> bookingData, roomId) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    final roomEvent = await ref.child('Car').child(roomId).once();
    if (roomEvent.snapshot.exists) {
      Map<dynamic, dynamic> roomData =
          Map<dynamic, dynamic>.from(roomEvent.snapshot.value as Map);

      final hotelEvent = await ref.child('Car_Rental_Company').once();
      if (hotelEvent.snapshot.exists) {
        Map<dynamic, dynamic> hotelData =
            Map<dynamic, dynamic>.from(hotelEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsHotel = await ref.child('R').once();
        if (ratingsHotel.snapshot.exists) {
          var ratingsHotelData;
          if (ratingsHotel.snapshot.value is Map) {
            ratingsHotelData =
                Map<dynamic, dynamic>.from(ratingsHotel.snapshot.value as Map);
            print(ratingsHotelData);
          } else if (ratingsHotel.snapshot.value is List) {
            ratingsHotelData =
                List<dynamic>.from(ratingsHotel.snapshot.value as List);
            print('List of ratings:');
            print(ratingsHotelData);

            List<double> ratings = [];
            for (var data in ratingsHotelData) {
              if (data != null && data['Rating'] != null) {
                ratings.add((data['Rating'] as num).toDouble());
              }
            }
          }

          double ratingValue = 0.0;
          if (ratingsHotelData is Map && ratingsHotelData['CarId'] == roomId) {
            ratingValue = ratingsHotelData['Rating'];
            print(ratingValue);
            print('Map of ratings:');
            print(ratingsHotelData);
          } else if (ratingsHotelData is List) {
            for (var rating in ratingsHotelData) {
              if (rating != null && rating['CarId'] == roomId) {
                print(rating['Rating']);
                ratingValue = (rating['Rating'] as num).toDouble();
                print('Rating value:');
                print(ratingValue);
                break;
              }
            }
          }
          print('Final rating value:');
          print(ratingValue);
          if (!addedRoomIdsFinished.contains(roomId)) {
            hotelData.forEach((comanykey, value) async {
              if (comanykey == bookingData['CompanyId']) {
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
                  'carId': roomId,
                  'RatingCar': ratingValue,
                  'customerName': bookingData['FirstName'],
                  'email': bookingData['Email'],
                  'rentalInDay': roomData['RentalInDay'].toString()
                }));
              }
            });
            addedRoomIdsFinished.add(roomId);
          }
        } else {
          print('No ratings found.');
          if (!addedRoomIdsFinished.contains(roomId)) {
            hotelData.forEach((comanykey, value) async {
              if (comanykey == bookingData['CompanyId']) {
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
                  'carId': roomId,
                  'RatingCar': 0.0,
                  'customerName': bookingData['FirstName'],
                  'email': bookingData['Email'],
                  'rentalInDay': roomData['RentalInDay'].toString()
                }));
              }
            });
            addedRoomIdsFinished.add(roomId);
          }
        }

        update();
        isLoading.value = false;
      }
    }
  }
}
