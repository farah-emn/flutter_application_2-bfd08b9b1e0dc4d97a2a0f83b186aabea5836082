class CarBookingsClass {
  String company;
  String checkinDate;
  String checkoutDate;
  String plateNumber;
  String totalPrice;
  String image;
  String model;

  CarBookingsClass({
    required this.checkinDate,
    required this.checkoutDate,
    required this.company,
    required this.plateNumber,
    required this.totalPrice,
    required this.image,
    required this.model,
  });
}

List<CarBookingsClass> carBookingsDetails = [
  CarBookingsClass(
    checkinDate: '22/2/2024',
    company: 'Honday',
    model: 'model',
    checkoutDate: '25/2/2024',
    totalPrice: '320',
    plateNumber: '25',
    image: 'assets/image/png/car.jpg',
  ),
  CarBookingsClass(
    checkinDate: '22/2/2024',
    company: 'Honday',
    checkoutDate: '25/2/2024',
    totalPrice: '550',
    plateNumber: '225',
    model: 'model',
    image: 'assets/image/png/car.jpg',
  ),
  CarBookingsClass(
    checkinDate: '22/2/2024',
    company: 'Honday',
    checkoutDate: '25/2/2024',
    model: 'model',
    totalPrice: '250',
    plateNumber: '223',
    image: 'assets/image/png/car.jpg',
  ),
];
