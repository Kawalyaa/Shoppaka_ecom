import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class OrdersServices {
  final String collection = "orderz";
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String ref = 'orders';

  Future<void> createOrders(
      {String userName,
      String email,
      String phone,
      List ordersList,
      List pickupStation,
      double totalPrice,
      String paymentMethod,
      String paymentStatus}) async {
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
