// ignore_for_file: non_constant_identifier_names

class FlightInfoClass {
  final String DeparureDate;
  final String ArrivalDate;
  final String DeparureCity;
  final String ArrivalCity;
  final String airport_from;
  final String airport_to;
  final String arrival_to;
  final String deparure_from;
  final String Flight_Duration;
  final String name;
  late final String DeparureTime;
  final String ArrivalTime;
  final double Flight_price;
  final int Available_seat_passengers_Adult;
  final int Available_seat_passengers_Children;

  FlightInfoClass(
      {required this.DeparureDate,
      required this.ArrivalDate,
      required this.DeparureCity,
      required this.ArrivalCity,
      required this.airport_to,
      required this.airport_from,
      required this.Flight_Duration,
      required this.name,
      required this.DeparureTime,
      required this.arrival_to,
      required this.deparure_from,
      required this.Flight_price,
      required this.ArrivalTime,
      required this.Available_seat_passengers_Adult,
      required this.Available_seat_passengers_Children});
  factory FlightInfoClass.fromMap(Map<dynamic, dynamic> map) {
    return FlightInfoClass(
      DeparureDate: map['DeparureDate'] is String ? map['DeparureDate'] : '',
      ArrivalDate: map['ArrivalDate'] is String ? map['ArrivalDate'] : '',
      DeparureCity: map['DeparureCity'] is String ? map['DeparureCity'] : '',
      ArrivalCity: map['ArrivalCity'] is String ? map['ArrivalCity'] : '',
      airport_from: map['airport_from'] is String ? map['airport_from'] : '',
      airport_to: map['airport_to'] is String ? map['airport_to'] : '',
      arrival_to: map['arrival_to'] is String ? map['arrival_to'] : '',
      deparure_from: map['deparure_from'] is String ? map['deparure_from'] : '',
      Flight_Duration:
          map['Flight_Duration'] is String ? map['Flight_Duration'] : '',
      name: map['name'] is String ? map['name'] : '',
      DeparureTime: map['DeparureTime'] is String ? map['DeparureTime'] : '',
      ArrivalTime: map['ArrivalTime'] is String ? map['ArrivalTime'] : '',
      Flight_price: map['ticket_price'] is double ? map['ticket_price'] : 0,
      Available_seat_passengers_Adult:
          map['Available_seat_passengers_Adult'] is int
              ? map['Available_seat_passengers_Adult']
              : 0,
      Available_seat_passengers_Children:
          map['Available_seat_passengers_Children'] is int
              ? map['Available_seat_passengers_Children']
              : 0,
    );
  }
}
