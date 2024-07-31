class TravellarBookingClass {
  String name;
  String classType;
  String seatNumber;

  TravellarBookingClass(
      {required this.classType, required this.name, required this.seatNumber});
}

List<TravellarBookingClass> travellarsBookings = [
  TravellarBookingClass(classType: 'Economy', name: 'Farah', seatNumber: '9D'),
  TravellarBookingClass(classType: 'Economy', name: 'Farah', seatNumber: '9D'),
  TravellarBookingClass(classType: 'Economy', name: 'Farah', seatNumber: '9D'),
  TravellarBookingClass(classType: 'Economy', name: 'Farah', seatNumber: '9D'),
];
