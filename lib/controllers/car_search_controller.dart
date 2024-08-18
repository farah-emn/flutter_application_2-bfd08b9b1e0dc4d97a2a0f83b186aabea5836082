// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_final_fields, avoid_print, deprecated_member_use, unnecessary_overrides, unused_local_variable, unnecessary_null_comparison

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../classes/car_class1.dart';
import '../ui/views/traveller_side_views/car_view.dart';

class CarSearchController extends GetxController {
  Rx<DateTime> DropOffDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<DateTime> PickUpDate = DateTime.now().obs;
  var selectedDate = '${DateTime.now().month}/${DateTime.now().day}'.obs;
  int NumberOfCars = 0;
  var isLoadingOneWay = false;
  var _PickUPlocation = ''.obs;
  get PickUPlocation => _PickUPlocation;
  var lastkey = ''.obs;
  double totalpriceflight = 0;
  RxMap<dynamic, dynamic> filteredCar = <dynamic, dynamic>{}.obs;
  ValueNotifier<List<CarClass1>> carsList = ValueNotifier<List<CarClass1>>([]);
  var Cars = <CarClass1>[].obs;
  var validCars = <CarClass1>[].obs;
  var isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void updateSelectedDate() {
    selectedDate.value =
        '${DateTime.now().day}. ${DateTime.now().month}, ${DateTime.now().year}';
  }

  String getFormattedPickUpDate() {
    return _formatDate(PickUpDate.value);
  }

  String _formatDate(DateTime date) {
    return '${date.day}. ${date.month}, ${date.year}';
  }

  String getFormattedDropOffDate() {
    return _formatDate(DropOffDate.value);
  }

  void setPickUplocation(String location) {
    _PickUPlocation.value = location;
  }

  // Future<void> searchForSpecificCarRenatl(String specificCarKey, sorteBy,
  //     isSelected, selectedColor, dropdownValue2) async {
  //   Cars.clear();
  //   validCars.clear();
  //   DatabaseReference ref = FirebaseDatabase.instance.reference();
  //   final event =
  //       await ref.child('Car_Rental_Company').child(specificCarKey).once();
  //   if (event.snapshot.exists != null) {
  //     Map<dynamic, dynamic> carCompanyData =
  //         Map<dynamic, dynamic>.from(event.snapshot.value as Map);
  //     Set<String> addedCars = {};
  //     if (carCompanyData['location'].toString() == _PickUPlocation.value) {
  //       searchForCar(carCompanyData, addedCars, sorteBy, isSelected,
  //           selectedColor, dropdownValue2);
  //     }
  //   } else {}
  // }

  Future<void> searchForCarRenatl(
      sorteBy, isSelected, selectedColor, dropdownValue2) async {
    Cars.clear();
    carsList.value.clear();
    validCars.clear();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final event = await ref.child('Car_Rental_Company').once();
    if (event.snapshot.exists) {
      var comanyDetails =
          Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      comanyDetails.forEach((companyKey, value) {
        if (value['location'].toString() == _PickUPlocation.value) {
          searchForCar(sorteBy, isSelected, selectedColor, dropdownValue2,
              value['location'], value['car_name_company']);
        }
      });
    } else {}
  }

  // Future<void> searchForCar(
  //   sorteBy,
  //   isSelected,
  //   selectedColor,
  //   dropdownValue2,
  // ) async {
  //   print('Searching for cars...');
  //   final DateFormat formatter = DateFormat('d. M, y');
  //   filteredCar.clear();
  //   String formattedDepartureDate = getFormattedPickUpDate();
  //   DatabaseReference ref = FirebaseDatabase.instance.reference();
  //   ref.child('Car').once().then((DatabaseEvent event) async {
  //     if (event.snapshot.exists) {
  //       var CarData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
  //       CarData.forEach((key, value) {
  //         var CarDetails = Map<dynamic, dynamic>.from(value);
  //         bool Company = CarDetails['CarCompany'] == dropdownValue2;
  //         bool color = CarDetails['Color'] == getColorName(selectedColor.value);
  //         bool ger = CarDetails['Ger'] == sorteBy;
  //         if (color && Company && ger) {
  //           filteredCar[key] = CarDetails;
  //         }
  //       });

