// class HotelSideFinishedClass {
//   String customerName;
//   String checkinDate;
//   String checkoutDate;
//   String roomNumber;
//   String totalPrice;
//   String image;
//   String email;

//   HotelSideFinishedClass({
//     required this.checkinDate,
//     required this.checkoutDate,
//     required this.customerName,
//     required this.roomNumber,
//     required this.totalPrice,
//     required this.image,
//     required this.email,
//   });
// }

// List<HotelSideFinishedClass> HotelFinishedDetails2 = [
//   HotelSideFinishedClass(
//     checkinDate: '22/2/2024',
//     customerName: 'Customer name',
//     checkoutDate: '25/2/2024',
//     totalPrice: '320',
//     roomNumber: '25',
//     email: 'farah@gmail.com',
//     image: 'assets/image/png/room3.png',
//   ),
//   HotelSideFinishedClass(
//     checkinDate: '22/2/2024',
//     customerName: 'Customer name',
//     checkoutDate: '25/2/2024',
//     totalPrice: '550',
//     roomNumber: '225',
//     email: 'farah@gmail.com',
//     image: 'assets/image/png/room3.png',
//   ),
//   HotelSideFinishedClass(
//     checkinDate: '22/2/2024',
//     customerName: 'Customer name',
//     checkoutDate: '25/2/2024',
//     totalPrice: '250',
//     roomNumber: '223',
//     email: 'farah@gmail.com',
//     image: 'assets/image/png/room3.png',
//   ),
// ];
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
class HotelSideFinishedClass {
  String hotelName;
  String checkinDate;
  String checkoutDate;
  String roomNumber;
  num totalPrice;
  num priceNight;
  String image;
  String location;
  String bookingDate;
  String RoomId;
  double? RatingRoom;
  String? customerName;
  String? email;
  HotelSideFinishedClass(
      {required this.checkinDate,
      required this.checkoutDate,
      required this.hotelName,
      required this.roomNumber,
      required this.totalPrice,
      required this.image,
      required this.location,
      required this.bookingDate,
      required this.priceNight,
      required this.RoomId,
      this.RatingRoom,
      this.customerName,
      this.email});

  factory HotelSideFinishedClass.fromMap(Map<dynamic, dynamic> map) {
    return HotelSideFinishedClass(
      checkinDate: map['checkinDate'] is String ? map['checkinDate'] : '',
      checkoutDate: map['checkoutDate'] is String ? map['checkoutDate'] : '',
      image: map['image'] is String ? map['image'] : '',
      hotelName: map['hotelName'] is String ? map['hotelName'] : '',
      roomNumber: map['roomNumber'] is String ? map['roomNumber'] : '',
      totalPrice: map['totalPrice'] is num ? map['totalPrice'] : 0,
      location: map['location'] is String ? map['location'] : '',
      bookingDate: map['bookingDate'] is String ? map['bookingDate'] : '',
      priceNight: map['priceNight'] is num ? map['priceNight'] : 0,
      RoomId: map['RoomId'] is String ? map['RoomId'] : '',
      RatingRoom: map['RatingRoom'] is double ? map['RatingRoom'] : 1.0,
      customerName: map['customerName'] is String ? map['customerName'] : '',
      email: map['email'] is String ? map['email'] : '',
    );
  }
}
