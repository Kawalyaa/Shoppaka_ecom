import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/pages/payment_successfull.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:ecommerce_app/componants/loading.dart';

class OrdersServices {
  final String collection = "orderz";
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String ref = 'orders';

  Future<void> createOrders({
    String userName,
    String email,
    String phone,
    List ordersList,
    List pickupStation,
    double totalPrice,
    String paymentMethod,
    String paymentStatus,
    BuildContext context,
  }) async {
    try {
      showProgress(context, 'Submitting order...', true);
      await _firestore.collection('allOrders').add({
        'userName': userName,
        'phone': phone,
        'email': email,
        'ordersList': ordersList,
        'paymentStatus': paymentStatus ?? '',
        'totalPrice': totalPrice,
        'paymentMethod': paymentMethod,
        'pickupStation': pickupStation
      });
      Navigator.pushReplacementNamed(context, PaymentSuccessful.id);
      hideProgress();
    } catch (e) {
      showAlertDialog(context, 'Message', e.toString());
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
