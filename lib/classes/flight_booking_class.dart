class FlightBookings {
  String userName;
  String audultNumber;
  String childrenNumber;
  String image;

  FlightBookings(
      {required this.audultNumber,
      required this.userName,
      required this.image,
      required this.childrenNumber});
}

List<FlightBookings> flightbookingsDetails = [
  FlightBookings(
    audultNumber: '2',
    childrenNumber: '3',
    image: 'assets/image/png/flynas.png',
    userName: 'Farah Al-Nefawi',
  ),
  FlightBookings(
    audultNumber: '2',
    childrenNumber: '5',
    userName: 'Tala Al-Nefawi',
    image: 'assets/image/png/flynas.png',

  ),
  FlightBookings(
    audultNumber: '4',
    childrenNumber: '2',
    userName: 'Aya Al-Nefawi',
    image: 'assets/image/png/flynas.png',

  ),
  FlightBookings(
    audultNumber: '2',
    childrenNumber: '2',
    userName: 'Haya Al-Nefawi',
    image: 'assets/image/png/flynas.png',

  ),
];
