import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'product_services.dart';
//*********This code is not used******************
class ProductCRUD {
  final Firestore _firestore = Firestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  static List<Product> allProdFromDb = [];
  String collection = 'Products';

  //====Fetch products from firestore=====
  getProducts() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(collection).getDocuments();
    querySnapshot.documents.forEach((f) {
      Services.products.add(Product.fromSnapshot(f.data));
    });
    return;
  }

  allProducts() async {
    await for (var snapShot in _firestore.collection(collection).snapshots()) {
      for (var item in snapShot.documents) {
        allProdFromDb.add(Product.fromSnapshot(item.data));
      }
    }
  }

  //=======Function to upload product image=======
  Future<String> uploadProductImage(_image, imageName) async {
    final StorageReference firebaseStorageRef = _storage.ref().child(imageName);
    final StorageUploadTask task = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<dynamic> fetchImage(String name) async =>
      await _storage.ref().child(name).getDownloadURL();

  //=====Upload products to the database====
  Future<void> addProduct(productData) async {
    _firestore.collection(collection).add(productData).catchError((e) {
      print(e);
    });
  }
}
