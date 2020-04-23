import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  //product model to fetch data from firebase/firestore;
  static const ID = 'id';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const BRAND = 'brand';
  static const IMAGES = 'images';
  static const CATEGORY = 'category';
  static const OLD_PRICE = 'oldPrice';
  static const COLORS = 'colors';
  static const SIZES = 'sizes';
  static const QUANTITY = 'quantity';
  static const FAVORITE = 'favorite';
  static const FEATURED = 'featured';

  String id;
  String name;
  String brand;
  String category;
  String image;
  double price;
  double oldPrice;
  int quantity;
  List colors;
  List sizes;
  bool favorite;
  bool featured;

  Product({
    this.id = '',
    this.name = '',
    this.brand = '',
    this.category = '',
    this.image = '',
    this.price = 0,
    this.oldPrice = 0,
    this.quantity = 0,
    this.colors,
    this.sizes,
    this.favorite = false,
    this.featured,
  });

  //named constructor
  Product.fromSnapshot(Map<String, dynamic> data) {
    this.id = data[ID];
    this.name = data[NAME];
    this.brand = data[BRAND];
    this.category = data[CATEGORY];
    this.image = data[IMAGES];
    this.price = data[PRICE];
    this.oldPrice = data[OLD_PRICE];
    this.quantity = data[QUANTITY];
    this.colors = data[COLORS];
    this.sizes = data[SIZES];
    this.favorite = data[FAVORITE];
    this.featured = data[FEATURED];
  }
}

//class Product {
//  //product model to fetch data from firebase/firestore;
//  static const ID = 'id';
//  static const NAME = 'name';
//  static const PRICE = 'price';
//  static const BRAND = 'brand';
//  static const PICTURE = 'picture';
//  static const CATEGORY = 'category';
//  static const OLD_PRICE = 'oldPrice';
//  static const COLORS = 'colors';
//  static const SIZES = 'sizes';
//  static const QUANTITY = 'quantity';
//  static const FAVORITE = 'favorite';
//  static const FEATURED = 'featured';
//
//  String _id;
//  String _name;
//  String _brand;
//  String _category;
//  String _picture;
//  int _price;
//  int _oldPrice;
//  int _quantity;
//  List _colors;
//  List _sizes;
//  bool _favorite;
//  bool _featured;
//
//  //Getters
//  String get id => _id;
//  String get name => _name;
//  String get brand => _brand;
//  String get category => _category;
//  String get picture => _picture;
//  int get price => _price;
//  int get oldPrice => _oldPrice;
//  int get quantity => _quantity;
//  List get colors => _colors;
//  List get sizes => _sizes;
//  bool get favorite => _favorite;
//  bool get featured => _featured;
//
//  //named constructor
//  Product.fromSnapshot(DocumentSnapshot snapshot) {
//    Map data = snapshot.data;
//    _id = data[ID];
//    _name = data[NAME];
//    _brand = data[BRAND];
//    _category = data[CATEGORY];
//    _picture = data[PICTURE];
//    _price = data[PRICE];
//    _oldPrice = data[OLD_PRICE];
//    _quantity = data[QUANTITY];
//    _colors = data[COLORS];
//    _sizes = data[SIZES];
//    _favorite = data[FAVORITE];
//    _featured = data[FEATURED];
//  }
//}
//
