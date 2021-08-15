import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:ecommerce_app/componants/loading.dart';
import 'dart:math';

class OrdersServices {
  final String collection = "orderz";
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String ref = 'orders';

  String orderNumber() {
    //Generate a 6 digit random number
    var rNum = Random().nextDouble() * 100000;
    while (rNum < 100000) {
      rNum *= 10;
    }
    return rNum.round().toString();
  }

  Future<bool> createOrders({
    String userName,
    String email,
    String phone,
    List ordersList,
    List pickupStation,
    int totalPrice,
    String paymentMethod,
    String paymentStatus,
    List addressList,
    String deliveryMethod,
    BuildContext context,
  }) async {
    try {
      showProgress(context, 'Submitting order...', true);

      await _firestore.collection('allOrders').add({
        'id': _auth.currentUser.uid,
        'userName': userName,
        'phone': phone,
        'email': email,
        'ordersList': ordersList,
        'paymentStatus': paymentStatus ?? '',
        'totalPrice': totalPrice,
        'paymentMethod': paymentMethod,
        'pickupStation': pickupStation,
        'orderNumber': orderNumber(),
        'address': addressList,
        'orderStatus': 'sorting',
        'time': DateTime.now(),
        'deliveryDate': '',
        'deliveryMethod': deliveryMethod,
      });
      //Navigator.pushReplacementNamed(context, PaymentSuccessful.id);
      hideProgress();
      return true;
    } catch (e) {
      showAlertDialog(context, 'Message', e.toString());
      return false;
    }
  }

  void uploadOrders(
      {String userName,
      String email,
      String phone,
      List ordersList,
      String paymentStatus}) {
    var id = Uuid();
    String orderId = id.v1();
    _firestore.collection(ref).doc(orderId).set({
      'userName': userName,
      'phone': phone,
      'email': email,
      'ordersList': ordersList,
      'paymentStatus': paymentStatus ?? ''
    });
  }
}
