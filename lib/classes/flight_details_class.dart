// ignore_for_file: non_constant_identifier_names

class FlightDetailsClass {
  final String FlightID;
  final String DeparureDate;
  final String ArrivalDate;
  final String DeparureTime;
  final String ArrivalTime;
  final String Flight_Duration;
  final String DeparureCity;
  final String DepartureAirport;
  final String deparure_from;
  final String ArrivalAirport;
  final String deparure_to;
  final int NumberOfEconomySeats;
  final int NumberOfFirstClassSeats;
  final double TicketAdultEconomyPrice;
  final double TicketAdultFirstClassPrice;
  double? TicketChildEconomyPrice;
  double? TicketChildFirstClassPrice;
  String? PlaneId;
  String? PlaneModel;
  String? PlaneManufacturer;
  String? FlightType;
  String DepartureCity;
  String ArrivalCity;
  String FlightCompanyName;
  String FlightCompanyLogo;

  FlightDetailsClass(
      {required this.FlightID,
      required this.DeparureDate,
      required this.ArrivalDate,
      required this.DeparureCity,
      required this.DepartureAirport,
      required this.Flight_Duration,
      required this.DeparureTime,
      required this.ArrivalTime,
      required this.ArrivalAirport,
      required this.deparure_from,
      required this.deparure_to,
      required this.NumberOfEconomySeats,
      required this.NumberOfFirstClassSeats,
      required this.TicketAdultEconomyPrice,
      required this.TicketAdultFirstClassPrice,
      this.TicketChildEconomyPrice,
      this.TicketChildFirstClassPrice,
      this.PlaneId,
      this.PlaneManufacturer,
      this.PlaneModel,
      this.FlightType,
      required this.DepartureCity,
      required this.ArrivalCity,
      required this.FlightCompanyName,
      required this.FlightCompanyLogo});

  factory FlightDetailsClass.fromMap(Map<dynamic, dynamic> map) {
    return FlightDetailsClass(
      DeparureDate: map['DeparureDate'] is String ? map['DeparureDate'] : '',
      ArrivalDate: map['ArrivalDate'] is String ? map['ArrivalDate'] : '',
      Flight_Duration:
          map['Flight_Duration'] is String ? map['Flight_Duration'] : '',
      DeparureTime: map['DeparureTime'] is String ? map['DeparureTime'] : '',
      ArrivalTime: map['ArrivalTime'] is String ? map['ArrivalTime'] : '',
      DepartureAirport:
          map['DepartureAirport'] is String ? map['DepartureAirport'] : '',
      ArrivalAirport:
          map['ArrivalAirport'] is String ? map['ArrivalAirport'] : '',
      deparure_from: map['deparure_from'] is String ? map['deparure_from'] : '',
      deparure_to: map['deparure_to'] is String ? map['deparure_to'] : '',
      DeparureCity: '',
      NumberOfEconomySeats:
          map['NumberOfEconomySeats'] is int ? map['NumberOfEconomySeats'] : 0,
      NumberOfFirstClassSeats: map['NumberOfFirstClassSeats'] is int
          ? map['NumberOfFirstClassSeats']
          : 0,
      TicketAdultEconomyPrice: map['TicketAdultEconomyPrice'] is double
          ? map['TicketAdultEconomyPrice']
          : 0,
      TicketAdultFirstClassPrice: map['TicketAdultFirstClassPrice'] is double
          ? map['TicketAdultFirstClassPrice']
          : 0,
      TicketChildEconomyPrice: map['TicketChildEconomyPrice'] is double
          ? map['TicketChildEconomyPrice']
          : 0,
      TicketChildFirstClassPrice: map['TicketChildFirstClassPrice'] is double
          ? map['TicketChildFirstClassPrice']
          : 0,
      PlaneId: map['PlaneId'] is String ? map['PlaneId'] : '',
      PlaneManufacturer:
          map['PlaneManufacturer'] is String ? map['PlaneManufacturer'] : '',
      PlaneModel: map['PlaneModel'] is String ? map['PlaneModel'] : '',
      FlightType: map['FlightType'] is String ? map['FlightType'] : '',
      FlightID: map['FlightID'] is String ? map['FlightID'] : '',
      DepartureCity: map['DepartureCity'] is String ? map['DepartureCity'] : '',
      ArrivalCity: map['ArrivalCity'] is String ? map['ArrivalCity'] : '',
      FlightCompanyName:
          map['FlightCompanyName'] is String ? map['FlightCompanyName'] : '',
      FlightCompanyLogo:
          map['FlightCompanyLogo'] is String ? map['FlightCompanyLogo'] : '',
    );
  }
}
