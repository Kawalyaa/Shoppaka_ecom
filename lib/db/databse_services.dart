import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product2.dart';

class DatabaseServices {
  final Firestore _firestore = Firestore.instance;

  String collection = 'Products';

  Stream<List<Products2>> getAllFireStoreProduct() => _firestore
      .collection(collection)
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
