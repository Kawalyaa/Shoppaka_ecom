import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser;

  String collection = 'Products';
  String category = 'category';
  String featured = 'featured';
  String _collection2 = 'users';
  String _userId = 'id';

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
      .collection(_collection2)
      .where(_userId, isEqualTo: _user.uid)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => UserModel.fromSnapShot(snap.data()))
          .toList());
}
