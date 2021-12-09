import 'dart:collection';

import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';

class ProductProvider2 with ChangeNotifier {
  List<CartModel> _cartProductList = [];

  List get cartProductList => _cartProductList;

  void addProducts(CartModel cartItem) {
    _cartProductList.add(cartItem);

    notifyListeners();
  }

  removeProduct(CartModel cartItem) {
    _cartProductList.remove(cartItem);
    notifyListeners();
  }
}
