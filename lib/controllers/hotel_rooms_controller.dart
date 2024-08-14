// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/hotel_search_controller.dart';

class HotelRoomsController extends GetxController {
  var hotelRooms = <RoomDetailsClass>[].obs;
  var hotelsRooms = <RoomDetailsClass>[].obs;
  var averageRating = 1.1.obs;
  var HotelaverageRating = 1.1.obs;
  Future<void> HotelsRooms() async {
    final ref = FirebaseDatabase.instance.reference().child('Room');
    final event = await ref.once();
    if (event.snapshot.exists) {
      var roomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      var fetchedRooms = roomData.entries.where((entry) {
        return true;
      }).map((entry) {
        HotelsRoomsBooking();
        return RoomDetailsClass.fromMap({
          "id": entry.key,
          "HotelId": entry.value['HotelId'],
          'Adults': entry.value['Adults'],
          "Children": entry.value['Children'],
          "Overview": entry.value['Overview'],
          "Price": entry.value['Price'],
          "NumberOfBedrooms": entry.value['NumberOfBedrooms'],
          "NumberOfBeds": entry.value['NumberOfBeds'],
          "RoomNumber": entry.value['RoomNumber'],
          "NumberOfRooms": entry.value['NumberOfRooms'],
          "RoomPhoto": entry.value['RoomPhoto'],
          "isCheckedPrivateParking": entry.value['isCheckedPrivateParking'],
          "isCheckedCleaningServices": entry.value['isCheckedCleaningServices'],
          "isCheckedFoodAnddrink": entry.value['isCheckedFoodAnddrink'],
          "isCheckedFreeWifi": entry.value['isCheckedFreeWifi'],
          "isCheckedPrivatePool": entry.value['isCheckedPrivatePool'],
        });
      }).toList();

      hotelsRooms.value = fetchedRooms;
    }
  }

  Future<void> SpecificHotelRooms(String hotelId) async {
    final DateFormat formatter = DateFormat('d. M, y');

    final ref = FirebaseDatabase.instance.reference().child('Room');
    final refhotel_booking =
        FirebaseDatabase.instance.reference().child('hotel_booking');
    final refRatings =
        FirebaseDatabase.instance.reference().child('RatingsHotel');
    SearchHotelController search_hotel_controller =
        Get.put(SearchHotelController());
    final event = await ref.once();
    final event_hotel_booking = await refhotel_booking.once();
    final event_ratings = await refRatings.once();

    if (event.snapshot.exists) {
      var roomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      var roomEntries = roomData.entries.toList();

      var fetchedRooms = roomEntries.where((entry) {
        bool isWithinDateRange = false;
        if (entry.value['HotelId'] == hotelId) {
          if (event_hotel_booking.snapshot.exists) {
            var hotel_booking = Map<dynamic, dynamic>.from(
                event_hotel_booking.snapshot.value as Map);
            for (var element in hotel_booking.entries) {
              if (element.value['RoomId'] == entry.key) {
                final DepartureDate =
                    formatter.parse(element.value['DepartureDate']);
                final SearchDepartureDate = DateTime(
                  search_hotel_controller.departureDate.value.year,
                  search_hotel_controller.departureDate.value.month,
                  search_hotel_controller.departureDate.value.day,
                );

                final ArrivalDate =
                    formatter.parse(element.value['ArrivalDate']);
                final SearchArrivalDate = DateTime(
                  search_hotel_controller.ArrivalDate.value.year,
                  search_hotel_controller.ArrivalDate.value.month,
                  search_hotel_controller.ArrivalDate.value.day,
                );

                isWithinDateRange = (SearchArrivalDate.isAfter(ArrivalDate) ||
                        SearchArrivalDate.isAtSameMomentAs(ArrivalDate)) &&
                    (SearchDepartureDate.isBefore(DepartureDate) ||
                        SearchDepartureDate.isAtSameMomentAs(DepartureDate));
              }
            }
          }
          return !isWithinDateRange;
        } else {
          return false;
        }
      }).map((entry) {
        double ratingValue = 0.0;
        if (event_ratings.snapshot.exists) {
          var ratingsHotelData = event_ratings.snapshot.value;
          if (ratingsHotelData is Map) {
            if (ratingsHotelData.containsKey(entry.key)) {
              ratingValue = ratingsHotelData[entry.key]['Rating'] is num
                  ? (ratingsHotelData[entry.key]['Rating'] as num).toDouble()
                  : 0.0;
            }
          } else if (ratingsHotelData is List) {
            for (var rating in ratingsHotelData) {
              if (rating != null && rating['RoomId'] == entry.key) {
                ratingValue = rating['Rating'] is num
                    ? (rating['Rating'] as num).toDouble()
                    : 0.0;
                break;
              }
            }
          }
        }

        return RoomDetailsClass.fromMap({
          "id": entry.key,
          "HotelId": entry.value['HotelId'],
          'Adults': entry.value['Adults'],
          "Children": entry.value['Children'],
          "Overview": entry.value['Overview'],
          "Price": entry.value['Price'],
          "NumberOfBedrooms": entry.value['NumberOfBedrooms'],
          "NumberOfRooms": entry.value['NumberOfRooms'].toString(),
          "NumberOfBeds": entry.value['NumberOfBeds'],
          "RoomNumber": entry.value['RoomNumber'],
          "RoomPhoto": entry.value['RoomPhoto'],
          "isCheckedPrivateParking": entry.value['isCheckedPrivateParking'],
          "isCheckedCleaningServices": entry.value['isCheckedCleaningServices'],
          "isCheckedFoodAnddrink": entry.value['isCheckedFoodAnddrink'],
          "isCheckedFreeWifi": entry.value['isCheckedFreeWifi'],
          "isCheckedPrivatePool": entry.value['isCheckedPrivatePool'],
          'RatingRoom': ratingValue // Ensure the key matches the constructor
        });
      }).toList();

      hotelRooms.value = fetchedRooms;
    }
  }

