// // ignore_for_file: non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison, deprecated_member_use

// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:traveling/classes/flight_booking_class1.dart';
// import 'package:traveling/classes/hotel1.dart';

// class FlightBookingsController extends GetxController {
//   var bookingsDetailsUpcoming = <FlightBookingsClass1>[].obs;
//   var bookingsDetailsFinished = <FlightBookingsClass1>[].obs;
//   var Hotels = <HotelClass1>[].obs;
//   var validHotels = <HotelClass1>[].obs;
//   final _auth = FirebaseAuth.instance;
//   late User loggedinUser;
//   String CompanyName = '';
//   late final User? user;
//   late DatabaseReference ref;
//   var HotelId = '';
//   var CompanyId = '';
//   var isLoadingflightupcoming = true.obs;
//   var isLoadingflightfinished = true.obs;
//   var DepartureCity = ''.obs;
//   var ArrivalCity = ''.obs;
//   var DepartureLocation = ''.obs;
//   var ArrivalLocation = ''.obs;
//   var NewbookingFlight = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     ref = FirebaseDatabase.instance.ref('user');
//     user = _auth.currentUser;
//     // bookingsDetailsUpcoming.clear();
//     getUserBookingUpcoming();
//     getUserBookingFinished();
//     getCurrentUser();
//     update();
//   }

//   void getCurrentUser() async {
//     isLoadingflightupcoming.value = true;
//     isLoadingflightfinished.value = true;

//     // getUserBookingUpcoming();
//     // getUserBookingFinished();
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         loggedinUser = user;
//       }
//     } catch (e) {}
//   }

//   double _MinPrice = double.infinity;
//   get MinPrice => _MinPrice;

//   Set<String> processedBookings = Set<String>();

//   void getUserBookingUpcoming() async {
//     print('noooooooooo777oooooooono');
//     DatabaseReference ref = FirebaseDatabase.instance.reference();
//     final event = await ref.child('booking').once();
//     if (event.snapshot.exists) {
//       var bookingDetails =
//           Map<dynamic, dynamic>.from(event.snapshot.value as Map);

//       for (var entry in bookingDetails.entries) {
//         var bookingKey = entry.key;
//         var bookingData = entry.value;

//         if (bookingData['userId'].toString() == loggedinUser.uid.toString() &&
//             !processedBookings.contains(bookingKey)) {
//           await getBookingDetailsUpcoming(bookingData, bookingKey);
//           processedBookings.add(bookingKey);
//         } else {
//           isLoadingflightupcoming = false.obs;
//         }
//       }
//     }
//   }

//   Future<void> getBookingDetailsUpcoming(
//     Map<dynamic, dynamic> bookingData,
//     bookingKey,
//   ) async {
//     DatabaseReference ref = FirebaseDatabase.instance.reference();

//     // Flight details
//     final flightEvent =
//         await ref.child('Flight').child(bookingData['flightId']).once();
//     if (flightEvent.snapshot.exists) {
//       Map<dynamic, dynamic> flightData =
//           Map<dynamic, dynamic>.from(flightEvent.snapshot.value as Map);
//       // Airline company details
//       final airlineEvent = await ref
//           .child('Airline_company')
//           .child(flightData['AirlinId'])
//           .once();
//       if (airlineEvent.snapshot.exists) {
//         Map<dynamic, dynamic> flightCompanyData =
//             Map<dynamic, dynamic>.from(airlineEvent.snapshot.value as Map);

//         final DateFormat formatter = DateFormat('d. M, y');
//         final String formattedDepartureDate = flightData['DepartureDate'];
//         final String formattedNow = formatter.format(DateTime.now());

//         DateTime departureDate = formatter.parse(formattedDepartureDate);
//         DateTime now = formatter.parse(formattedNow);

//         if (departureDate.isAfter(now)) {
//           var airportEvent = await ref.child('Airport').once();
//           if (airportEvent.snapshot.exists) {
//             var airportData =
//                 Map<dynamic, dynamic>.from(airportEvent.snapshot.value as Map);

//             var departureAirport =
//                 airportData[flightData['DepartureAirportID']];
//             var arrivalAirport = airportData[flightData['ArrivalAirportID']];

