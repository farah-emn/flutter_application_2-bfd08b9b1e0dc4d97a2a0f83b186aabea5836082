// ignore_for_file: non_constant_identifier_names

class RoomDetailsClass {
  final String Overview;
  final String id;
  final int Adults;
  final int Children;
  final String HotelId;
  final int NumberOfBedrooms;
  final int NumberOfBeds;
  final String NumberOfRooms;
  final String RoomNumber;
  final num Price;
  List<String>? RoomPhoto;
  List<String>? ChildrenAges;
  final bool isCheckedFreeWifi;
  final bool isCheckedPrivatePool;
  final bool isCheckedFoodAnddrink;
  final bool isCheckedCleaningServices;
  final bool isCheckedPrivateParking;
  final bool is_reserved;

  RoomDetailsClass(
      {required this.Overview,
      required this.ChildrenAges,
      required this.RoomNumber,
      required this.id,
      required this.NumberOfRooms,
      required this.Adults,
      required this.Children,
      required this.HotelId,
      required this.NumberOfBedrooms,
      required this.NumberOfBeds,
      required this.Price,
      this.RoomPhoto,
      required this.isCheckedPrivateParking,
      required this.isCheckedCleaningServices,
      required this.isCheckedFoodAnddrink,
      required this.isCheckedFreeWifi,
      required this.isCheckedPrivatePool,
      required this.is_reserved});

  factory RoomDetailsClass.fromMap(Map<dynamic, dynamic> map) {
    return RoomDetailsClass(
      id: map['id'] is String ? map['id'] : '',
      Adults: map['Adults'] is int ? map['Adults'] : 0,
      Children: map['Children'] is int ? map['Children'] : 0,
      HotelId: map['HotelId'] is String ? map['HotelId'] : '',
      NumberOfBedrooms:
          map['NumberOfBedrooms'] is int ? map['NumberOfBedrooms'] : 0,
      NumberOfBeds: map['NumberOfBeds'] is int ? map['NumberOfBeds'] : 0,
      Price: map['Price'] is num ? map['Price'] : 0,
      RoomPhoto: map.containsKey('RoomPhoto') && map['RoomPhoto'] != null
          ? (map['RoomPhoto'] as List<dynamic>)
              .where((item) => item != null)
              .map((item) => item as String)
              .toList()
          : null,
      Overview: map['Overview'] is String ? map['Overview'] : '',
      isCheckedPrivateParking: map['isCheckedPrivateParking'] is bool
          ? map['isCheckedPrivateParking']
          : false,
      isCheckedCleaningServices: map['isCheckedCleaningServices'] is bool
          ? map['isCheckedCleaningServices']
          : false,
      isCheckedFoodAnddrink: map['isCheckedFoodAnddrink'] is bool
          ? map['isCheckedFoodAnddrink']
          : false,
      isCheckedFreeWifi:
          map['isCheckedFreeWifi'] is bool ? map['isCheckedFreeWifi'] : false,
      isCheckedPrivatePool: map['isCheckedPrivatePool'] is bool
          ? map['isCheckedPrivatePool']
          : false,
      ChildrenAges: map.containsKey('ChildrenAge') && map['ChildrenAge'] != null
          ? (map['ChildrenAge'] as List<dynamic>)
              .where((item) => item != null)
              .map((item) => item as String)
              .toList()
          : null,
      RoomNumber: map['RoomNumber'] is String ? map['RoomNumber'] : '',
      NumberOfRooms: map['NumberOfRooms'] is String ? map['NumberOfRooms'] : '',
      is_reserved: map['is_reserved'] is bool ? map['is_reserved'] : false,
    );
  }
}
