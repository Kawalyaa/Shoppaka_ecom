import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/user_services.dart';

//Using UserModel class as a type
class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE = "phone";
  static const TOKEN = "token";
  static const PHOTO = 'photo';
  static const DELIVERY = 'delivery';

  final String name;
  final String email;
  final String id;
  final String photo;
  final String phone;
  final String delivery;
  final String token;
  UserModel(
      {this.id,
      this.name,
      this.email,
      this.photo,
      this.phone,
      this.delivery,
      this.token});
  //Getters
//  String get id => _id;
//  String get name => _name;
//  String get email => _email;
//  String get photo => _photo;
//  String get phone => _phone;
//  String get delivery => _delivery;
//  String get token => _token;

  //Constructor expecting data from a snapshot
  factory UserModel.fromSnapshot(Map snapshot) {
    return UserModel(
        id: snapshot[ID] ?? '',
        name: snapshot[NAME] ?? '',
        email: snapshot[EMAIL] ?? '',
        photo: snapshot[PHOTO] ?? '',
        phone: snapshot[PHONE] ?? '',
        delivery: snapshot[DELIVERY] ?? '',
        token: snapshot[TOKEN] ?? '');
  }
}
