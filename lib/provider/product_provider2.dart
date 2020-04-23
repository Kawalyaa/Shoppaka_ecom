import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/product2.dart';

class ProductProvider2 with ChangeNotifier {
  List<Products2> _productList = [];

  List get productList => _productList;
}
