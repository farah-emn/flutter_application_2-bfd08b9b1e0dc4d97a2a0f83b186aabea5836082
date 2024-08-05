class HotelSideUpcomingClass {
  String customerName;
  String checkinDate;
  String checkoutDate;
  String roomNumber;
  String totalPrice;
  String image;
  String email;

  HotelSideUpcomingClass({
    required this.checkinDate,
    required this.checkoutDate,
    required this.customerName,
    required this.roomNumber,
    required this.totalPrice,
    required this.image,
    required this.email,
  });
}

List<HotelSideUpcomingClass> HotelbookingsDetails2 = [
  HotelSideUpcomingClass(
    checkinDate: '22/2/2024',
    customerName: 'Customer name',
    checkoutDate: '25/2/2024',
    totalPrice: '320',
    roomNumber: '25',
    email: 'farah@gmail.com',
    image: 'assets/image/png/room3.png',
  ),
  HotelSideUpcomingClass(
    checkinDate: '22/2/2024',
    customerName: 'Customer name',
    checkoutDate: '25/2/2024',
    totalPrice: '550',
    roomNumber: '225',
    email: 'farah@gmail.com',
    image: 'assets/image/png/room3.png',
  ),
  HotelSideUpcomingClass(
    checkinDate: '22/2/2024',
    customerName: 'Customer name',
    checkoutDate: '25/2/2024',
    totalPrice: '250',
    roomNumber: '223',
    email: 'farah@gmail.com',
    image: 'assets/image/png/room3.png',
  ),
];
