// ignore_for_file: non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/cards/hotel_room_card.dart';
import 'package:traveling/classes/hotel_room_details_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_search_textfield.dart';

class HotelSearchView extends StatefulWidget {
  const HotelSearchView({super.key});
  @override
  State<HotelSearchView> createState() => _HotelSearchViewState();
}

class _HotelSearchViewState extends State<HotelSearchView> {
  final CurrencyController HotelCurrency_Controller =
      Get.put(CurrencyController());
  ValueNotifier<List<RoomDetailsClass>> HotelRooms =
      ValueNotifier<List<RoomDetailsClass>>([]);
  final _SearchController = TextEditingController();
  Map<dynamic, dynamic> HotelRoom = {};
  var isloading = false.obs;
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
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Hotel');
    user = _auth.currentUser;
    getData();
    super.initState();
  }

  void getData() async {
    HotelId = user!.uid.toString();
    final event = await ref.child(HotelId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    if (mounted) {
      HotelRoomsList();
    }
  }

  Future<void> HotelRoomsList() async {
    List<RoomDetailsClass> rooms = [];
    await FirebaseDatabase.instance
        .reference()
        .child('Room')
        .orderByChild('HotelId')
        .equalTo(user!.uid.toString())
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        isloading.value = true;
        var RoomData = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        RoomData.forEach((Roomkey, value) {
          rooms.add(RoomDetailsClass.fromMap({
            "id": Roomkey,
            'Adults': value['Adults'],
            "Children": value['Children'],
            "Overview": value['Overview'],
            "Price": value['Price'],
            "NumberOfBedrooms": value['NumberOfBedrooms'],
            "NumberOfBeds": value['NumberOfBeds'],
            "RoomNumber": value['RoomNumber'],
            "NumberOfRooms": value['NumberOfRooms'],
            "RoomPhoto": value['RoomPhoto'],
            "isCheckedPrivateParking": value['isCheckedPrivateParking'],
            "isCheckedCleaningServices": value['isCheckedCleaningServices'],
            "isCheckedFoodAnddrink": value['isCheckedFoodAnddrink'],
            "isCheckedFreeWifi": value['isCheckedFreeWifi'],
            "isCheckedPrivatePool": value['isCheckedPrivatePool'],
            "is_reserved": value['is_reserved']
          }));
        });
      } else {
        isloading.value = false;
      }
    });
    if (mounted) {
      setState(() {
        HotelRooms.value = rooms;
        isloading.value = false;
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

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              void NumberOfHotelRooms() {
                filteredEntries = null;
                filteredEntries = HotelRooms.value.where((Room) {
                  var HotelRoomPrice = convert(
                      'USD',
                      HotelCurrency_Controller.selectedCurrency.value,
                      double.parse(Room.Price.toString()));
                  bool matchesFreeWifi = ((Room.isCheckedFreeWifi == true) &&
                          (isCheckedFreeWifi == true)) ||
                      (isCheckedFreeWifi == false);
                  bool CheckedPrivatePool =
                      ((Room.isCheckedPrivatePool == true) &&
                              (Room.isCheckedPrivatePool == true)) ||
                          (isCheckedPrivatePool == false);
                  bool CheckedFoodAnddrink =
                      ((Room.isCheckedFoodAnddrink == true) &&
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
                  bool matchesPriceRange =
                      (HotelRoomPrice >= _currentRangeValues.start.round() &&
                          HotelRoomPrice <= _currentRangeValues.end.round());
                  return matchesFreeWifi &&
                      CheckedPrivatePool &&
                      CheckedFoodAnddrink &&
                      CheckedCleaningServices &&
                      Checked24HourFrontDesk &&
                      matchesPriceRange;
                });
                setState(() {
                  NumberOfResultFilteredHotelRooms = filteredEntries.length;
                });
                filteredEntries = null;
              }

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
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
                              // const Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       'Stops',
                              //       style: TextStyle(
                              //           fontSize: 13,
                              //           color: AppColors.grayText,
                              //           fontWeight: FontWeight.w500),
                              //     ),
                              //   ],
                              // ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Checkbox(
                                  //       value: isCheckedDirect,
                                  //       onChanged: (bool? newValue) {
                                  //         setModalState(
                                  //           () {
                                  //             isCheckedDirect = newValue!;
                                  //             isCheckedIndirect = false;
                                  //             // filterFlights(
                                  //             //     _FromSearchController.text,
                                  //             //     _ToSearchController.text,
                                  //             //     isCheckedDirect!,
                                  //             //     isCheckedIndirect!,
                                  //             //     sorteBy,
                                  //             //     _currentRangeValues.start
                                  //             //         .round(),
                                  //             //     _currentRangeValues.end
                                  //             //         .round());
                                  //           },
                                  //         );
                                  //       },
                                  //     ),
                                  //     const Text('Direct Flight'),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Checkbox(
                                  //       value: isCheckedIndirect,
                                  //       onChanged: (bool? newValue) {
                                  //         setModalState(
                                  //           () {
                                  //             isCheckedIndirect = newValue!;
                                  //             isCheckedDirect = false;
                                  //             // filterFlights(
                                  //             //     _FromSearchController.text,
                                  //             //     _ToSearchController.text,
                                  //             //     isCheckedDirect!,
                                  //             //     isCheckedIndirect!,
                                  //             //     sorteBy,
                                  //             //     _currentRangeValues.start
                                  //             //         .round(),
                                  //             //     _currentRangeValues.end
                                  //             //         .round());
                                  //           },
                                  //         );
                                  //       },
                                  //     ),
                                  //     const Text('Indirect Flight'),
                                  //   ],
                                  // ),
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
                                    'Property Amenity',
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     Radio(
                                      //       activeColor:
                                      //           AppColors.mainColorBlue,
                                      //       value: 'Free wi-fi',
                                      //       groupValue: sorteBy,
                                      //       onChanged: (value) {
                                      //         sorteBy = value.toString();

                                      //         setModalState(() {
                                      //           // filterFlights(
                                      //           //     _FromSearchController.text,
                                      //           //     _ToSearchController.text,
                                      //           //     isCheckedDirect!,
                                      //           //     isCheckedIndirect!,
                                      //           //     sorteBy,
                                      //           //     _currentRangeValues.start
                                      //           //         .round(),
                                      //           //     _currentRangeValues.end
                                      //           //         .round());
                                      //         });
                                      //       },
                                      //     ),
                                      //     const Text('Free wi-fi'),
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: isCheckedFreeWifi,
                                            onChanged: (bool? newValue) {
                                              setModalState(
                                                () {
                                                  isCheckedFreeWifi = newValue!;
                                                  NumberOfHotelRooms();
                                                  // isCheckedIndirect = false;
                                                  // filterFlights(
                                                  //     _FromSearchController.text,
                                                  //     _ToSearchController.text,
                                                  //     isCheckedDirect!,
                                                  //     isCheckedIndirect!,
                                                  //     sorteBy,
                                                  //     _currentRangeValues.start
                                                  //         .round(),
                                                  //     _currentRangeValues.end
                                                  //         .round());
                                                },
                                              );
                                            },
                                          ),
                                          const Text('Free wi-fi'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: isCheckedFoodDrink,
                                            onChanged: (bool? newValue) {
                                              setModalState(
                                                () {
                                                  isCheckedFoodDrink =
                                                      newValue!;
                                                  NumberOfHotelRooms();
                                                  // filterFlights(
                                                  //     _FromSearchController.text,
                                                  //     _ToSearchController.text,
                                                  //     isCheckedDirect!,
                                                  //     isCheckedIndirect!,
                                                  //     sorteBy,
                                                  //     _currentRangeValues.start
                                                  //         .round(),
                                                  //     _currentRangeValues.end
                                                  //         .round());
                                                },
                                              );
                                            },
                                          ),
                                          const Text('Food & drink'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: isCheckedPrivatePool,
                                            onChanged: (bool? newValue) {
                                              setModalState(
                                                () {
                                                  isCheckedPrivatePool =
                                                      newValue!;
                                                  NumberOfHotelRooms();
                                                  // filterFlights(
                                                  //     _FromSearchController.text,
                                                  //     _ToSearchController.text,
                                                  //     isCheckedDirect!,
                                                  //     isCheckedIndirect!,
                                                  //     sorteBy,
                                                  //     _currentRangeValues.start
                                                  //         .round(),
                                                  //     _currentRangeValues.end
                                                  //         .round());
                                                },
                                              );
                                            },
                                          ),
                                          const Text('Private pool'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: isCheckedCleaningServices,
                                            onChanged: (bool? newValue) {
                                              setModalState(
                                                () {
                                                  isCheckedCleaningServices =
                                                      newValue!;
                                                  NumberOfHotelRooms();
                                                  // isCheckedIndirect = false;
                                                  // filterFlights(
                                                  //     _FromSearchController.text,
                                                  //     _ToSearchController.text,
                                                  //     isCheckedDirect!,
                                                  //     isCheckedIndirect!,
                                                  //     sorteBy,
                                                  //     _currentRangeValues.start
                                                  //         .round(),
                                                  //     _currentRangeValues.end
                                                  //         .round());
                                                },
                                              );
                                            },
                                          ),
                                          const Text('Cleaning services'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isCheckedPrivateParking,
                                    onChanged: (bool? newValue) {
                                      setModalState(
                                        () {
                                          isCheckedPrivateParking = newValue!;
                                          NumberOfHotelRooms();
                                          // isCheckedIndirect = false;
                                          // filterFlights(
                                          //     _FromSearchController.text,
                                          //     _ToSearchController.text,
                                          //     isCheckedDirect!,
                                          //     isCheckedIndirect!,
                                          //     sorteBy,
                                          //     _currentRangeValues.start
                                          //         .round(),
                                          //     _currentRangeValues.end
                                          //         .round());
                                        },
                                      );
                                    },
                                  ),
                                  const Text('Private praking'),
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
                                      activeColor: AppColors.purple,
                                      min: MinPrice,
                                      max: MaxPrice,
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
                                color: AppColors.purple,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   'Show ${'100'} of ${'316'} Rooms',
                                //   style: const TextStyle(
                                //       color: Colors.white,
                                //       fontWeight: FontWeight.w500),
                                // )
                                (NumberOfResultFilteredHotelRooms == 0)
                                    ? Text(
                                        'Show ${HotelRooms.value.length} of ${HotelRooms.value.length} Rooms',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : Text(
                                        'Show $NumberOfResultFilteredHotelRooms of ${HotelRooms.value.length} Rooms',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
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
        backgroundColor: AppColors.lightPurple,
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
                        color: AppColors.purple),
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
                      SizedBox(
                        height: 45,
                        width: size.width - 30,
                        child: TextField(
                          onChanged: (value) {
                            _SearchRoomController(value);
                          },
                          controller: _SearchController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: searchTextFielDecoratiom.copyWith(
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(
                                  color: AppColors.purple, width: 1.5),
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
                      Obx(() => isloading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: HotelRooms.value.length,
                                itemBuilder: (context, index) => RoomCardHotel(
                                  size: size,
                                  itemIndex: index,
                                  room: HotelRooms.value[index],
                                ),
                              ),
                            ))
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  void _SearchRoomController(String value) {
    print('p[p[]]');
    setState(() {
      HotelRooms.value = HotelRoom.entries
          .where((entry) {
            final overview = entry.value['Overview'].toLowerCase();
            final searchText = _SearchController.text.toLowerCase();
            print(entry.value);
            print(overview);
            print(searchText);
            final matchesSearch =
                searchText.isEmpty || overview.contains(searchText);
            print(matchesSearch);
            return matchesSearch;
          })
          .map((entry) => RoomDetailsClass.fromMap({
                "id": entry.key,
                'Adults': entry.value['Adults'],
                "Children": entry.value['Children'],
                "Overview": entry.value['Overview'],
                "Price": entry.value['Price'],
                "NumberOfBedrooms": entry.value['NumberOfBedrooms'],
                "NumberOfBeds": entry.value['NumberOfBeds'],
                "RoomPhoto": entry.value['RoomPhoto'],
                "isChecked24-hourFrontDesk":
                    entry.value['isChecked24-hourFrontDesk'],
                "isCheckedCleaningServices":
                    entry.value['isCheckedCleaningServices'],
                "isCheckedFoodAnddrink": entry.value['isCheckedFoodAnddrink'],
                "isCheckedFreeWifi": entry.value['isCheckedFreeWifi'],
                "isCheckedPrivatePool": entry.value['isCheckedPrivatePool'],
              }))
          .toList();
    });
  }
}