//             if (departureAirport != null && arrivalAirport != null) {
//               // Check for duplicates
//               if (!processedBookings.contains(bookingKey)) {
//                 departureAirport.forEach((key, value) {
//                   DepartureCity.value = key;
//                   DepartureLocation.value = value['Location'];
//                 });
//                 arrivalAirport.forEach((key, value) {
//                   ArrivalCity.value = key;
//                   ArrivalLocation.value = value['Location'];
//                 });

//                 bookingsDetailsUpcoming.add(FlightBookingsClass1.fromMap({
//                   'companyName':
//                       flightCompanyData['AirlineCompanyName'].toString(),
//                   'bookingDate': bookingData['bookingdate'],
//                   'DepartureDate': flightData['DepartureDate'],
//                   'ArrivalDate': flightData['ArrivalDate'],
//                   'totalPrice': bookingData['TotalTicketPrice'].toString(),
//                   'NumberPassengerer':
//                       bookingData['passengerIds'].length.toString(),
//                   'bookingId': bookingKey,
//                   'FlightNumber': bookingData['flightId'],
//                   'logo': flightCompanyData['logo'],
//                   'DepartureLocation': DepartureLocation.value,
//                   'ArrivalLocation': ArrivalLocation.value,
//                   'DepartureCity': DepartureCity.value,
//                   'ArrivalCity': ArrivalCity.value,
//                   'ArrivalTime': flightData['ArrivalTime'],
//                   'DepartureTime': flightData['DepartureTime'],
//                 }));

//                 processedBookings.add(bookingKey);
//               }
//               print('ertyuuuuuuuuuuuuu');
//               print(bookingsDetailsUpcoming.length);
//             }
//           }
//         }
//       }
//     }
//     update();
//     isLoadingflightupcoming = false.obs;
//   }

//   void getUserBookingFinished() async {
//     DatabaseReference ref = FirebaseDatabase.instance.reference();
//     final event = await ref.child('booking').once();
//     if (event.snapshot.exists) {
//       var bookingDetails =
//           Map<dynamic, dynamic>.from(event.snapshot.value as Map);
//       Set<String> processedBookings = Set<String>();

//       for (var bookingKey in bookingDetails.keys) {
//         var bookingData = bookingDetails[bookingKey];
//         if (bookingData['userId'].toString() == loggedinUser.uid.toString() &&
//             !processedBookings.contains(bookingKey)) {
//           await getUserBookingDetailsFinished(bookingData, bookingKey);
//           processedBookings.add(bookingKey);
//         } else {
//           isLoadingflightfinished = false.obs;
//         }
//       }
//     }
//   }

//   Future<void> getUserBookingDetailsFinished(
//       Map bookingData, String bookingKey) async {
//     DatabaseReference ref = FirebaseDatabase.instance.reference();

//     // Flight details
//     final flightEvent =
//         await ref.child('Flight').child(bookingData['flightId']).once();
//     if (flightEvent.snapshot.exists) {
//       Map<dynamic, dynamic> flightData =
//           Map<dynamic, dynamic>.from(flightEvent.snapshot.value as Map);

//       // Airline company details
//       final airlineEvent = await ref
//           .child('Airline_company')
//           .child(flightData['AirlinId'])
//           .once();
//       if (airlineEvent.snapshot.exists) {
//         Map<dynamic, dynamic> flightCompanyData =
//             Map<dynamic, dynamic>.from(airlineEvent.snapshot.value as Map);

//         final DateFormat formatter = DateFormat('d. M, y');
//         final String formattedDepartureDate = flightData['DepartureDate'];
//         final String formattedNow = formatter.format(DateTime.now());

//         DateTime departureDate = formatter.parse(formattedDepartureDate);
//         DateTime now = formatter.parse(formattedNow);

//         if (departureDate.isBefore(now)) {
//           print('gggggggggggggggggggggggggggggggggggg');
//           var airportEvent = await ref.child('Airport').once();
//           if (airportEvent.snapshot.exists) {
//             var airportData =
//                 Map<dynamic, dynamic>.from(airportEvent.snapshot.value as Map);

//             var departureAirport =
//                 airportData[flightData['DepartureAirportID']];
//             var arrivalAirport = airportData[flightData['ArrivalAirportID']];

