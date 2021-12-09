import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

//Using UserModel class as a type
class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE = "phone";
  static const TOKEN = "token";
  static const PHOTO = 'photo';
  static const DELIVERY = 'delivery';

  String _name;
  String _email;
  String _id;
  String _photo;
  String _phone;
  String _delivery;
  String _token;

  //Getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get photo => _photo;
  String get phone => _phone;
  String get delivery => _delivery;
  String get token => _token;

  //Constructor expecting data from a snapshot
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _photo = snapshot.data()[PHOTO];
    _phone = snapshot.data()[PHONE];
    _delivery = snapshot.data()[DELIVERY];
    _token = snapshot.data()[TOKEN];
  }
}
