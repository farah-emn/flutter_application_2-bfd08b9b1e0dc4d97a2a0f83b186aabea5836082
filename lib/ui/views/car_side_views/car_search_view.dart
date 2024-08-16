// ignore_for_file: non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unused_element, unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/car_card.dart';
import 'package:traveling/classes/hotel_room_details_class1.dart';
import 'package:traveling/controllers/currency_controller.dart';
import '../../../classes/car_class1.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_search_textfield.dart';

class CarSearchView extends StatefulWidget {
  const CarSearchView({super.key});
  @override
  State<CarSearchView> createState() => _CarSearchViewState();
}

class _CarSearchViewState extends State<CarSearchView> {
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());
  ValueNotifier<List<CarClass1>> HotelRooms =
      ValueNotifier<List<CarClass1>>([]);
  final _SearchController = TextEditingController();
  Map<dynamic, dynamic> HotelRoom = {};
  bool? isChecked = false;
  late User loggedinUser;
  final _auth = FirebaseAuth.instance;
  late final User? user;
  var Companylogo;
  var CarId = '';
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
    ref = FirebaseDatabase.instance.ref('Car_Rental_Company');
    user = _auth.currentUser;
    getData();
    super.initState();
  }

  void getData() async {
    CarId = user!.uid.toString();
    final event = await ref.child(CarId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    if (mounted) {
      setState(() {
        CompanyName = userData['car_name_company'];
      });
      print(userData['car_name_company']);
    }

    if (mounted) {
      HotelRoomsList();
    }
  }

  List<CarClass1> originalHotelRooms = []; // Store the original list of rooms

  Future<void> HotelRoomsList() async {
    List<CarClass1> rooms = [];
    await FirebaseDatabase.instance
        .reference()
        .child('Car')
        .orderByChild('CarCompanyId')
        .equalTo(user!.uid.toString())
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var RoomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        RoomData.forEach((Roomkey, value) {
          print('fgggggg');
          print(value['Seats']);
          rooms.add(CarClass1.fromMap({
            'id': Roomkey,
            'color': value['Color'],
            'company': value['CarCompany'],
            'ger': value['Ger'],
            // 'overview': value['Overview'],
            'plate': value['PlateNumber'],
            'rentalInDay': value['RentalInDay'],
            'rentalInWeak': value['RentalInWeek'],
            'seats': value['Seats'].toString(),
            'topSpeed': value['Speed'],
            'image': value['CarPhoto'],
            'model': value['model'],
            'is_reserved': value['is_reserved'],
            'companyRentailName': CompanyName
          }));
        });
      }
    });
    if (mounted) {
      setState(() {
        HotelRooms.value = rooms;
        originalHotelRooms = List.from(HotelRooms.value);
        print('[]]');
        print(HotelRooms.value.length);
      });
    }
  }

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
      var HotelRoomPrice = HotelRooms.value
          .map((entry) => entry.rentalInDay.toDouble())
          .toList();

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
      RangeValues _currentRangeValues = RangeValues(100, 1000);
      // Future<void> _Confirm() async {
      //   List<CarClass1> filteredRooms = [];
      //   for (var Room in originalHotelRooms) {
      //     // Use originalHotelRooms for filtering
      //     var HotelRoomPrice = convert(
      //         'USD',
      //         HotelCurrency_Controller.selectedCurrency.value,
      //         double.parse(Room.rentalInDay.toString()));

      //     bool company = (Room.company == dropdownValue2);
      //     print(
      //         "Company filter: $dropdownValue2, Room company: ${Room.company}");

      //     if (company) {
      //       filteredRooms.add(Room);
      //     }
      //   }

      //   setState(() {
      //     HotelRooms.value = filteredRooms;
      //   });

      //   if (filteredRooms.isEmpty) {
      //     // Show a message or handle the empty state
      //     print("No rooms match the selected criteria.");
      //     // You can also update the UI to show a message to the user
      //   }

      //   Navigator.pop(context);
      // }
      Future<void> _Confirm() async {
        List<CarClass1> filteredRooms = [];
        for (var Room in originalHotelRooms) {
          // Use originalHotelRooms for filtering
          var HotelRoomPrice = convert(
              'USD',
              HotelCurrency_Controller.selectedCurrency.value,
              double.parse(Room.rentalInDay.toString()));

          bool company = (Room.company == dropdownValue2);
          bool Color = Room.color == getColorName(selectedColor.value) ||
              selectedColor == '';
          bool ger = (Room.ger == sorteBy) || (sorteBy == '');
          bool Seats = true;
          bool s2 = false;
          bool s4 = false;
          bool s6 = false;

          for (int i = 0; i < isSelected.length; i++) {
            setState(() {
              if (isSelected[0] == true) {
                s2 = true;
              }
              if (isSelected[1] == true) {
                s4 = true;
              }
              if (isSelected[2] == true) {
                s6 = true;
              }
            });
          }

          print(s2);
          print(s4);
          print(s6);
          if (company && Color) {
            if (s2) {
              print('33');
              if (Room.seats == 2) filteredRooms.add(Room);
            }
            if (s4) {
              print('44');
              filteredRooms.add(Room);
            }
            if (s6) {
              print('66');
              if (Room.seats == 6) filteredRooms.add(Room);
            }
          }
        }

        setState(() {
          HotelRooms.value = filteredRooms;
          NumberOfResultFilteredHotelRooms = filteredRooms.length;
        });
        if (filteredRooms.isEmpty) {}
        Navigator.pop(context);
      }

      void _Search() {
        setState(() {
          HotelRooms.value = List.from(originalHotelRooms);
        });
        _Confirm();
      }

      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              void NumberOfHotelRooms() {
                filteredEntries = HotelRooms.value.where((Room) {
                  var HotelRoomPrice = convert(
                      'USD',
                      HotelCurrency_Controller.selectedCurrency.value,
                      double.parse(Room.rentalInDay.toString()));
                  bool matchescompany = (Room.company == dropdownValue2);
                  bool Color =
                      Room.color == getColorName(selectedColor.value) ||
                          selectedColor == '';
                  bool ger = (Room.ger == sorteBy) || (sorteBy == '');
                  bool matchesPriceRange =
                      (HotelRoomPrice >= _currentRangeValues.start.round() &&
                          HotelRoomPrice <= _currentRangeValues.end.round());
                  return matchescompany && Color && ger && matchesPriceRange;
                }).toList();

                setState(() {
                  NumberOfResultFilteredHotelRooms = filteredEntries.length;
                  HotelRooms.value = filteredEntries;
                });

                if (filteredEntries.isEmpty) {}
              }

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [],
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'Company',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grayText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width - 35,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.LightGrayColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.white,
                                  padding: EdgeInsets.only(left: 15),
                                  underline: DecoratedBox(
                                    decoration: BoxDecoration(),
                                  ),
                                  value: dropdownValue2,
                                  items: <String>[
                                    'Marceds',
                                    'KIA',
                                    'Rang Rover',
                                    'Roz Raiz',
                                    'Honday',
                                    'Honda',
                                    'Toyota',
                                    'GMC',
                                    'Odi',
                                    'BMW',
                                    'Other'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setModalState(() {
                                      print(newValue);
                                      print('lllllllll');
                                      dropdownValue2 = newValue!;
                                      NumberOfHotelRooms();
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                height: 1,
                                width: size.width - 30,
                                color: AppColors.gray,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'Color',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grayText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: colors.map((color) {
                                    return GestureDetector(
                                      onTap: () {
                                        setModalState(() {
                                          selectedColor = color;
                                        });
                                        print(selectedColor.value);
                                        print(
                                            getColorName(selectedColor.value));
                                        print('qwertyuiopv');
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color,
                                          border: selectedColor == color
                                              ? Border.all(
                                                  color: Colors.black, width: 3)
                                              : null,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                height: 1,
                                width: size.width - 30,
                                color: AppColors.gray,
                              ),
                              ToggleButtons(
                                disabledColor: AppColors.grayText,

                                borderColor: AppColors.LightGrayColor,
                                borderRadius: BorderRadius.circular(15),
                                // focusColor: AppColors.grayText,
                                fillColor: AppColors.lightGray,
                                selectedColor: AppColors.blackColor,
                                selectedBorderColor: AppColors.lightGray,
                                color: AppColors.grayText,

                                isSelected: isSelected,
                                onPressed: (int index) {
                                  setModalState(() {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                      print(isSelected[i]);
                                    }
                                  });
                                },
                                constraints: BoxConstraints(
                                  minWidth: size.width / 3 - 21.5,
                                  minHeight: 40.0,
                                ),
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text('2 Seats'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text('4 Seats'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text('6 Seats'),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                height: 1,
                                width: size.width - 30,
                                color: AppColors.gray,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'Ger',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grayText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.orange,
                                        value: 'Normal',
                                        autofocus: true,
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setModalState(() {
                                            sorteBy = value.toString();
                                          });
                                        },
                                      ),
                                      const Text('Normal'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.orange,
                                        value: 'Automatic',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setModalState(() {
                                            sorteBy = value.toString();
                                          });
                                        },
                                      ),
                                      const Text('Automatic'),
                                    ],
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                height: 1,
                                width: size.width - 30,
                                color: AppColors.gray,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price range',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.grayText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RangeSlider(
                                      values: _currentRangeValues,
                                      activeColor: AppColors.darkGray,
                                      inactiveColor: AppColors.gray,
                                      // min: MinPrice,
                                      // max: MaxPrice,
                                      min: 100,
                                      max: 1000,
                                      divisions: 100,
                                      labels: RangeLabels(
                                        _currentRangeValues.start
                                            .round()
                                            .toString(),
                                        _currentRangeValues.end
                                            .round()
                                            .toString(),
                                      ),
                                      onChanged: (RangeValues values) {
                                        setModalState(() {
                                          _currentRangeValues = values;
                                          NumberOfHotelRooms();
                                        });
                                      }),
                                  Row(
                                    children: [
                                      Text(
                                          'Min price: ${_currentRangeValues.start.round()} '),
                                      Text(HotelCurrency_Controller
                                          .selectedCurrency.value),
                                      const Spacer(),
                                      Text(
                                          'Max price: ${_currentRangeValues.end.round()} '),
                                      Text(HotelCurrency_Controller
                                          .selectedCurrency.value)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: _Confirm,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 50,
                            width: size.width - 30,
                            decoration: BoxDecoration(
                                color: AppColors.darkGray,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Show 138 of 210 Rooms',

                                  // dropdownValue2 == 'Toyota' && sorteBy == ''
                                  //     // selectedColor.value == ''
                                  //     ? 'Show ${originalHotelRooms.length} of ${originalHotelRooms.length} Rooms'
                                  //     : 'Show $NumberOfResultFilteredHotelRooms of ${originalHotelRooms.length} Rooms',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),

                                // (dropdownValue2 == 'Toyota'
                                //     // _currentRangeValues.start
                                //     //         .round()
                                //     //         .toString() ==
                                //     //     MinPrice &&
                                //     // _currentRangeValues.end
                                //     //         .round()
                                //     //         .toString() ==
                                //     //     MaxPrice
                                //     )
                                //     ? Text(
                                //         'Show ${HotelRooms.value.length} of ${originalHotelRooms.length} Rooms',
                                //         style: const TextStyle(
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.w500),
                                //       )
                                //     : Text(
                                //         'Show $NumberOfResultFilteredHotelRooms of ${originalHotelRooms.length} Rooms',
                                //         style: const TextStyle(
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.w500),
                                //       ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightGray,

        // appBar: AppBar(
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('Search'),
        //     ],
        //   ),
        // ),
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 35),
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
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width - 30,
                        child: TextField(
                          // onSubmitted: _SearchRoomController,
                          // onChanged: (value) {
                          //   setState(() {
                          //     _SearchController.text = value;
                          //     // _SearchRoomController(value);
                          //   });
                          onChanged: (value) {
                            _SearchCarController(value);
                          },
                          controller: _SearchController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: searchTextFielDecoratiom.copyWith(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(
                                  color: AppColors.lightGray, width: 1.5),
                            ),
                            hintText: "Search",
                            suffixIcon: InkWell(
                              onTap: _showBottomShest,
                              child: const Icon(
                                Icons.filter_alt,
                                color: AppColors.LightGrayColor,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.grayText,
                            ),
                          ),
                        
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                          itemCount: HotelRooms.value.length,
                          itemBuilder: (context, index) => CarCard(
                            size: size,
                            itemIndex: index,
                            carDetails: HotelRooms.value[index],
                          ),
                        ),
                      ),
               ] ),
                    // )
                    // : SizedBox(),
                )
                ]
              ),
            )],
          ),
        );
  }

  void _SearchCarController(String value) {
    setState(() {
      HotelRooms.value = originalHotelRooms.where((Room) {
        bool HotelRoom = (_SearchController.text.isEmpty) ||
            (Room.model
                .toLowerCase()
                .contains(_SearchController.text.toLowerCase()));
        return HotelRoom;
      }).map((entry) {
        return CarClass1.fromMap({
          "id": entry.id,
          'color': entry.color,
          'company': entry.company,
          'ger': entry.ger,
          'plate': entry.plate,
          'rentalInDay': entry.rentalInDay,
          'rentalInWeak': entry.rentalInWeak,
          'seats': entry.seats.toString(),
          'topSpeed': entry.topSpeed,
          'image': entry.image,
          'model': entry.model,
          'is_reserved': entry.is_reserved,
        });
      }).toList();
    });
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
    };
    print(colorNames[color]);
    return colorNames[color] ?? 'Unknown Color';
  }
}
