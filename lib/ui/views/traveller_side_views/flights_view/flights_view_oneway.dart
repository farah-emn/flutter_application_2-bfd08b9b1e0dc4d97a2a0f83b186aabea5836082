// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_label, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveling/classes/flight_info_class.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/search_roundtrip_controller.dart';
// import 'package:traveling/controllers/traveller_details_view1_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/utils.dart';
import 'package:traveling/ui/views/traveller_side_views/flight_details._view.dart';

class FlightsView extends StatelessWidget {
  Map<dynamic, dynamic> flightData;

  FlightsView({required this.flightData});
  // final TravellerDetailsView1_Controller =
  //     Get.put(TravellerDetailsView1Controller());
  final SearchViewRoundTrip_Controller =
      Get.put(SearchViewRoundTripController());
  @override
  Widget build(BuildContext context) {
    List<FlightInfoClass> flightsList = flightData.entries.map((entry) {
      var stringKeyedMap = Map<dynamic, dynamic>.from(entry.value);
      return FlightInfoClass.fromMap(stringKeyedMap);
    }).toList();
    var firstKey = flightData.keys.first;

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
                      flightData[firstKey]['deparure_from'] ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      flightData[firstKey]['DeparureTime'] ?? '',
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
                      flightData[firstKey]['arrival_to'] ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      flightData[firstKey]['ArrivalTime'] ?? '',
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
                    itemBuilder: (context, index) =>
                        _buildListItem(context, flightsList[index]),
                    scrollDirection: Axis.vertical,
                    itemCount: flightsList.length,
                  ),
                ))
          ],
        ));
  }

  Widget _buildListItem(BuildContext context, FlightInfoClass flight) {
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

    _getFormattedDate(flight.DeparureDate);

    return SizedBox(
      height: 170,
      child: Card(
        margin: EdgeInsetsDirectional.only(
            bottom: screenHeight(80),
            start: screenHeight(80),
            end: screenHeight(80)),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 0.0,
        child: InkWell(
          onTap: () {
            GlobalKey<FormState> globalFormKey1 = GlobalKey<FormState>();

            // Get.to(FlightDetailsView(type: 'oneway', flightdata: flight));
          },
          child: Padding(
            padding: EdgeInsetsDirectional.all(screenHeight(80)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/image/png/flynas.png'),
                    SizedBox(width: screenWidth(60)),
                    Text(
                      flight.name,
                      style: TextStyle(
                          fontSize: screenWidth(24),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  children: [
                    Text(
                      flight.DeparureTime,
                      style: TextStyle(
                          fontSize: screenWidth(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Text('AM',
                        style: TextStyle(color: AppColors.TextgrayColor)),
                    const Spacer(),
                    Image.asset('assets/image/png/Line_.png'),
                    Image.asset('assets/image/png/blue plane.png'),
                    Image.asset('assets/image/png/arrow blue.png'),
                    const Spacer(),
                    Text(
                      flight.ArrivalTime,
                      style: TextStyle(
                          fontSize: screenWidth(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Text('PM',
                        style: TextStyle(color: AppColors.TextgrayColor)),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 1, end: 22),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(_getFormattedCity(flight.DeparureCity)),
                          SizedBox(width: 2),
                          Text(
                            _getFormattedDate(flight.DeparureDate),
                            style: TextStyle(color: AppColors.TextgrayColor),
                          ),
                          // SizedBox(width: 110),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(_getFormattedCity(flight.ArrivalCity)),
                          Text(
                            _getFormattedDate(flight.ArrivalDate),
                            style: TextStyle(color: AppColors.TextgrayColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/image/png/Direct_icon.png'),
                        SizedBox(
                          width: screenWidth(90),
                        ),
                        const Text(
                          'Direct',
                          style: TextStyle(color: AppColors.TextgrayColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset('assets/image/png/clock_icon.png'),
                        SizedBox(
                          width: screenWidth(80),
                        ),
                        Text(
                          flight.Flight_Duration,
                          style:
                              const TextStyle(color: AppColors.TextgrayColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          flight.Flight_price.toString(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
