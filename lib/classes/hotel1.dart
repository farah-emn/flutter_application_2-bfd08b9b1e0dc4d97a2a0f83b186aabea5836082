class HotelClass1 {
  final String Name;
  final String location;
  final String Image;
  final String? stars;
  final num StartPrice;
  final String Id;
  final String email;
  final String address;
  final String mobilenumber;

  HotelClass1(
      {required this.Name,
      required this.location,
      required this.Image,
      this.stars,
      required this.StartPrice,
      required this.Id,
      required this.email,
      required this.address,
      required this.mobilenumber});

  factory HotelClass1.fromMap(Map<dynamic, dynamic> map) {
    return HotelClass1(
      Name: map['HotelName'] is String ? map['HotelName'] : '',
      location: map['location'] is String ? map['location'] : '',
      Image: map['image'] is String ? map['image'] : '',
      StartPrice: map['StartPrice'] is num ? map['StartPrice'] : 0,
      Id: map['Id'] is String ? map['Id'] : '',
      email: map['email'] is String ? map['email'] : '',
      address: map['address'] is String ? map['address'] : '',
      mobilenumber: map['mobilenumber'] is String ? map['mobilenumber'] : '',
    );
  }
}