//             if (departureAirport != null && arrivalAirport != null) {
//               // Check for duplicates
//               bool isDuplicate = bookingsDetailsFinished.any((booking) =>
//                   booking.bookingId == bookingKey &&
//                   booking.FlightNumber == bookingData['flightId']);

//               if (!isDuplicate) {
//                 print(bookingData['TotalTicketPrice'].toString());
//                 print('iiiiiiiiiiiiiiiiiiiiiiiiii');
//                 print(flightCompanyData['AirlineCompanyName'].toString());
//                 print('nnnnnnnnnnnnnnn');
//                 print(departureAirport);
//                 departureAirport.forEach((key, value) {
//                   DepartureCity.value = key;
//                   DepartureLocation.value = value['Location'];
//                 });
//                 arrivalAirport.forEach((key, value) {
//                   ArrivalCity.value = key;
//                   ArrivalLocation.value = value['Location'];
//                 });
//                 print('DepartureLocation: ${departureAirport['Location']}');
//                 print('ArrivalLocation: ${arrivalAirport['Location']}');

//                 bookingsDetailsFinished.add(FlightBookingsClass1.fromMap({
//                   'companyName':
//                       flightCompanyData['AirlineCompanyName'].toString(),
//                   'bookingDate': bookingData['bookingdate'],
//                   'DepartureDate': flightData['DepartureDate'],
//                   'ArrivalDate': flightData['ArrivalDate'],
//                   'totalPrice': bookingData['TotalTicketPrice'].toString(),
//                   'NumberPassengerer':
//                       bookingData['passengerIds'].length.toString(),
//                   'bookingId': bookingKey,
//                   'FlightNumber': bookingData['flightId'],
//                   'logo': flightCompanyData['logo'],
//                   'DepartureLocation': DepartureLocation.value,
//                   'ArrivalLocation': ArrivalLocation.value,
//                   'DepartureCity': DepartureCity.value,
//                   'ArrivalCity': ArrivalCity.value,
//                   'ArrivalTime': flightData['ArrivalTime'],
//                   'DepartureTime': flightData['DepartureTime'],
//                 }));
//               }
//             }
//           }
//         }
//       }
//     }
//     print('wwwwwwwwwwwwwwwwww');
//     print(bookingsDetailsUpcoming.value.length);
//     update();
//     isLoadingflightfinished = false.obs;
//   }
// }

// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unnecessary_null_comparison, deprecated_member_use, prefer_collection_literals, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/hotel1.dart';
import '../classes/car_side_upcoming_class1.dart';
import '../classes/flight_booking_class1.dart';

