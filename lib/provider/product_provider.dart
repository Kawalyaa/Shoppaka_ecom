import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/db/product.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  //List<Product2> _allProducts2 = [];

  // List<Product> _featuredProducts = [];
  List _featuredProducts = [];

  //ProductServices _productServices;
  final firestore = Firestore.instance;

  // getters
  //List get featuredProducts => _featuredProducts;
  List featuredProducts = [];


  void myFeatureProduct() async {
    var aFeatProds = await firestore.collection('Products').getDocuments();
    for (var singleProd in aFeatProds.documents) {
      featuredProducts.add(singleProd.data);
    }
    print(featuredProducts);
  }
}
