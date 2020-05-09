import 'dart:collection';

import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';

class ProductProvider2 with ChangeNotifier {
  List<CartModel> _cartProductList = [];

  double _quantity = 1;
  double get quantity => _quantity;

  List get cartProductList => _cartProductList;

  void addProducts(CartModel cartItem) {
    bool isPresent = false;

    if (_cartProductList.length > 0) {
      for (int i = 0; i > _cartProductList.length; i++) {
        if (_cartProductList[i].id == cartItem.id) {
          increaseItemQuantity(cartItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        _cartProductList.add(cartItem);
      }
    } else {
      _cartProductList.add(cartItem);
    }

    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = 0;
    _cartProductList.forEach((item) {
      totalPrice += item.price * item.qty;
    });

    return totalPrice;
  }

  void increaseQty(int index) {
    _cartProductList[index].qty++;
    notifyListeners();
  }

  void decreaseQty(int index) {
    _cartProductList[index].qty--;
    notifyListeners();
  }

  removeProduct(CartModel cartItem) {
    _cartProductList.remove(cartItem);
    notifyListeners();
  }

  void increaseItemQuantity(CartModel cartItem) {
    cartItem.increaseQty();
  }
}
