class CarSideUpcomingClass {
  String customerName;
  String checkinDate;
  String checkoutDate;
  String totalPrice;
  String image;
  String email;

  CarSideUpcomingClass({
    required this.checkinDate,
    required this.checkoutDate,
    required this.customerName,
    required this.totalPrice,
    required this.image,
    required this.email,
  });
}

List<CarSideUpcomingClass> CarBookingsDetails = [
  CarSideUpcomingClass(
    checkinDate: '22/2/2024',
    customerName: 'Customer name',
    checkoutDate: '25/2/2024',
    totalPrice: '320',
    email: 'farah@gmail.com',
    image: 'assets/image/png/room3.png',
  ),
  CarSideUpcomingClass(
    checkinDate: '22/2/2024',
    customerName: 'Customer name',
    checkoutDate: '25/2/2024',
    totalPrice: '550',
    email: 'farah@gmail.com',
    image: 'assets/image/png/room3.png',
  ),
  CarSideUpcomingClass(
    checkinDate: '22/2/2024',
    customerName: 'Customer name',
    checkoutDate: '25/2/2024',
    totalPrice: '250',
    email: 'farah@gmail.com',
    image: 'assets/image/png/room3.png',
  ),
];
