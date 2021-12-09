import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String collection = 'Products';
  String category = 'category';
  String featured = 'featured';
  String collection2 = 'users';
  String userId = 'id';

  Stream<List<Products2>> getAllFireStoreProduct() =>
      _firestore.collection(collection).snapshots().map((snaps) => snaps.docs
          .map((snap) => Products2.fromSnapShot(snap.data()))
          .toList());

  Stream<List<Products2>> getCategory(String categoryName) => _firestore
      .collection(collection)
      .where(category, isEqualTo: categoryName)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => Products2.fromSnapShot(snap.data()))
          .toList());

  Stream<List<Products2>> getFeatured() => _firestore
      .collection(collection)
      .where(featured, isEqualTo: true)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => Products2.fromSnapShot(snap.data()))
          .toList());

  Stream<List<UserModel>> getUserInfo() => _firestore
      .collection(collection2)
      .where(userId, isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => UserModel.fromSnapshot(snap.data()))
          .toList());
}