class FlightBookingsController extends GetxController {
  var bookingsDetailsUpcoming = <FlightBookingsClass1>[].obs;
  var bookingsDetailsFinished = <FlightBookingsClass1>[].obs;
  var NewbookingRoom = false.obs;
  var Hotels = <HotelClass1>[].obs;
  var validHotels = <HotelClass1>[].obs;
  final _auth = FirebaseAuth.instance;
  var NewbookingFlight = false.obs;

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
    final event = await ref.child('booking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      for (var bookingKey in bookingDetails.keys) {
        var bookingData = bookingDetails[bookingKey];
        final DateFormat formatter = DateFormat('d. M, y');
        // final String formattedDropOffDate = bookingData['PickupDate'];
        final String formattedNow = formatter.format(DateTime.now());
        // DateTime dropOffDate = formatter.parse(formattedDropOffDate);
        DateTime now = formatter.parse(formattedNow);
        // if (dropOffDate.isAfter(now)) {
        if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
          await getBookingDetailsUpcoming(bookingData, bookingData['flightId']);
        }
      }
      // }
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
      final companyEvent = await ref.child('Airline_company').once();
      if (companyEvent.snapshot.exists) {
        Map<dynamic, dynamic> companyData =
            Map<dynamic, dynamic>.from(companyEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsEvent = await ref.child('RatingFlight').once();
        double ratingValue = 0.0;
        if (ratingsEvent.snapshot.exists) {
          var ratingsData = ratingsEvent.snapshot.value;
          if (ratingsData is Map) {
            ratingsData = Map<dynamic, dynamic>.from(ratingsData);
            if (ratingsData['flightId'] == carId) {
              ratingValue = ratingsData['Rating'];
            }
          } else if (ratingsData is List) {
            ratingsData = List<dynamic>.from(ratingsData);
            for (var rating in ratingsData) {
              if (rating != null && rating['flightId'] == carId) {
                ratingValue = rating['Rating'];
                break;
              }
            }
          }
        }

        // Add booking details
        if (!addedIdsFinished.contains(carId)) {
          bookingsDetailsUpcoming.add(FlightBookingsClass1.fromMap({
            'companyName': companyData['AirlineCompanyName'].toString(),
            'bookingDate': bookingData['bookingdate'],
            'DepartureDate': carData['DepartureDate'],
            'ArrivalDate': carData['ArrivalDate'],
            'totalPrice': bookingData['TotalTicketPrice'].toString(),
            'NumberPassengerer': bookingData['passengerIds'].length.toString(),
            // 'bookingId': bookingKey,
            'FlightNumber': bookingData['flightId'],
            'logo': companyData['logo'],
            'DepartureLocation': bookingData['bookingdate'],
            'ArrivalLocation': bookingData['bookingdate'],
            'DepartureCity': bookingData['bookingdate'],
            'ArrivalCity': bookingData['bookingdate'],
            'ArrivalTime': carData['ArrivalTime'],
            'DepartureTime': carData['DepartureTime'],
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
    final event = await ref.child('booking').once();
    if (event.snapshot.exists) {
      var bookingDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      bookingDetails.forEach((bookingKey, value) async {
        Map<dynamic, dynamic> bookingData = value;
        final DateFormat formatter = DateFormat('d. M, y');
        // final String formattedDropOffDate = value['DropOffDate'];
        // final String formattedNow = formatter.format(DateTime.now());
        // DateTime DropOffDate = formatter.parse(formattedDropOffDate);
        // DateTime now = formatter.parse(formattedNow);

        // // if (DropOffDate.isBefore(now) || DropOffDate == now) {
        if (bookingData['userId'].toString() == loggedinUser.uid.toString()) {
          await getBookingDetailsFinished(bookingData, bookingData['flightId']);
          //  }
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
    final roomEvent =
        await ref.child('Flight').child(bookingData['flightId']).once();
    if (roomEvent.snapshot.exists) {
      Map<dynamic, dynamic> roomData =
          Map<dynamic, dynamic>.from(roomEvent.snapshot.value as Map);

      // Fetch hotel details
      final hotelEvent = await ref.child('Airline_company').once();
      if (hotelEvent.snapshot.exists) {
        Map<dynamic, dynamic> hotelData =
            Map<dynamic, dynamic>.from(hotelEvent.snapshot.value as Map);

        // Fetch ratings
        var ratingsHotel = await ref.child('RatingsFlight').once();
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
          if (ratingsHotelData is Map &&
              ratingsHotelData['FlightId'] == carId) {
            ratingValue = ratingsHotelData['FlightId'];
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
            addBookingDetails(
                hotelData, roomData, bookingData, bookingData['flightId'], 0.0);
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
      if (!bookingsDetailsFinished
          .any((booking) => booking.FlightNumber == carId)) {
        print(carId);
        print('UHBB');
        bookingsDetailsFinished.add(FlightBookingsClass1.fromMap({
          'companyName': hotelData['AirlineCompanyName'].toString(),
          'bookingDate': bookingData['bookingdate'],
          'DepartureDate': roomData['DepartureDate'],
          'ArrivalDate': roomData['ArrivalDate'],
          'totalPrice': bookingData['TotalTicketPrice'].toString(),
          'NumberPassengerer': bookingData['passengerIds'].length.toString(),
          // 'bookingId': bookingKey,
          'FlightNumber': bookingData['flightId'],
          'logo': roomData['logo'],
          'DepartureLocation': bookingData['bookingdate'],
          'ArrivalLocation': bookingData['bookingdate'],
          'DepartureCity': bookingData['bookingdate'],
          'ArrivalCity': bookingData['bookingdate'],
          'ArrivalTime': roomData['ArrivalTime'],
          'DepartureTime': roomData['DepartureTime'],
        }));
      }
    });
  }
}