  //       if (filteredCar.isNotEmpty) {
  //         var carFutures = filteredCar.entries.map((entry) async {
  //           if (await HotelsRoomsBooking(entry.key)) {
  //             return CarClass1.fromMap({
  //               'id': entry.key,
  //               'color': entry.value['Color'],
  //               'company': entry.value['CarCompany'],
  //               'ger': entry.value['Ger'],
  //               'overview': entry.value['Overview'],
  //               'plate': entry.value['PlateNumber'],
  //               'rentalInDay': entry.value['RentalInDay'],
  //               'rentalInWeak': entry.value['RentalInWeek'],
  //               'seats': entry.value['Seats'].toString(),
  //               'topSpeed': entry.value['Speed'],
  //               'image': entry.value['CarPhoto'],
  //               'is_reserved': entry.value['is_reserved'],
  //               'model': entry.value['model'],
  //               'companyRentailName': '[]',
  //               'pickupLocation': ';'
  //             });
  //           }
  //           return null;
  //         }).toList();

  //         carsList.value = (await Future.wait(carFutures))
  //             .where((car) => car != null)
  //             .cast<CarClass1>()
  //             .toList();

  //         if (carsList.value.isNotEmpty) Get.to(() => CarView());
  //       } else {
  //         print('No cars found matching the criteria.');
  //       }
  //     }
  //   });
  // }
  Future<void> searchForCar(
    sorteBy,
    isSelected,
    selectedColor,
    dropdownValue2,
    locvalue,
    namevalue,
  ) async {
    carsList.value.clear();
    final DateFormat formatter = DateFormat('d. M, y');
    filteredCar.clear();
    String formattedDepartureDate = getFormattedPickUpDate();
    isloading.value = true;

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Car').once().then((DatabaseEvent event) async {
      if (event.snapshot.exists) {
        carsList.value.clear();
        bool carFound = false; // Flag to track if any car is found

        var CarData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);

        CarData.forEach((key, value) {
          var CarDetails = Map<dynamic, dynamic>.from(value);
          bool color = CarDetails['Color'] == getColorName(selectedColor.value);
          bool ger = CarDetails['Ger'] == sorteBy;
          bool company = CarDetails['CarCompany'] == dropdownValue2;
          bool s2 = (CarDetails['Seats'] == 2 && isSelected[0]) ||
              (isSelected[0] == false);
          bool s4 = CarDetails['Seats'] == 4 && isSelected[1] ||
              (isSelected[1] == false);
          bool s6 = CarDetails['Seats'] == 6 && isSelected[2] ||
              (isSelected[2] == false);

          if (color && ger && company && s2 && s4 && s6) {
            carFound = true; // Set flag to true if any car matches the criteria
            filteredCar[key] = CarDetails;
            carsList.value.add(CarClass1.fromMap({
              'id': key,
              'color': CarDetails['Color'],
              'company': CarDetails['CarCompany'],
              'ger': CarDetails['Ger'],
              'overview': CarDetails['Overview'],
              'plate': value['PlateNumber'],
              'rentalInDay': CarDetails['RentalInDay'],
              'rentalInWeak': CarDetails['RentalInWeek'],
              'seats': CarDetails['Seats'].toString(),
              'topSpeed': CarDetails['Speed'],
              'image': CarDetails['CarPhoto'],
              'is_reserved': CarDetails['is_reserved'],
              'model': CarDetails['model'],
              'companyRentailName': namevalue,
              'pickupLocation': locvalue
            }));
          }
        });

        if (carFound) {
          Get.to(() => CarView());
        } else {
          Fluttertoast.showToast(
              msg: "No cars found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        isloading.value = false;
      } else if (carsList.value.isEmpty) {
        Fluttertoast.showToast(
            msg: "No cars found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        isloading.value = false;
      }
    }).catchError((error) {
      print("Error: $error");
      isloading.value = false;
    });
  }

