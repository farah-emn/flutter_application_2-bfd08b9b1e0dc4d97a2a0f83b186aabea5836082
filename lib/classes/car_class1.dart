// ignore_for_file: non_constant_identifier_names

class CarClass1 {
  String id;
  String company;
  String overview;
  String companyRentailName;
  String seats;
  String plate;
  String topSpeed;
  String ger;
  String color;
  num rentalInDay;
  num rentalInWeak;
  List<String>? image;
  String model;
  String is_reserved;
  // String companyRentlId;
  String pickupLocation;

  CarClass1(
      {required this.id,
      required this.color,
      required this.company,
      required this.ger,
      required this.overview,
      required this.plate,
      required this.rentalInDay,
      required this.rentalInWeak,
      required this.seats,
      required this.topSpeed,
      required this.image,
      required this.model,
      required this.is_reserved,
      required this.companyRentailName,
      required this.pickupLocation});
  factory CarClass1.fromMap(Map<dynamic, dynamic> map) {
    return CarClass1(
      id: map['id'] is String ? map['id'] : '',
      color: map['color'] is String ? map['color'] : '',
      company: map['company'] is String ? map['company'] : '',
      ger: map['ger'] is String ? map['ger'] : '',
      overview: map['overview'] is String ? map['overview'] : '',
      plate: map['plate'] is String ? map['plate'] : '',
      rentalInDay: map['rentalInDay'] is num ? map['rentalInDay'] : '',
      rentalInWeak: map['rentalInWeak'] is num ? map['rentalInWeak'] : '',
      seats: map['seats'] is String ? map['seats'] : '',
      topSpeed: map['topSpeed'] is String ? map['topSpeed'] : '',
      image: map.containsKey('image') && map['image'] != null
          ? (map['image'] as List<dynamic>)
              .where((item) => item != null)
              .map((item) => item as String)
              .toList()
          : null,
      model: map['model'] is String ? map['model'] : '',
      is_reserved: map['is_reserved'] is String ? map['is_reserved'] : '',
      companyRentailName:
          map['companyRentailName'] is String ? map['companyRentailName'] : '',
      pickupLocation:
          map['pickupLocation'] is String ? map['pickupLocation'] : '',
    );
  }
}

// List<CarClass> cars = [
//   CarClass(
//     color: 'Red',
//     company: 'Honday',
//     model: 'Elentra',
//     ger: 'Automatic',
//     overview: 'ddddddddddddddddddddddddddddd',
//     plate: '22441',
//     rentalInDay: '150',
//     rentalInWeak: '600',
//     seats: '4',
//     topSpeed: '280',
//     image: 'assets/image/png/car.jpg',
//   ),
//   CarClass(
//       image: 'assets/image/png/car.jpg',
//       model: 'Elentra',
//       color: 'Red',
//       company: 'Honday',
//       ger: 'Automatic',
//       overview: 'ddddddddddddddddddddddddddddd',
//       plate: '22441',
//       rentalInDay: '150',
//       rentalInWeak: '600',
//       seats: '4',
//       topSpeed: '280'),
//   CarClass(
//       image: 'assets/image/png/car.jpg',
//       model: 'Elentra',
//       color: 'Red',
//       company: 'Honday',
//       ger: 'Automatic',
//       overview: 'ddddddddddddddddddddddddddddd',
//       plate: '22441',
//       rentalInDay: '150',
//       rentalInWeak: '600',
//       seats: '4',
//       topSpeed: '280'),
//   CarClass(
//       image: 'assets/image/png/car.jpg',
//       model: 'Elentra',
//       color: 'Red',
//       company: 'Honday',
//       ger: 'Automatic',
//       overview: 'ddddddddddddddddddddddddddddd',
//       plate: '22441',
//       rentalInDay: '150',
//       rentalInWeak: '600',
//       seats: '4',
//       topSpeed: '280'),
//   CarClass(
//       image: 'assets/image/png/car.jpg',
//       model: 'Elentra',
//       color: 'Red',
//       company: 'Honday',
//       ger: 'Automatic',
//       overview: 'ddddddddddddddddddddddddddddd',
//       plate: '22441',
//       rentalInDay: '150',
//       rentalInWeak: '600',
//       seats: '4',
//       topSpeed: '280'),
// ];
