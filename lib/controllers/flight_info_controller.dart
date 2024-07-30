import 'package:get/get.dart';
import 'package:traveling/classes/flight_info_class.dart';

class FlightInfoController extends GetxController {
  var flightInfo = FlightInfoClass(
    DeparureDate: '',
    ArrivalDate: '',
    DeparureCity: '',
    ArrivalCity: '',
    airport_to: '',
    airport_from: '',
    Flight_Duration: '',
    name: '',
    DeparureTime: '',
    arrival_to: '',
    deparure_from: '',
    Flight_price: 0,
    ArrivalTime: '',
    Available_seat_passengers_Adult: 0,
    Available_seat_passengers_Children: 0,
  ).obs;

  void updateFlightInfo(FlightInfoClass newFlightInfo) {
    flightInfo.value = newFlightInfo;
  }

  void updateDepartureTime(String newDepartureTime) {
    flightInfo.update((val) {
      val?.DeparureTime = newDepartureTime;
    });
  }
}