  Future<bool> HotelsRoomsBooking(key) async {
    carsList.value.clear();
    final ref = FirebaseDatabase.instance.reference().child('CarBooking');
    final event = await ref.once();
    if (event.snapshot.exists) {
      var bookingData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
      var filteredBookings = bookingData.entries.where((entry) {
        if (key == entry.value['CarId']) {
          final DateFormat formatter = DateFormat('d. M, y');
          final DepartureDate = formatter.parse(entry.value['PickupDate']);
          final SearchPickUpDate = DateTime(
            PickUpDate.value.year,
            PickUpDate.value.month,
            PickUpDate.value.day,
          );

          final ArrivalDate = formatter.parse(entry.value['DropOffDate']);
          final SearchDropupDate = DateTime(
            DropOffDate.value.year,
            DropOffDate.value.month,
            DropOffDate.value.day,
          );

          bool isWithinDateRange = (SearchPickUpDate.isAfter(ArrivalDate) ||
              SearchPickUpDate.isAtSameMomentAs(ArrivalDate));
          // (SearchDropupDate.isBefore(DepartureDate) ||
          //     SearchDropupDate.isAtSameMomentAs(DepartureDate));
          return isWithinDateRange;
        }
        return false;
      }).toList();

      return filteredBookings.isNotEmpty;
    }
    return false;
  }

  String getColorName(int color) {
    print('kmm');
    Map<int, String> colorNames = {
      4286141768: 'Brown',
      4294198070: 'Red',
      4281626336: 'Blue',
      4288585374: 'Grey',
      4294965753: 'White',
      4278190080: 'Black',
      // Color(0xFF000000): 'Black',
      // Color(0xFFFFFFF9): 'white ',
    };
    print(colorNames[color]);
    return colorNames[color] ?? 'Unknown Color';
  }

  // Future<void> searchForCar(
  //   sorteBy,
  //   isSelected,
  //   selectedColor,
  //   dropdownValue2,
  // ) async {
  //   print('Searching for cars...');
  //   final DateFormat formatter = DateFormat('d. M, y');
  //   filteredCar.clear();
  //   String formattedDepartureDate = getFormattedPickUpDate();
  //   DatabaseReference ref = FirebaseDatabase.instance.reference();
  //   ref.child('Car').once().then((DatabaseEvent event) async {
  //     if (event.snapshot.exists) {
  //       var CarData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
  //       CarData.forEach((key, value) {
  //         var CarDetails = Map<dynamic, dynamic>.from(value);
  //         bool color = CarDetails['Color'] == getColorName(selectedColor.value);
  //         bool ger = CarDetails['Ger'] == sorteBy;
  //         if (color && ger) {
  //           filteredCar[key] = CarDetails;
  //           carsList.value.add(CarClass1.fromMap({
  //             'id': '999',
  //             'color': 'jj',
  //             'company': '88',
  //             'ger': 'ff',
  //             'overview': 'p[]',
  //             'plate': 'po',
  //             'rentalInDay': 100,
  //             'rentalInWeak': 990,
  //             'seats': 6,
  //             'topSpeed': 'po',
  //             'image': 'po',
  //             'is_reserved': 'pp',
  //             'model': 'po',
  //             'companyRentailName': '[]',
  //             'pickupLocation': ';'
  //           }));
  //           print('trueeeeeeeeeeeeeeeeeeeeeeee');
  //         }
  //       });

  //       if (carsList.value.isNotEmpty) {
  //         Get.to(() => CarView());
  //       } else {
  //         print('No cars found matching the criteria.');
  //       }
  //     }
  //   });
  // }
  void clearData() {
    PickUpDate.value = DateTime.now();
    DropOffDate.value = DateTime.now().add(const Duration(days: 1));
    selectedDate.value = '${DateTime.now().month}/${DateTime.now().day}';
    totalpriceflight = 0;
    update();
  }
}
