// class HotelSideUpcomingClass {
//   String customerName;
//   String checkinDate;
//   String checkoutDate;
//   String roomNumber;
//   String totalPrice;
//   String image;
//   String email;

//   HotelSideUpcomingClass({
//     required this.checkinDate,
//     required this.checkoutDate,
//     required this.customerName,
//     required this.roomNumber,
//     required this.totalPrice,
//     required this.image,
//     required this.email,
//   });
// }

// List<HotelSideUpcomingClass> HotelbookingsDetails2 = [
//   HotelSideUpcomingClass(
//     checkinDate: '22/2/2024',
//     customerName: 'Customer name',
//     checkoutDate: '25/2/2024',
//     totalPrice: '320',
//     roomNumber: '25',
//     email: 'farah@gmail.com',
//     image: 'assets/image/png/room3.png',
//   ),
//   HotelSideUpcomingClass(
//     checkinDate: '22/2/2024',
//     customerName: 'Customer name',
//     checkoutDate: '25/2/2024',
//     totalPrice: '550',
//     roomNumber: '225',
//     email: 'farah@gmail.com',
//     image: 'assets/image/png/room3.png',
//   ),
//   HotelSideUpcomingClass(
//     checkinDate: '22/2/2024',
//     customerName: 'Customer name',
//     checkoutDate: '25/2/2024',
//     totalPrice: '250',
//     roomNumber: '223',
//     email: 'farah@gmail.com',
//     image: 'assets/image/png/room3.png',
//   ),
// ];
class carSideBookingsClass1 {
  String companyRentalName;
  String model;
  String company;
  String pickupDate;
  String dropoffDate;
  String plateNumber;
  num totalPrice;
  String rentalInDay;
  String image;
  String location;
  String bookingDate;
  String carId;
  double? RatingCar;
  String? customerName;
  String? email;
  carSideBookingsClass1(
      {required this.companyRentalName,
      required this.company,
      required this.model,
      required this.pickupDate,
      required this.dropoffDate,
      required this.plateNumber,
      required this.totalPrice,
      required this.image,
      required this.location,
      required this.bookingDate,
      required this.rentalInDay,
      required this.carId,
      this.RatingCar,
      this.customerName,
      this.email});
  factory carSideBookingsClass1.fromMap(Map<dynamic, dynamic> map) {
    return carSideBookingsClass1(
      companyRentalName:
          map['companyRentalName'] is String ? map['companyRentalName'] : '',
      company: map['company'] is String ? map['company'] : '',
      model: map['model'] is String ? map['model'] : '',
      pickupDate: map['pickupDate'] is String ? map['pickupDate'] : '',
      dropoffDate: map['dropoffDate'] is String ? map['dropoffDate'] : '',
      image: map['image'] is String ? map['image'] : '',
      plateNumber: map['plateNumber'] is String ? map['plateNumber'] : '',
      totalPrice: map['totalPrice'] is num ? map['totalPrice'] : 0,
      location: map['location'] is String ? map['location'] : '',
      bookingDate: map['bookingDate'] is String ? map['bookingDate'] : '',
      carId: map['carId'] is String ? map['carId'] : '',
      RatingCar: map['RatingCar'] is double ? map['RatingCar'] : 0.0,
      customerName: map['customerName'] is String ? map['customerName'] : '',
      email: map['email'] is String ? map['email'] : '',
      rentalInDay: map['rentalInDay'] is String ? map['rentalInDay'] : '',
    );
  }
}
