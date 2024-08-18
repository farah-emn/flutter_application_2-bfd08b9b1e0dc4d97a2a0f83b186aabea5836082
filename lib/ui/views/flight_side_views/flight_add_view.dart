// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, use_build_context_synchronously, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, deprecated_member_use, avoid_unnecessary_containers, avoid_print, prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/controllers/flight_add_controller.dart';
import 'package:traveling/ui/views/flight_side_views/FlightDepartureDateDetails.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';

class FlightAddView extends StatefulWidget {
  const FlightAddView({super.key});
  @override
  State<FlightAddView> createState() => _FlightAddViewState();
}

class _FlightAddViewState extends State<FlightAddView> {
  final FlightAddController controller = Get.put(FlightAddController());

  User? AirelineCompany;
  final _auth = FirebaseAuth.instance;
  var AirelineCompanyId = '';
  var AirelineCompanyName = '';
  var uid;
  var currentUser;
  final TextEditingController DeparturedateController = TextEditingController();
  final TextEditingController ArivaldateController = TextEditingController();
  final _Planeid = TextEditingController();
  final _Model = TextEditingController();
  final _Manufacturer = TextEditingController();
  final _AirportFrom = TextEditingController();
  final _AirportTo = TextEditingController();
  final _AirportFromId = TextEditingController();
  final _AirportToId = TextEditingController();
  final _CountryDeparture = TextEditingController();
  final _CountryArrival = TextEditingController();
  final _CityDeparture = TextEditingController();
  final _CityArrival = TextEditingController();
  final _NumberOfEconomySeats = TextEditingController();
  final _NumberOfFirstClassSeats = TextEditingController();
  final _TicketPriceEconomySeat = TextEditingController();
  final _TicketFirstClassPriceSeat = TextEditingController();
  final _TicketChildPriceEconomy = TextEditingController();
  final _TicketChildFirstClassPrice = TextEditingController();

  int IdFlight = 0;
  int IdAirport = 0;
  int IdPlane = 0;
  int IdStop_location = 0;
  void _handleDateSelection(String dateText) {
    DeparturedateController.text = dateText;
  }

