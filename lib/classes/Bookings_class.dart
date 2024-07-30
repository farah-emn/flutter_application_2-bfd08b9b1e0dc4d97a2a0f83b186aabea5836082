class BookingsClass {
  String userName;
  String audultNumber;
  String childrenNumber;

  BookingsClass(
      {required this.audultNumber,
      required this.userName,
      required this.childrenNumber});
}

List<BookingsClass> bookingsDetails = [
  BookingsClass(
    audultNumber: '2',
    childrenNumber: '3',
    userName: 'Farah Al-Nefawi',
  ),
  BookingsClass(
    audultNumber:'2' ,
    childrenNumber: '5',
    userName: 'Tala Al-Nefawi',
  ),
  BookingsClass(
    audultNumber: '4',
    childrenNumber: '2',
    userName: 'Aya Al-Nefawi',
  ),
  BookingsClass(
    audultNumber: '2',
    childrenNumber: '2',
    userName: 'Haya Al-Nefawi',
  ),
];