  Future<bool> HotelsRoomsBooking() async {
    SearchHotelController search_hotel_controller =
        Get.put(SearchHotelController());
    final ref = FirebaseDatabase.instance.reference().child('hotel_booking');
    final event = await ref.once();
    if (event.snapshot.exists) {
      var bookingData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      var filteredBookings = bookingData.entries.where((entry) {
        final DateFormat formatter = DateFormat('d. M, y');
        final DepartureDate = formatter.parse(entry.value['DepartureDate']);
        final SearchDepartureDate = DateTime(
          search_hotel_controller.departureDate.value.year,
          search_hotel_controller.departureDate.value.month,
          search_hotel_controller.departureDate.value.day,
        );

        final ArrivalDate = formatter.parse(entry.value['ArrivalDate']);
        final SearchArrivalDate = DateTime(
          search_hotel_controller.ArrivalDate.value.year,
          search_hotel_controller.ArrivalDate.value.month,
          search_hotel_controller.ArrivalDate.value.day,
        );

        bool isWithinDateRange = (SearchArrivalDate.isAfter(ArrivalDate) ||
                SearchArrivalDate.isAtSameMomentAs(ArrivalDate)) &&
            (SearchDepartureDate.isBefore(DepartureDate) ||
                SearchDepartureDate.isAtSameMomentAs(DepartureDate));
        return isWithinDateRange;
      }).toList();

      return filteredBookings.isNotEmpty;
    }
    return false;
  }

  Future<void> getRoomRating(String RoomKey) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final refRatings = ref.child('RatingsHotel');
    final event_ratings = await refRatings.once();

    if (event_ratings.snapshot.exists) {
      var ratingsHotelData = event_ratings.snapshot.value;
      double totalRating = 0.0;
      int ratingCount = 0;

      if (ratingsHotelData is Map) {
        ratingsHotelData.forEach((key, value) {
          if (value['RoomId'] == RoomKey) {
            totalRating += value['Rating'] is num
                ? (value['Rating'] as num).toDouble()
                : 0.0;
            ratingCount++;
          }
        });
      } else if (ratingsHotelData is List) {
        for (var rating in ratingsHotelData) {
          if (rating != null && rating['RoomId'] == RoomKey) {
            totalRating += rating['Rating'] is num
                ? (rating['Rating'] as num).toDouble()
                : 0.0;
            ratingCount++;
          }
        }
      }

      averageRating.value = ratingCount > 0 ? totalRating / ratingCount : 0.0;
    } else {}
  }

  Future<void> getAllRoomRatings(String hotelId) async {
    final ref = FirebaseDatabase.instance.reference().child('Room');
    final refRatings =
        FirebaseDatabase.instance.reference().child('RatingsHotel');
    final event = await ref.once();
    final event_ratings = await refRatings.once();

    if (event.snapshot.exists) {
      var roomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      var roomEntries = roomData.entries.toList();

      double totalHotelRating = 0.0;
      int totalRoomCount = 0;

      for (var entry in roomEntries) {
        if (entry.value['HotelId'] == hotelId) {
          double totalRating = 0.0;
          int ratingCount = 0;

          if (event_ratings.snapshot.exists) {
            var ratingsHotelData = event_ratings.snapshot.value;
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

  // DatabaseReference ref = FirebaseDatabase.instance.reference();
  // final refRatings = ref.child('RatingsHotel');
  // final event_ratings = await refRatings.once();

  // if (event_ratings.snapshot.exists) {
  //   var ratingsHotelData = event_ratings.snapshot.value;

  //   for (var room in hotelRooms) {
  //     double totalRating = 0.0;
  //     int ratingCount = 0;

  //     if (ratingsHotelData is Map) {
  //       ratingsHotelData.forEach((key, value) {
  //         if (value['RoomId'] == room.id) {
  //           totalRating += value['Rating'] is num
  //               ? (value['Rating'] as num).toDouble()
  //               : 0.0;
  //           ratingCount++;
  //         }
  //       });
  //     } else if (ratingsHotelData is List) {
  //       for (var rating in ratingsHotelData) {
  //         if (rating != null && rating['RoomId'] == room.id) {
  //           totalRating += rating['Rating'] is num
  //               ? (rating['Rating'] as num).toDouble()
  //               : 0.0;
  //           ratingCount++;
  //         }
  //       }
  //     }

  //     HotelaverageRating.value =
  //         ratingCount > 0 ? totalRating / ratingCount : 0.0;
  //     print(
  //         'Average rating for room ${room.id}: ${HotelaverageRating.value}');
  //   }
  // } else {
  //   print('No ratings found.');
  // }
}
