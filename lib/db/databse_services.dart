import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product2.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String collection = 'Products';
  String category = 'category';
  String featured = 'featured';

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
}
