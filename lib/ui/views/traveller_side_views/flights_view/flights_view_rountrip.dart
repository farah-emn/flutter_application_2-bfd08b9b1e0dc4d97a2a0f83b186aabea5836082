// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_label, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_details._view.dart';

class FlightsViewRound extends StatelessWidget {
  Map<dynamic, dynamic> DepartureflightData;

  Map<dynamic, dynamic> ReturnflightData;
  FlightsViewRound(
      {required this.DepartureflightData, required this.ReturnflightData});

  @override
  Widget build(BuildContext context) {
    //
    List<FlightInfoClass> DepartureList =
        DepartureflightData.entries.map((entry) {
      var stringKeyedMap = Map<dynamic, dynamic>.from(entry.value);
      return FlightInfoClass.fromMap(stringKeyedMap);
    }).toList();
    var firstKey = DepartureflightData.keys.first;

    List<FlightInfoClass> Returnflights = ReturnflightData.entries.map((entry) {
      var stringKeyedMap = Map<dynamic, dynamic>.from(entry.value);
      return FlightInfoClass.fromMap(stringKeyedMap);
    }).toList();
    var ReturnKey = ReturnflightData.keys.first;

    return Scaffold(
        backgroundColor: AppColors.LightBlueColor,
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Image.asset('assets/image/png/plane_white.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 80,
                  ),
                  child: Image.asset('assets/image/png/universe_icon.png'),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenHeight(10), start: screenWidth(12)),
                child: Column(
                  children: [
                    Text(
                      DepartureflightData[firstKey]['deparure_from'] ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DepartureflightData[firstKey]['DeparureDate'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: screenHeight(10), start: screenWidth(1.3)),
                child: Column(
                  children: [
                    Text(
                      DepartureflightData[firstKey]['arrival_to'] ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ReturnflightData[ReturnKey]['DeparureDate'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.only(top: 180),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/png/background1.png'),
                        fit: BoxFit.fill),
                  ),
                )),
            SizedBox(
              height: 150,
            ),
            Padding(
                padding: EdgeInsets.only(top: 190, right: 15, left: 15),
                child: SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) => _buildListItem(
                        context, DepartureList[index], Returnflights[index]),
                    scrollDirection: Axis.vertical,
                    itemCount: DepartureList.length,
                  ),
                ))
          ],
        ));
  }

  Widget _buildListItem(BuildContext context,
      FlightInfoClass DepartureflightList, FlightInfoClass returnflightsList) {
    final CurrencyController controller = Get.put(CurrencyController());
    String _getFormattedCity(String City) {
      final List<String> parts = City.split(',');
      if (parts.length >= 2) {
        final String City = parts[0];

        return '$City';
      } else {
        return '';
      }
    }

    String _getFormattedDate(String date) {
      String day = '';
      final DateFormat inputFormat = DateFormat('d. M, yyyy');
      final DateFormat outputFormat = DateFormat('MMMM');
      final List<String> parts = date.split('.');
      if (parts.length >= 2) {
        day = parts[0];
      }
      DateTime dateTime;
      try {
        dateTime = inputFormat.parse(date);
      } catch (e) {
        return '';
      }

      String monthName = outputFormat.format(dateTime);

      return '${day}. ${monthName}';
    }

    _getFormattedDate(DepartureflightList.DeparureDate);
    return SizedBox(
      height: 250,
      child: Card(
        margin: EdgeInsetsDirectional.only(
          bottom: screenHeight(80),
          start: screenHeight(80),
        ),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 0.0,
        child: InkWell(
          onTap: () {
            GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
            // Get.to(FlightDetailsView(
            //     type: 'RoundTrip',
            //     flightdata: DepartureflightList,
            //     ReturnFlightData: returnflightsList));
            // Get.to(FlightDetailsView(
            //   flightdata: DepartureflightList,
            //   ReturnFlightData: returnflightsList,
            // ));
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/image/png/flynas.png',
                          width: 25,
                        ),
                        SizedBox(width: 6),
                        Text(
                          DepartureflightList.name,
                          style: TextStyle(
                              fontSize: screenWidth(24),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  DepartureflightList.DeparureTime,
                                  style: TextStyle(
                                      fontSize: screenWidth(22),
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text('AM',
                                    style: TextStyle(
                                        color: AppColors.TextgrayColor)),
                              ],
                            ),
                            Row(
                              children: [
                                Text(_getFormattedCity(
                                    DepartureflightList.DeparureCity)),
                                SizedBox(width: 2),
                                Text(
                                  _getFormattedDate(
                                      DepartureflightList.DeparureDate),
                                  style:
                                      TextStyle(color: AppColors.TextgrayColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        Image.asset(
                          'assets/image/png/Line_.png',
                        ),
                        Column(
                          children: [],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Image.asset(
                          'assets/image/png/blue plane.png',
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/image/png/arrow blue.png',
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  DepartureflightList.ArrivalTime,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text('PM',
                                    style: TextStyle(
                                        color: AppColors.TextgrayColor)),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  _getFormattedCity(
                                      DepartureflightList.ArrivalCity),
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  _getFormattedDate(
                                    DepartureflightList.ArrivalDate,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.TextgrayColor,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 100),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/image/png/clock_icon.png',
                                width: 10,
                              ),
                              Text(
                                DepartureflightList.Flight_Duration,
                                style: const TextStyle(
                                    color: AppColors.TextgrayColor),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 30),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/image/png/Direct_icon.png',
                                width: 12,
                              ),
                              const Text(
                                'Direct',
                                style:
                                    TextStyle(color: AppColors.TextgrayColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                  // )
                  // ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/png/flynas.png',
                        width: 25,
                      ),
                      SizedBox(width: 6),
                      Text(
                        returnflightsList.name,
                        style: TextStyle(
                            fontSize: screenWidth(24),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                returnflightsList.DeparureTime,
                                style: TextStyle(
                                    fontSize: screenWidth(22),
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text('AM',
                                  style: TextStyle(
                                      color: AppColors.TextgrayColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(_getFormattedCity(
                                  returnflightsList.DeparureCity)),
                              SizedBox(width: 2),
                              Text(
                                _getFormattedDate(
                                    returnflightsList.DeparureDate),
                                style:
                                    TextStyle(color: AppColors.TextgrayColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/image/png/Line_.png',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        'assets/image/png/blue plane.png',
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/image/png/arrow blue.png',
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                returnflightsList.ArrivalTime,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const Text('PM',
                                  style: TextStyle(
                                      color: AppColors.TextgrayColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                _getFormattedCity(
                                    returnflightsList.ArrivalCity),
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                _getFormattedDate(
                                  returnflightsList.ArrivalDate,
                                ),
                                style: TextStyle(
                                    color: AppColors.TextgrayColor,
                                    fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 100),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/png/clock_icon.png',
                              width: 10,
                            ),
                            Text(
                              returnflightsList.Flight_Duration,
                              style: const TextStyle(
                                  color: AppColors.TextgrayColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 30),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/image/png/Direct_icon.png',
                              width: 12,
                            ),
                            const Text(
                              'Direct',
                              style: TextStyle(color: AppColors.TextgrayColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '${returnflightsList.Flight_price + returnflightsList.Flight_price}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 181, 215),
                            fontSize: screenWidth(22),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.selectedCurrency.value,
                        style: TextStyle(
                            color: AppColors.TextgrayColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
                // )
                // ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
