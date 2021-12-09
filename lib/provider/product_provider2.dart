import 'package:ecommerce_app/componants/auth.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:flutter/material.dart';

class ProductProvider2 with ChangeNotifier {
  List<CartModel> _cartProductList = [];

  List<CartModel> get cartProductList => _cartProductList;

  //add items if not present n if present just increase the qty
  addProducts(CartModel cartItem) {
    bool isPresent = false;
    if (_cartProductList.length > 0) {
      for (int i = 0; i < _cartProductList.length; i++) {
        if (_cartProductList[i].name == cartItem.name) {
          _cartProductList[i].qty++;
          isPresent = true;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        //if item not present or at the block where isPresent is false
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

  CartModel getProductDetails() {
    var item;
    for (item in _cartProductList) {}
    return item;
  }

  void increaseQty(int index) {
    _cartProductList[index].qty++;
    notifyListeners();
  }

  void decreaseQty(int index) {
    _cartProductList[index].qty--;
    if (_cartProductList[index].qty < 1) {
      _cartProductList[index].qty = 1;
    }
    notifyListeners();
  }

  removeProduct(int itemIndex) {
    _cartProductList.removeAt(itemIndex);
    notifyListeners();
  }
}
