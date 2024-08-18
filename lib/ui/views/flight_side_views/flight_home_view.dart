// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_brace_in_string_interps, await_only_futures, non_constant_identifier_names, unused_local_variable, empty_catches, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/flight_side_views/flight_welcome_view.dart';
import 'package:traveling/ui/views/flight_side_views/menu_view.dart';
import '../../shared/text_size.dart';
import '../first_view.dart';
import '../traveller_side_views/contact_us_view.dart';
import 'flight_currency.dart';
import 'flight_search_view.dart';

class FlightHomeView extends StatefulWidget {
  const FlightHomeView({super.key});

  @override
  State<FlightHomeView> createState() => _FlightHomeViewState();
}

class _FlightHomeViewState extends State<FlightHomeView> {
  late User loggedinUser;
  final CurrencyController FlightCurrency_Controller =
      Get.put(CurrencyController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<dynamic, dynamic> filteredFlightsData = {};
  Map<dynamic, dynamic> filteredDepartureAirportData = {};
  Map<dynamic, dynamic> filteredArrivalAirportData = {};
  List<FlightInfoClass> flightsList = [];
  final _auth = FirebaseAuth.instance;
  late final User? user;
  late DatabaseReference ref;
  String CompanyName = '';
  var Companylogo;
  var CompanyId = '';
  double incoming = 0.0;
  int completedFlight = 0;
  var isloading = false.obs;
  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Airline_company');
    user = _auth.currentUser;
    getCurrentUser();
    getData();

    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
      if (_auth.currentUser == null) {
        Get.offAll(const FlightWelcomeView());
      }
    } catch (e) {}
  }

  void getData() async {
    CompanyId = user?.uid.toString() ?? '';
    final event = await ref.child(CompanyId).get();
    final userData = Map<dynamic, dynamic>.from(event.value as Map);
    if (mounted)
      setState(() {
        CompanyName = userData['AirlineCompanyName'];
        Companylogo = userData['logo'];
      });
    fetchFlights().then((fetchedFlights) {
      if (mounted) {
        setState(() {
          filteredFlightsData = fetchedFlights;
          flightsList = fetchedFlights.entries.map((entry) {
            var stringKeyedMap = Map<dynamic, dynamic>.from(entry.value);
            return FlightInfoClass.fromMap(stringKeyedMap);
          }).toList();
        });
      }
    });
  }

  Future<Map> fetchFlights() async {
    FirebaseDatabase.instance
        .reference()
        .child('booking')
        .once()
        .then((DatabaseEvent event) {
      isloading.value = true;
      if (event.snapshot.exists) {
        var bookingData =
            Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        bookingData.forEach((bookingDatakey, value) {
          FirebaseDatabase.instance
              .reference()
              .child('Flight')
              .once()
              .then((DatabaseEvent event) {
            if (event.snapshot.exists) {
              var flightsData =
                  Map<dynamic, dynamic>.from(event.snapshot.value as Map);
              flightsData.forEach((flightsDatakey, value) {
                if (flightsData[flightsDatakey]['AirlinId'] == CompanyId) {
                  if (bookingData[bookingDatakey]['flightId'] ==
                      flightsDatakey) {
                    if (mounted) {
                      setState(() {
                        incoming +=
                            bookingData[bookingDatakey]['TotalTicketPrice'];
                      });
                    }
                  }
                  try {
                    final DateTime now = DateTime.now();
                    final String Deparure_Time =
                        '${flightsData[flightsDatakey]['DepartureTime']}';
                    final DateFormat formaatter = DateFormat('h:mm a');
                    final String Current_Time = formaatter.format(now);
                    final DateTime CurrentTime =
                        DateFormat.jm().parse(Current_Time);
                    final DateTime DeparureTime =
                        DateFormat.jm().parse(Deparure_Time);
                    final DateFormat formatter = DateFormat('d. M, y');
                    final String Currentdate = formatter.format(now);
                    final DateTime DeparureDate = formatter
                        .parse(flightsData[flightsDatakey]['DepartureDate']);
                    final DateTime CurrentDate = formatter.parse(Currentdate);
                    if (DeparureDate.isAfter(CurrentDate) ||
                        DeparureDate == CurrentDate) {
                      FirebaseDatabase.instance
                          .reference()
                          .child('Airport')
                          .once()
                          .then((DatabaseEvent event) {
                        if (event.snapshot.exists) {
                          var AirportData = Map<dynamic, dynamic>.from(
                              event.snapshot.value as Map);
                          AirportData.forEach((AirportDatakey, value) {
                            if (AirportDatakey ==
                                flightsData[flightsDatakey]
                                    ['DepartureAirportID']) {
                              if (mounted) {
                                setState(() {
                                  filteredDepartureAirportData = value;
                                });
                              }
                            }
                            if (AirportDatakey ==
                                flightsData[flightsDatakey]
                                    ['ArrivalAirportID']) {
                              if (mounted) {
                                setState(() {
                                  filteredArrivalAirportData = value;
                                });
                              }
                            }
                          });
                        }
                      });
                      setState(() {
                        filteredFlightsData[flightsDatakey] =
                            flightsData[flightsDatakey];
                      });
                    } else {
                      completedFlight = 0;
                      if (DeparureDate.isBefore(CurrentDate)) {
                        if (mounted) {
                          setState(() {
                            completedFlight += 1;
                          });
                        }
                      }
                    }
                  } catch (e) {}
                }
              });
            }
          });
        });
      }
    });
    if (filteredFlightsData.isEmpty) {
      isloading.value = false;
    }

    return filteredFlightsData;
  }

  String getTime(String input) {
    return input.split(' ')[0];
  }

  String getTimePmAm(String input) {
    var parts = input.split(' ');
    if (parts.length > 1)
      return parts[1];
    else
      return '';
  }

  @override
  Widget build(BuildContext context) {
    final CurrencyController currencyController = Get.put(CurrencyController());
    Size size = MediaQuery.of(context).size;
    String FlightDatakey = '';
    filteredFlightsData.forEach((key, value) {
      setState(() {
        FlightDatakey = key;
      });
    });
    String DepartureCity = '';
    String ArrivalCity = '';
    for (var key in filteredDepartureAirportData.keys) {
      setState(() {
        DepartureCity = key;
      });
    }
    for (var key in filteredArrivalAirportData.keys) {
      setState(() {
        ArrivalCity = key;
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColors.backgroundgrayColor,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.Blue),
                currentAccountPicture: (Companylogo != null)
                    ? CircleAvatar(backgroundImage: NetworkImage(Companylogo))
                    : CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/image/png/girlUser1.png')),
                accountName: Text('Company name'),
                accountEmail: Text('${CompanyName}')),
            // ListTile(
            //   leading: const Icon(
            //     Icons.date_range_rounded,
            //     color: AppColors.Blue,
            //   ),
            //   title: const Text(
            //     'Add airplane',
            //     style: TextStyle(
            //       color: AppColors.BlueText,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.people,
            //     color: AppColors.Blue,
            //   ),
            //   title: const Text(
            //     'Clients',
            //     style: TextStyle(
            //       color: AppColors.BlueText,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.headphones,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Contact us',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                Get.to(ContactUsView());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.currency_exchange_rounded,
                color: AppColors.Blue,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Currency',
                    style: TextStyle(
                      color: AppColors.BlueText,
                      fontSize: TextSize.header2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Text(
                      currencyController.selectedCurrency.value,
                      style: TextStyle(
                        color: AppColors.BlueText,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                Get.to(CurrencyPage());
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 0.2,
              color: AppColors.TextgrayColor,
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.headphones,
            //     color: AppColors.Blue,
            //   ),
            //   title: const Text(
            //     'Clients',
            //     style: TextStyle(
            //       color: AppColors.BlueText,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.help,
            //     color: AppColors.Blue,
            //   ),
            //   title: const Text(
            //     'Help',
            //     style: TextStyle(
            //       color: AppColors.BlueText,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            Spacer(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.Blue,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.BlueText,
                ),
              ),
              onTap: () {
                _auth.signOut();
                Get.offAll(() => const FirstView());
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.IconBlueColor,
            elevation: 0,
            pinned: true,
            expandedHeight: 335,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: AppColors.StatusBarColor,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                        ),
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.cloud,
                                  color: Color.fromARGB(76, 249, 249, 249),
                                  size: 60,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Let's Explore",
                                      style: TextStyle(
                                          color: AppColors.backgroundgrayColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.cloud,
                                      color: Color.fromARGB(76, 249, 249, 249),
                                      size: 50,
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "The World!",
                                      style: TextStyle(
                                          color: AppColors.backgroundgrayColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundgrayColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                // child: ,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Get.to(FlightsView());
                //       },
                //       child: Column(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(10),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 color: AppColors.LightBlueColor),
                //             child: const Icon(
                //               Icons.flight,
                //               color: AppColors.BlueText,
                //               size: 30,
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           const Text(
                //             'Flight',
                //             style: TextStyle(color: AppColors.BlueText),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Column(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(15),
                //               color: AppColors.LightBlueColor),
                //           child: const Icon(
                //             Icons.hotel,
                //             color: AppColors.BlueText,
                //             size: 30,
                //           ),
                //         ),
                //         SizedBox(
                //           height: screenWidth(30),
                //         ),
                //         const Text(
                //           'Hotel',
                //           style: TextStyle(color: AppColors.BlueText),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(15),
                //               color: AppColors.LightBlueColor),
                //           child: const Icon(
                //             Icons.local_taxi,
                //             color: AppColors.BlueText,
                //             size: 30,
                //           ),
                //         ),
                //         SizedBox(
                //           height: screenWidth(30),
                //         ),
                //         const Text(
                //           'Car',
                //           style: TextStyle(color: AppColors.BlueText),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width,
            toolbarHeight: 180,
            leading: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (Companylogo != null)
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(Companylogo),
                                ))
                          else
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/image/png/girlUser1.png'),
                                )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company Name',
                                style: TextStyle(
                                    color: AppColors.backgroundgrayColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                CompanyName,
                                style:
                                    TextStyle(color: AppColors.LightGrayColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: AppColors.backgroundgrayColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width / 2 - 20,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Incoming',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    Text(
                                      '\ ${currencyController.convert(currencyController.selectedCurrency.value, incoming)} ${currencyController.selectedCurrency.value}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2 - 20,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Completed flights',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${completedFlight}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Your next flight',
                        style: TextStyle(
                            color: AppColors.TextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => const FlightSearchView(),
                      );
                    },
                    child: Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (filteredFlightsData != null)
                                        ? Text(
                                            filteredFlightsData[FlightDatakey]
                                                    ?['DepartureDate'] ??
                                                '',
                                            style: TextStyle(
                                                color: AppColors.TextgrayColor,
                                                fontSize: 15),
                                          )
                                        : Text('')
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            (filteredFlightsData != null)
                                                ? Text(
                                                    getTime(
                                                      filteredFlightsData[
                                                                  FlightDatakey]
                                                              ?[
                                                              'DepartureTime'] ??
                                                          '',
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                : Text(''),
                                            Text(
                                              getTimePmAm(
                                                filteredFlightsData[
                                                            FlightDatakey]
                                                        ?['DepartureTime'] ??
                                                    '',
                                              ),
                                              style: TextStyle(
                                                color: AppColors.TextgrayColor,
                                                fontSize: 15,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ' ${DepartureCity}',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              getTime(
                                                filteredFlightsData[
                                                            FlightDatakey]
                                                        ?['ArrivalTime'] ??
                                                    '',
                                              ),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              getTimePmAm(
                                                filteredFlightsData[
                                                            FlightDatakey]
                                                        ?['ArrivalTime'] ??
                                                    '',
                                              ),
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ArrivalCity,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.TextgrayColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.Blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.airline_seat_recline_extra_rounded,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      filteredFlightsData[FlightDatakey]
                                                  ?['NumberOfEconomySeats']
                                              .toString() ??
                                          '',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Icon(
                                    //   Icons.attach_money_sharp,
                                    //   color: Colors.white,
                                    // ),
                                    if (filteredFlightsData[FlightDatakey]
                                            ?['TicketAdultEconomyPrice'] !=
                                        null)
                                      Text(
                                        '  ${FlightCurrency_Controller.convert(FlightCurrency_Controller.selectedCurrency.value, filteredFlightsData[FlightDatakey]?['TicketAdultEconomyPrice'].toDouble())} ${FlightCurrency_Controller.selectedCurrency.value}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )
                                    else
                                      Text(
                                        '',
                                        // '  ${FlightCurrency_Controller.convert('USD',
                                        // FlightCurrency_Controller.selectedCurrency.value,
                                        //filteredFlightsData[FlightDatakey]?['TicketAdultEconomyPrice'])} ${FlightCurrency_Controller.selectedCurrency.value}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
