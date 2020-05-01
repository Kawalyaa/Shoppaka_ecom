import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product2.dart';

class DatabaseServices {
  final Firestore _firestore = Firestore.instance;

  String collection = 'Products';
  String category = 'category';
  String featured = 'featured';

  Stream<List<Products2>> getAllFireStoreProduct() => _firestore
      .collection(collection)
      .snapshots()
      .map((snaps) => snaps.documents
          .map((snap) => Products2.fromSnapShot(snap.data))
          .toList());

  Stream<List<Products2>> getCategory(String categoryName) => _firestore
      .collection(collection)
      .where(category, isEqualTo: categoryName)
      .snapshots()
      .map((snaps) => snaps.documents
          .map((snap) => Products2.fromSnapShot(snap.data))
          .toList());

  Stream<List<Products2>> getFeatured() => _firestore
      .collection(collection)
      .where(featured, isEqualTo: true)
      .snapshots()
      .map((snaps) => snaps.documents
      .map((snap) => Products2.fromSnapShot(snap.data))
      .toList());
}

//Stream<Products2> getAllFireStoreProduct() {
//  List<Products2> streamList = [];
//  _firestore.collection(collection).snapshots().forEach((snaps){
//    snaps.documents.forEach((snap)=>streamList.add(Products2.fromSnapShot(snap.data)));
//  });
//
//}