  @override
  void initState() {
    final databaseReference = FirebaseDatabase.instance.reference();
    // controller.clearData();
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    setState(() {
      AirelineCompany = _auth.currentUser;
      AirelineCompanyId = AirelineCompany?.uid.toString() ?? '';
    });
    DatabaseReference idRefFlight = databaseReference.child('Flight');
    DatabaseReference idRefAirport = databaseReference.child('Airport');
    DatabaseReference idRefPlane = databaseReference.child('Plane');
    DatabaseReference idRefStop_location =
        databaseReference.child('Stop_location');

    idRefFlight.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      print(event.snapshot.children.length);
      if (mounted) {
        setState(() {
          IdFlight = event.snapshot.children.length + 1;
        });
      }
    });
    idRefAirport.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      print(event.snapshot.children.length);
      if (mounted) {
        setState(() {
          IdAirport = event.snapshot.children.length + 1;
        });
      }
    });
    idRefPlane.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      print(event.snapshot.children.length);
      if (mounted) {
        setState(() {
          IdPlane = event.snapshot.children.length + 1;
        });
      }
    });
    idRefStop_location.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      if (mounted) {
        setState(() {
          IdStop_location = event.snapshot.children.length + 1;
        });
      }
    });
    // _departureTime = '';
    // _arrivalTime = '';
    super.initState();
  }

  bool? isChecked = true;
  bool? freeWifi = true;
  bool? handbag = true;
  bool? shipping = true;
  // bool? kg = true;
  // bool? 30kg = true;

  int StopLocation = 1;
  TimeOfDay? _departureTime;
  TimeOfDay? _arrivalTime;
  String? selectedValue;
  Future<void> _selectDepartureTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _departureTime ?? now,
    );

    if (picked != null && picked != _departureTime) {
      // Check if the selected time is in the past
      if (DateTime.now().compareTo(controller.departureDate.value) == 1 &&
          (picked.hour < now.hour ||
              (picked.hour == now.hour && picked.minute < now.minute))) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Departure time cannot be in the past.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _departureTime = picked;
        });
      }
    }
  }

  Future<void> _selectArrivalTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _arrivalTime ?? now,
    );

    if (picked != null && picked != _arrivalTime) {
      // Convert departure date and time to DateTime
      final DateTime departureDateTime = DateTime(
        controller.departureDate.value.year,
        controller.departureDate.value.month,
        controller.departureDate.value.day,
        _departureTime?.hour ?? 0,
        _departureTime?.minute ?? 0,
      );

      // Convert picked time to DateTime
      final DateTime pickedDateTime = DateTime(
        controller.ReturnDate.value.year,
        controller.ReturnDate.value.month,
        controller.ReturnDate.value.day,
        picked.hour,
        picked.minute,
      );

      // Check if the selected time is before the departure time
      if (pickedDateTime.isBefore(departureDateTime)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Arrival time cannot be before departure time.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _arrivalTime = picked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controllersStopLocation = List.generate(
      StopLocation,
      (_) => TextEditingController(),
    );
    List<TextEditingController> _controllersStopDuration = List.generate(
      StopLocation,
      (_) => TextEditingController(),
    );
    String AirportFrom = '';
    String AirportTo = '';
    int NumberOfEconomySeats;
    int NumberOfFirstClassSeats;
    double TicketPriceEconomySeat;
    double TicketFirstClassPriceSeat;
    double TicketChildPriceEconomy;
    double TicketChildFirstClassPrice;
    Size size = MediaQuery.of(context).size;

    void _confirm() async {
      if ((_AirportFrom.text.isNotEmpty &&
              !_controllersStopLocation
                  .any((controller) => controller.text.isEmpty) &&
              !_controllersStopDuration
                  .any((controller) => controller.text.isEmpty)) ||
          (isChecked == true) &&
              _AirportFromId.text.isNotEmpty &&
              _AirportTo.text.isNotEmpty &&
              _AirportToId.text.isNotEmpty &&
              _CityArrival.text.isNotEmpty &&
              _CityDeparture.text.isNotEmpty &&
              _CountryArrival.text.isNotEmpty &&
              _CountryDeparture.text.isNotEmpty &&
              _Manufacturer.text.isNotEmpty &&
              _Model.text.isNotEmpty &&
              _NumberOfEconomySeats.text.isNotEmpty &&
              _NumberOfFirstClassSeats.text.isNotEmpty &&
              _Planeid.text.isNotEmpty &&
              _TicketChildFirstClassPrice.text.isNotEmpty &&
              _TicketChildPriceEconomy.text.isNotEmpty &&
              _TicketFirstClassPriceSeat.text.isNotEmpty &&
              _TicketPriceEconomySeat.text.isNotEmpty &&
              _arrivalTime != null &&
              _departureTime != null &&
              controller.departureDate.value != null &&
              controller.ReturnDate.value != null) {
        // Convert TimeOfDay to DateTime
        DateTime departureDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            _departureTime!.hour,
            _departureTime!.minute);
        DateTime arrivalDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            _arrivalTime!.hour,
            _arrivalTime!.minute);
        Duration difference = arrivalDateTime.difference(departureDateTime);
        String differenceInHours =
            '${difference.inHours.toString().padLeft(2, '0')}h ${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}m';

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Flight added',
                style: TextStyle(fontSize: 16),
              ),
              content: Text('Are you sure to add the flight?'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    try {
                      double TicketChildFirstClassPrice = double.parse(
                          _TicketChildFirstClassPrice.text
                              .replaceAll('\u{00A0}', ''));
                      double TicketChildPriceEconomy = double.parse(
                          _TicketChildPriceEconomy.text
                              .replaceAll('\u{00A0}', ''));
                      double TicketFirstClassPriceSeat = double.parse(
                          _TicketFirstClassPriceSeat.text
                              .replaceAll('\u{00A0}', ''));
                      double TicketPriceEconomySeat = double.parse(
                          _TicketPriceEconomySeat.text
                              .replaceAll('\u{00A0}', ''));

                      final databaseReference =
                          FirebaseDatabase.instance.reference();

                      databaseReference.child('Flight/$IdFlight:').set({
                        "DepartureAirportID": '${IdAirport.toString()}:',
                        "ArrivalAirportID": '${IdAirport + 1}:',
                        "AirlinId": AirelineCompanyId,
                        "PlaneId": '${IdPlane}:',
                        "FlightDuration": differenceInHours,
                        "DepartureDate":
                            '${controller.departureDate.value.day}. ${controller.departureDate.value.month}, ${controller.departureDate.value.year}',
                        "ArrivalDate":
                            '${controller.ReturnDate.value.day}. ${controller.ReturnDate.value.month}, ${controller.ReturnDate.value.year}',
                        "DepartureTime": _departureTime?.format(context),
                        "ArrivalTime": _arrivalTime?.format(context),
                        "NumberOfEconomySeats": _NumberOfEconomySeats.text,
                        "NumberOfFirstClassSeats":
                            int.parse(_NumberOfFirstClassSeats.text),
                        "TicketChildFirstClassPrice":
                            TicketChildFirstClassPrice,
                        "TicketChildEconomyPrice": TicketChildPriceEconomy,
                        "TicketAdultEconomyPrice": TicketPriceEconomySeat,
                        "TicketAdultFirstClassPrice":
                            TicketChildFirstClassPrice,
                      });
                      // idRef.set(id);
                      FirebaseDatabase.instance
                          .reference()
                          .child('Airport')
                          .child('${(IdAirport.toString())}:')
                          .child(_AirportFromId.text)
                          .set({
                        "AirportName": _AirportFrom.text,
                        "Location":
                            '${_CityDeparture.text}, ${_CountryDeparture.text}'
                      });
                      FirebaseDatabase.instance
                          .reference()
                          .child('Airport')
                          .child('${(IdAirport + 1).toString()}:')
                          .child(_AirportToId.text)
                          .set({
                        "AirportName": _AirportTo.text,
                        "Location":
                            '${_CityArrival.text}, ${_CountryArrival.text}',
                      });
                      // DatabaseReference idRefPlane =
                      //     databaseReference.child('Plane');
                      // FirebaseDatabase.instance
                      //     .reference()
                      //     .child('Plane/$IdPlane')
                      //     .set({
                      //   _Planeid.text: {
                      //     "Model": _Model.text,
                      //     "Manufacturer": _Manufacturer.text,
                      //   }
                      // });
                      DatabaseReference idRefPlane =
                          databaseReference.child('Plane');
                      FirebaseDatabase.instance
                          .reference()
                          .child('Plane')
                          .child('${(IdPlane.toString())}:')
                          .child(_Planeid.text)
                          .set({
                        "Model": _Model.text,
                        "Manufacturer": _Manufacturer.text,
                      });

                      for (var i = 0;
                          i < _controllersStopLocation.length;
                          i++) {
                        FirebaseDatabase.instance
                            .reference()
                            .child('Stop_location')
                            .child('${(IdStop_location)}:')
                            .set({
                          "FlighID": '${IdFlight}:',
                          "StopDuration": _controllersStopDuration[i].text,
                          "StopLocation": _controllersStopLocation[i].text
                        });
                        IdStop_location += 1;
                        print(_controllersStopLocation.length);
                      }
                    } catch (e) {
                      print('Could not parse text field value to a number: $e');
                    }

                    Navigator.of(context).pop();
                    _AirportFrom.clear();
                    _AirportFromId.clear();
                    _AirportTo.clear();
                    _AirportToId.clear();
                    _CityArrival.clear();
                    _CityDeparture.clear();
                    _CountryArrival.clear();
                    _CountryDeparture.clear();
                    _Manufacturer.clear();
                    _NumberOfEconomySeats.clear();
                    _NumberOfFirstClassSeats.clear();
                    _Planeid.clear();
                    _Model.clear();
                    _TicketChildFirstClassPrice.clear();
                    _TicketChildPriceEconomy.clear();
                    _TicketFirstClassPriceSeat.clear();
                    _TicketPriceEconomySeat.clear();
                    setState(() {
                      _departureTime = null;
                      _arrivalTime = null;
                      controller.newDepartureDate = null;
                      controller.newReturnDate = null;
                    });
                    controller.clearData();
                  },
                ),
              ],
            );
          },
        );
        // } else {
        //   FirebaseDatabase.instance
        //       .reference()
        //       .child('Airports')
        //       .child(_AirportFromId.text)
        //       .push()
        //       .set({
        //     "Airport": "ll",
        //     "Country":,
        //     "City": ,
        //   });
      } else {
        print(controller.departureDate.value);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(),
                  Spacer(),
                  Text(
                    'Add Flight',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
                  ),
                  Spacer(),
                  // InkWell(
                  //     onTap: () => _confirm(),
                  //     child: Icon(
                  //       Icons.save_as,
                  //       color: AppColors.backgroundgrayColor,
                  //     )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Plane Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Plane id',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _Planeid,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Plane Model',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _Model,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {},
                              ),
                            ),
                            // const SizedBox(
                            //   height: 40,
                            // ),
                            // const Row(
                            //   children: [
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Text(
                            //       'Plane Manufacturer',
                            //       style: TextStyle(
                            //           fontSize: 13,
                            //           color: AppColors.grayText,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 45,
                            //   width: size.width - 50,
                            //   child: TextField(
                            //     controller: _Manufacturer,
                            //     keyboardType: TextInputType.text,
                            //     decoration: textFielDecoratiom.copyWith(
                            //         fillColor: Colors.white,
                            //         prefixIcon: const Icon(
                            //             Icons.flight_takeoff_outlined)),
                            //     onChanged: (value) {},
                            //   ),
                            // ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Flight details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Departure Airport id',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _AirportFromId,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {
                                  AirportFrom = value;
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Departure Airport',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _AirportFrom,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                        Icons.flight_takeoff_outlined)),
                                onChanged: (value) {
                                  AirportFrom = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            // const SizedBox(
                            //   height: 40,
                            // ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Arrival Airport id',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _AirportToId,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(Icons.flight_land)),
                                onChanged: (value) {
                                  AirportTo = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Arrival Airport',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width - 50,
                              child: TextField(
                                controller: _AirportTo,
                                keyboardType: TextInputType.text,
                                decoration: textFielDecoratiom.copyWith(
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(Icons.flight_land)),
                                onChanged: (value) {
                                  AirportFrom = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Depature City',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _CityDeparture,
                                        keyboardType: TextInputType.text,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.public)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Departure country',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _CountryDeparture,
                                        keyboardType: TextInputType.text,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.public)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Arrival City',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _CityArrival,
                                        keyboardType: TextInputType.text,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.public)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Arrival country',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _CountryArrival,
                                        keyboardType: TextInputType.text,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.public)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Arrival Date',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Depature Date',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.grayText,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      children: [
                                        DepartureDateArrivalDateDetails(
                                            onDateSelected:
                                                _handleDateSelection,
                                            Departure_date:
                                                controller.departureDate,
                                            Return_date: controller.ReturnDate,
                                            datecontroller:
                                                DeparturedateController,
                                            returnDateController:
                                                ArivaldateController),
                                      ],
                                    ),

                                    //  ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'Depature Time',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors.grayText,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 45,
                                        width: size.width / 2 - 15,
                                        child: TextField(
                                          readOnly: true,
                                          onTap: () {
                                            _selectDepartureTime(context);
                                          },
                                          controller: TextEditingController(
                                              text: _departureTime
                                                  ?.format(context)),
                                          keyboardType: TextInputType.datetime,
                                          decoration:
                                              textFielDecoratiom.copyWith(
                                                  fillColor: Colors.white,
                                                  prefixIcon: const Icon(
                                                      Icons.access_time)),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Arrival Time',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () {
                                          _selectArrivalTime(context);
                                        },
                                        controller: TextEditingController(
                                            text:
                                                _arrivalTime?.format(context)),
                                        keyboardType: TextInputType.datetime,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                                Icons.access_time_outlined)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            // (isChecked == true)
                            //     ? Row(
                            //         children: [
                            //           Checkbox(
                            //             value: isChecked,
                            //             onChanged: (bool? newValue) {
                            //               setState(
                            //                 () {
                            //                   isChecked = newValue;
                            //                 },
                            //               );
                            //             },
                            //           ),
                            //           const Text('Direct Flight'),
                            //         ],
                            //       )
                            //     : Column(
                            //         children: [
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //             children: [
                            //               SizedBox(
                            //                 width: 10,
                            //               ),
                            //               Text(
                            //                 'Stop location ',
                            //                 style: TextStyle(
                            //                     fontSize: 13,
                            //                     color: AppColors.grayText,
                            //                     fontWeight: FontWeight.w500),
                            //               ),
                            //               SizedBox(
                            //                 width: 240,
                            //               ),
                            //               InkWell(
                            //                   onTap: () {
                            //                     setState(() {
                            //                       StopLocation += 1;
                            //                     });

                            //                     // Add your action here
                            //                   },
                            //                   child: Icon(
                            //                     Icons
                            //                         .add_circle_outline_outlined,
                            //                     color: AppColors
                            //                         .mainColorBlue, // Replace with your custom color
                            //                   )),
                            //             ],
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           Container(
                            //             width: 400,
                            //             // height: 150,
                            //             decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(20)),
                            //             child: ListView.builder(
                            //                 shrinkWrap: true,
                            //                 physics:
                            //                     NeverScrollableScrollPhysics(),
                            //                 padding: EdgeInsets.zero,
                            //                 itemCount: StopLocation,
                            //                 itemBuilder: (context, index) {
                            //                   return Container(
                            //                     padding:
                            //                         EdgeInsetsDirectional.only(
                            //                             bottom: 15),
                            //                     child: Column(children: [
                            //                       SizedBox(
                            //                         height: 10,
                            //                       ),
                            //                       Row(
                            //                         children: [
                            //                           SizedBox(
                            //                             width: 12,
                            //                           ),
                            //                           Text(
                            //                             'Stop location ${index + 1}',
                            //                             style: TextStyle(
                            //                                 fontSize: 13,
                            //                                 color: AppColors
                            //                                     .grayText,
                            //                                 fontWeight:
                            //                                     FontWeight
                            //                                         .w500),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                       SizedBox(
                            //                         height: 40,
                            //                         width: size.width - 50,
                            //                         child: TextField(
                            //                           controller:
                            //                               _controllersStopLocation[
                            //                                   index], // Use a different controller for each TextField
                            //                           keyboardType:
                            //                               TextInputType.text,
                            //                           decoration: textFielDecoratiom
                            //                               .copyWith(
                            //                                   fillColor:
                            //                                       Colors.white,
                            //                                   prefixIcon:
                            //                                       const Icon(Icons
                            //                                           .flight_takeoff_outlined)),
                            //                         ),
                            //                       ),
                            //                       SizedBox(
                            //                         height: 20,
                            //                       ),
                            //                       Row(
                            //                         children: [
                            //                           SizedBox(
                            //                             width: 12,
                            //                           ),
                            //                           Text(
                            //                             'Stop duration (03h 10m)',
                            //                             style: TextStyle(
                            //                                 fontSize: 13,
                            //                                 color: AppColors
                            //                                     .grayText,
                            //                                 fontWeight:
                            //                                     FontWeight
                            //                                         .w500),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                       SizedBox(
                            //                         height: 40,
                            //                         width: size.width - 50,
                            //                         child: TextField(
                            //                           controller:
                            //                               _controllersStopDuration[
                            //                                   index],
                            //                           keyboardType:
                            //                               TextInputType.text,
                            //                           decoration: textFielDecoratiom
                            //                               .copyWith(
                            //                                   fillColor:
                            //                                       Colors.white,
                            //                                   prefixIcon:
                            //                                       const Icon(Icons
                            //                                           .access_time)),
                            //                         ),
                            //                       ),
                            //                     ]),
                            //                   );
                            //                 }),
                            //           ),
                            //         ],
                            //       )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Tickets and Seats',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Number of economy seats',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _NumberOfEconomySeats,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airline_seat_recline_normal)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Ticket Price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _TicketPriceEconomySeat,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airplane_ticket_outlined)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Number of first class seats',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _NumberOfFirstClassSeats,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airline_seat_recline_extra_rounded)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Ticket Price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _TicketFirstClassPriceSeat,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(Icons
                                                .airplane_ticket_outlined)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Child economy ticket price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _TicketChildPriceEconomy,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.child_care)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Child first class ticket price',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.grayText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width / 2 - 15,
                                      child: TextField(
                                        controller: _TicketChildFirstClassPrice,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.child_care)),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: _confirm,
                              child: CustomButton(
                                backgroundColor: AppColors.mainColorBlue,
                                text: 'Add',
                                textColor: Colors.white,
                                widthPercent: size.width,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // const SizedBox(
                            //   height: 15,
                            // ),
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
