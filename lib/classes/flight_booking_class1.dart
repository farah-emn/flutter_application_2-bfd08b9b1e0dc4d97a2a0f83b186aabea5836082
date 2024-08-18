class FlightBookingsClass1 {
  String companyName;
  String bookingDate;
  String DepartureDate;
  String ArrivalDate;
  String totalPrice;
  String NumberPassengerer;
  String bookingId;
  String FlightNumber;
  String CompanyLogo;
  String DepartureLocation;
  String ArrivalLocation;
  String DepartureCity;
  String ArrivalCity;
  String DepartureTime;
  String ArrivalTime;

  FlightBookingsClass1(
      {required this.companyName,
      required this.bookingDate,
      required this.DepartureDate,
      required this.ArrivalDate,
      required this.totalPrice,
      required this.NumberPassengerer,
      required this.bookingId,
      required this.FlightNumber,
      required this.CompanyLogo,
      required this.DepartureLocation,
      required this.ArrivalLocation,
      required this.DepartureCity,
      required this.ArrivalCity,
      required this.DepartureTime,
      required this.ArrivalTime});

  factory FlightBookingsClass1.fromMap(Map<dynamic, dynamic> map) {
    return FlightBookingsClass1(
      companyName: map['companyName'] is String ? map['companyName'] : '',
      bookingDate: map['bookingDate'] is String ? map['bookingDate'] : '',
      DepartureDate: map['DepartureDate'] is String ? map['DepartureDate'] : '',
      ArrivalDate: map['ArrivalDate'] is String ? map['ArrivalDate'] : '',
      totalPrice: map['totalPrice'] is String ? map['totalPrice'] : '',
      NumberPassengerer:
          map['NumberPassengerer'] is String ? map['NumberPassengerer'] : '',
      bookingId: map['bookingId'] is String ? map['bookingId'] : '',
      FlightNumber: map['FlightNumber'] is String ? map['FlightNumber'] : '',
      CompanyLogo: map['logo'] is String ? map['logo'] : '',
      DepartureLocation:
          map['DepartureLocation'] is String ? map['DepartureLocation'] : '',
      ArrivalLocation:
          map['ArrivalLocation'] is String ? map['ArrivalLocation'] : '',
      DepartureCity: map['DepartureCity'] is String ? map['DepartureCity'] : '',
      ArrivalCity: map['ArrivalCity'] is String ? map['ArrivalCity'] : '',
      ArrivalTime: map['ArrivalTime'] is String ? map['ArrivalTime'] : '',
      DepartureTime: map['DepartureTime'] is String ? map['DepartureTime'] : '',
    );
  }
}
