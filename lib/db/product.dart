//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ecommerce_app/model/product.dart';
//
//class ProductServices {
//  Firestore _firestore = Firestore.instance;
//  String collection = 'Products';
//
//  Future<List<Product>> getFeaturedProducts() => _firestore
//          .collection(collection)
//          .where('featured', isEqualTo: true)
//          .getDocuments()
//          .then((snap) {
//        List<Product> featuredProducts = [];
//        snap.documents.map(
//            (snapShot) => featuredProducts.add(Product.fromSnapshot(snapShot)));
//        return featuredProducts;
//      });

//  Future <List<Product>> allFeaturedProd ()=>_firestore.collection(collection).where('featurd',isEqualTo: true).getDocuments().then((feSnaps){
//    List<Product> featuredProducts = [];
//
//    for(var feSnap in feSnaps.documents){
//      feSnap.data.map((snapShot)=>featuredProducts.add(Product.fromSnapshot(snapshot)));
//    }
//  })

//}
