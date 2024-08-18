// ignore_for_file: non_constant_identifier_names

class ContactDetailsClass {
  final String firstname;
  final String lastname;
  final String Email;
  final String mobilenumber;
  final String bookingId;
  final String flightId;

  ContactDetailsClass(
      {required this.firstname,
      required this.lastname,
      required this.Email,
      required this.mobilenumber,
      required this.bookingId,
      required this.flightId});

  factory ContactDetailsClass.fromMap(Map<dynamic, dynamic> map) {
    return ContactDetailsClass(
      firstname: map['firstname'] is String ? map['firstname'] : '',
      Email: map['Email'] is String ? map['Email'] : '',
      mobilenumber: map['mobilenumber'] is String ? map['mobilenumber'] : '',
      bookingId: map['bookingId'] is String ? map['bookingId'] : '',
      lastname: map['lastname'] is String ? map['lastname'] : '',
      flightId: map['flightId'] is String ? map['flightId'] : '',
    );
  }
}
