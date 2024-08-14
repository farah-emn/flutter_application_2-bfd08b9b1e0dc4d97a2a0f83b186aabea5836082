class HotelBookingsClass1 {
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

  HotelBookingsClass1(
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
      this.RatingRoom});

  factory HotelBookingsClass1.fromMap(Map<dynamic, dynamic> map) {
    return HotelBookingsClass1(
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
      RatingRoom: map['RatingRoom'] is double ? map['RatingRoom'] : 0.0,
    );
  }
}
