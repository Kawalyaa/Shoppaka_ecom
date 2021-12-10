import 'dart:convert';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider2 with ChangeNotifier {
  ///******Call syncDataWithProvider() whenever ProductProvider2() is initialized
  ProductProvider2() {
    initialState();
  }

  List<CartModel> _cartProductList = [];

  List<CartModel> get cartProductList => _cartProductList;

  List<ProductsModel> search(String terms, List products) {
    return products
        .where((product) =>
            product.name.toLowerCase().contains(terms.toLowerCase()))
        .toList();
  }

  //add items if not present n if present just increase the qty
  addProducts(CartModel cartItem) {
    bool present;

    if (_cartProductList.isEmpty) {
      _cartProductList.add(cartItem);
    }

    for (int i = 0; i < _cartProductList.length; i++) {
      if (_cartProductList[i].name == cartItem.name) {
        present = true;
      } else {
        present = false;
      }
    }

    if (!present) {
      _cartProductList.add(cartItem);
    }

    //Remove duplicates
    final uniqueItems = _cartProductList.map((e) => e.name).toSet();
    _cartProductList.retainWhere((item) => uniqueItems.remove(item.name));

    updateSharedPreferences();

    notifyListeners();
  }

  void initialState() {
    syncDataWithProvider();
  }

  ///*******Add encoded objects from _cartProductsList  to prefs
  void updateSharedPreferences() async {
    List<String> prefCart =
        _cartProductList.map((item) => json.encode(item.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cartKey', prefCart);
  }

  ///Get decoded data from prefs to _cartProductList
  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('cartKey');

    if (result != null) {
      _cartProductList =
          result.map((item) => CartModel.fromJson(json.decode(item))).toList();
    }
    notifyListeners();
  }

  int getTotalPrice() {
    int totalPrice = 0;
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
    updateSharedPreferences();
    notifyListeners();
  }

  removeAllCartProducts() {
    _cartProductList.clear();
    updateSharedPreferences();
    notifyListeners();
  }
}
