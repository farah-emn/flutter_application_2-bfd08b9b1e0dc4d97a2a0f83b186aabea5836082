class HotelBookingsClass {
  String hotelName;
  String checkinDate;
  String checkoutDate;
  String roomNumber;
  String totalPrice;
  String image;
  String location;

  HotelBookingsClass({
    required this.checkinDate,
    required this.checkoutDate,
    required this.hotelName,
    required this.roomNumber,
    required this.totalPrice,
    required this.image,
    required this.location,
  });
}

List<HotelBookingsClass> HotelbookingsDetails = [
  HotelBookingsClass(
    checkinDate: '22/2/2024',
    hotelName: 'Hotel name',
    checkoutDate: '25/2/2024',
    totalPrice: '320',
    roomNumber: '25',
    location: 'KSA - Dammam',
    image: 'assets/image/png/room3.png',
  ),
  HotelBookingsClass(
    checkinDate: '22/2/2024',
    hotelName: 'Hotel name',
    checkoutDate: '25/2/2024',
    totalPrice: '550',
    roomNumber: '225',
    location: 'KSA - Dammam',
    image: 'assets/image/png/room3.png',
  ),
  HotelBookingsClass(
    checkinDate: '22/2/2024',
    hotelName: 'Hotel name',
    checkoutDate: '25/2/2024',
    totalPrice: '250',
    roomNumber: '223',
    location: 'KSA - Dammam',
    image: 'assets/image/png/room3.png',
  ),
];
