class HotelRoomClass {
  String name;
  String beds;
  String view;
  String image;
  String price;
  String rooms;

  HotelRoomClass(
      {required this.name,
      required this.beds,
      required this.view,
      required this.image,
      required this.price,
      required this.rooms,});
  // HotelDetailsM(this.name, String beds,String view, String image, int price);
}

List<HotelRoomClass> room = [
  HotelRoomClass(
      name: 'Deluxe Room - 2 Twin Beds',
      beds: '2 Twin Beds',
      view: 'Partial Sea View',
      image: 'assets/image/png/room3.png',
      price: '2200',
      rooms: '2'
      ),
  HotelRoomClass(
      name: 'Deluxe Room - 1 Twin Beds',
      beds: '1 Twin Beds',
      view: 'Partial Sea View',
      image: 'assets/image/png/room4.png',
      price: '3000',
      rooms: '1'
      ),
  HotelRoomClass(
      name: 'Deluxe Room - 1 Twin Beds',
      beds: '1 Twin Beds',
      view: 'Partial Sea View',
      image: 'assets/image/png/room1.png',
      price: '1200',
      rooms: '2'
      ),
  HotelRoomClass(
      name: 'Deluxe Room - 1 Twin Beds',
      beds: '1 Twin Beds',
      view: 'Partial Sea View',
      image: 'assets/image/png/room2.png',
      price: '2000',
      rooms: '2'
      ),
    
];
