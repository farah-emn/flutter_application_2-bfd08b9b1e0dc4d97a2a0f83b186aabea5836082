import 'dart:convert';

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'] is double
        ? json['price']
        : double.parse(json['price'].toString());
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }

  static Map<String, dynamic> toMap(ProductModel model) => {
        'id': model.id,
        'title': model.title,
      };

//!--- Convert list of object to list of json
  static String encode(List<ProductModel> list) => json.encode(
        list
            .map<Map<String, dynamic>>((model) => ProductModel.toMap(model))
            .toList(),
      );

//*--- Convert list of json to list of object

  static List<ProductModel> decode(String strList) =>
      (json.decode(strList) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] is double
        ? json['rate']
        : double.parse(json['rate'].toString());
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
