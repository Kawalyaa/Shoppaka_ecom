import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser;

  String collection = 'Products2';
  String category = 'category';
  String featured = 'featured';
  String _collection2 = 'users';
  String _userId = 'id';

  List<UserModel> resultsList;

  Stream<List<ProductsModel>> getAllFireStoreProduct() =>
      _firestore.collection(collection).snapshots().map((snaps) => snaps.docs
          .map((snap) => ProductsModel.fromSnapShot(snap.data()))
          .toList());

  Stream<List<ProductsModel>> getCategory(String categoryName) => _firestore
      .collection(collection)
      .where(category, isEqualTo: categoryName)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => ProductsModel.fromSnapShot(snap.data()))
          .toList());

  Stream<List<ProductsModel>> getFeatured() => _firestore
      .collection(collection)
      .where(featured, isEqualTo: true)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => ProductsModel.fromSnapShot(snap.data()))
          .toList());

  Stream<List<UserModel>> getUserInfo() => _firestore
      .collection(_collection2)
      .where(_userId, isEqualTo: _user.uid)
      .snapshots()
      .map((snaps) => snaps.docs
          .map((snap) => UserModel.fromSnapShot(snap.data()))
          .toList());
}
