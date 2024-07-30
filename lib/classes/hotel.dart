class HotelClass {
  String name;
  String stars;
  String location;
  String image;
  HotelClass(
      {required this.name,
      required this.stars,
      required this.location,
      required this.image});
}

List<HotelClass> hotel = [
  HotelClass(
      name: "The Peninsula Ahanghai",
      stars: '5',
      location: "King Fahd Rd",
      image: "assets/image/png/hotel1.jpg"),
  HotelClass(
      name: "Royal Cliff Beach ",
      stars: '4',
      location: "King Salman Rd",
      image: "assets/image/png/hotel2.jpg"),
  HotelClass(
      name: "Crown Towers Perth Hotel",
      stars: '5',
      location: "King AbdAllah Rd",
      image: "assets/image/png/hotel3.jpg"),
  HotelClass(
      name: "Hayat Regeny Malta opens",
      stars: '3',
      location: "King AbdAllah Rd",
      image: "assets/image/png/hotel4.jpg"),
];
