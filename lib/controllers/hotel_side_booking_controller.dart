// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:traveling/classes/hotel1.dart';
import 'package:traveling/controllers/hotel_rooms_controller.dart';
import '../classes/hotel_side_finished_class1.dart';
import '../classes/hotel_side_upcoming_class1.dart';

class HotelSideBookingsController extends GetxController {
  Rx<DateTime> departureDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<DateTime> ArrivalDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  final HotelRoomsController HotelRooms_Controller =
      Get.put(HotelRoomsController());
  var bookingsDetailsUpcoming = <HotelSideBookingsClass1>[].obs;
  var bookingsDetailsFinished = <HotelSideFinishedClass>[].obs;
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
  // ItemScrollController _scrollController = ItemScrollController();

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
    final event = await ref.child('hotel_booking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bookingDetails.forEach((bookingKey, value) async {
        Map<dynamic, dynamic> bookingData = value;
        final DateFormat formatter = DateFormat('d. M, y');
        final String formattedCheckoutDate = value['DepartureDate'];
        final String formattedNow = formatter.format(DateTime.now());
        DateTime checkoutDate = formatter.parse(formattedCheckoutDate);
        DateTime now = formatter.parse(formattedNow);
        if (checkoutDate.isAfter(now)) {
          // if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
          await getBookingDetailsUpcoming(bookingData, bookingData['RoomId']);
          //   print('wewewewe');
          // }
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
    final roomEvent = await ref.child('Room').child(roomId).once();
    if (roomEvent.snapshot.exists) {
      Map<dynamic, dynamic> roomData =
          Map<dynamic, dynamic>.from(roomEvent.snapshot.value as Map);

      // Fetch hotel details
      final hotelEvent = await ref.child('Hotel').once();
      if (hotelEvent.snapshot.exists) {
        Map<dynamic, dynamic> hotelData =
            Map<dynamic, dynamic>.from(hotelEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsHotel = await ref.child('RatingsHotel').once();
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
          if (ratingsHotelData is Map && ratingsHotelData['RoomId'] == roomId) {
            ratingValue = ratingsHotelData['Rating'];
            print(ratingValue);
            print('Map of ratings:');
            print(ratingsHotelData);
          } else if (ratingsHotelData is List) {
            for (var rating in ratingsHotelData) {
              if (rating != null && rating['RoomId'] == roomId) {
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

          hotelData.forEach((key, value) {
            print(key);
            if (!addedRoomIds.contains(roomId)) {
              bookingsDetailsUpcoming.add(HotelSideBookingsClass1.fromMap({
                'checkinDate': bookingData['ArrivalDate'],
                'checkoutDate': bookingData['DepartureDate'],
                'hotelame': value['HotelName'],
                'roomNumber': roomData['RoomNumber'],
                'totalPrice': bookingData['TotalPrice'],
                'image': roomData['RoomPhoto'][1].toString(),
                'location': value['location'],
                'bookingDate': bookingData['BookingDate'],
                'priceNight': roomData['Price'],
                'RoomId': roomId,
                'customerName': bookingData['FirstName'],

                'RatingRoom': ratingValue,
                'email': bookingData[
                    'Email'] // Ensure the key matches the constructor
              }));
              addedRoomIds.add(roomId);
            }
          });
        } else {
          hotelData.forEach((key, value) {
            print(key);
            if (!addedRoomIds.contains(roomId)) {
              // if (bookingData['HotelId'] == key)
              bookingsDetailsUpcoming.add(HotelSideBookingsClass1.fromMap({
                'checkinDate': bookingData['ArrivalDate'],
                'checkoutDate': bookingData['DepartureDate'],
                'hotelName': value['HotelName'],
                'roomNumber': roomData['RoomNumber'],
                'totalPrice': bookingData['TotalPrice'],
                'image': roomData['RoomPhoto'][1].toString(),
                'location': value['location'],
                'bookingDate': bookingData['BookingDate'],
                'priceNight': roomData['Price'],
                'RoomId': roomId,
                'RatingRoom': 0.0,
                'customerName': bookingData['FirstName'],

                'email': bookingData[
                    'Email'] // Ensure the key matches the constructor
              }));
              addedRoomIds.add(roomId);
            }
          });
        }

        update();
        isLoading.value = false;
      }
    }
  }

  Set<String> addedRoomIdsFinished = Set<String>();

  void getUserBookingFinished() async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('hotel_booking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bookingDetails.forEach((bookingKey, value) async {
        Map<dynamic, dynamic> bookingData = value;
        final DateFormat formatter = DateFormat('d. M, y');
        final String formattedCheckoutDate = value['DepartureDate'];
        final String formattedNow = formatter.format(DateTime.now());
        DateTime checkoutDate = formatter.parse(formattedCheckoutDate);
        DateTime now = formatter.parse(formattedNow);
        if (checkoutDate.isBefore(now)) {
          // if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
          await getBookingDetailsFinished(bookingData, bookingData['RoomId']);
          // }
        } else {
          isLoading.value = false;
        }
      });
    }
  }

  Future<void> getBookingDetailsFinished(
      Map<dynamic, dynamic> bookingData, roomId) async {
    print('Fetching room and hotel booking details...');
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    // Fetch room details
    final roomEvent = await ref.child('Room').child(roomId).once();
    if (roomEvent.snapshot.exists) {
      Map<dynamic, dynamic> roomData =
          Map<dynamic, dynamic>.from(roomEvent.snapshot.value as Map);

      // Fetch hotel details
      final hotelEvent = await ref.child('Hotel').once();
      if (hotelEvent.snapshot.exists) {
        Map<dynamic, dynamic> hotelData =
            Map<dynamic, dynamic>.from(hotelEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsHotel = await ref.child('RatingsHotel').once();
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
          if (ratingsHotelData is Map && ratingsHotelData['RoomId'] == roomId) {
            ratingValue = ratingsHotelData['Rating'];
            print(ratingValue);
            print('Map of ratings:');
            print(ratingsHotelData);
          } else if (ratingsHotelData is List) {
            for (var rating in ratingsHotelData) {
              if (rating != null && rating['RoomId'] == roomId) {
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
          hotelData.forEach((key, value) {
            if (!addedRoomIdsFinished.contains(roomId)) {
              print('mmmmmmmmmmmmmmmm1567890-09876543mmmmmmmmmmmm');
              // if (bookingData['HotelId'] == key)
              bookingsDetailsFinished.add(HotelSideFinishedClass.fromMap({
                'checkinDate': bookingData['ArrivalDate'],
                'checkoutDate': bookingData['DepartureDate'],
                'hotelName': value['HotelName'],
                'roomNumber': roomData['RoomNumber'],
                'totalPrice': bookingData['TotalPrice'],
                'image': roomData['RoomPhoto'][1].toString(),
                'location': value['location'],
                'bookingDate': bookingData['BookingDate'],
                'priceNight': roomData['Price'],
                'RoomId': roomId,
                'RatingRoom': ratingValue,
                'customerName': bookingData['FirstName'],

                'email': bookingData[
                    'Email'] // Ensure the key matches the constructor
              }));
              addedRoomIdsFinished.add(roomId);
            }
          });
        } else {
          print('No ratings found.');
          if (!addedRoomIdsFinished.contains(roomId)) {
            hotelData.forEach((key, value) {
              if (!addedRoomIdsFinished.contains(roomId)) {
                // if (bookingData['HotelId'] == key)
                print('mmmmmmmmmmmmmmmm1567890-09876543mmmmmmmmmmmm');
                bookingsDetailsFinished.add(HotelSideFinishedClass.fromMap({
                  'checkinDate': bookingData['ArrivalDate'],
                  'checkoutDate': bookingData['DepartureDate'],
                  'hotelName': value['HotelName'],
                  'roomNumber': roomData['RoomNumber'],
                  'totalPrice': bookingData['TotalPrice'],
                  'image': roomData['RoomPhoto'][1].toString(),
                  'location': value['location'],
                  'bookingDate': bookingData['BookingDate'],
                  'priceNight': roomData['Price'],
                  'RoomId': roomId,
                  'RatingRoom': 0.0,
                  'customerName':
                      '${bookingData['FirstName']} ${bookingData['LastName']}',
                  'email': bookingData[
                      'Email'] // Ensure the key matches the constructor
                }));
                addedRoomIdsFinished.add(roomId);
              }
            });
          }
        }

        update();
        isLoading.value = false;
      }
    }
  }
}
