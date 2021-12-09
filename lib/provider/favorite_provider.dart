import 'package:ecommerce_app/model/product2.dart';
import 'package:flutter/material.dart';

class FavoriteList with ChangeNotifier {
  List<Products2> _favoriteList = [];
  List<Products2> get favoriteList => _favoriteList;

  void addToFavorite(Products2 products2) {
    bool isPresent = false;

    if (_favoriteList.length > 0) {
      for (int i = 0; i < _favoriteList.length; i++) {
        if (_favoriteList[i].name == products2.name) {
          _favoriteList[i] = products2;
          isPresent = true;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        _favoriteList.add(products2);
      }
    } else {
      _favoriteList.add(products2);
    }
    notifyListeners();
  }

  void removeFavorite(String name) {
    for (int i = 0; i < _favoriteList.length; i++) {
      if (_favoriteList[i].name == name) {
        _favoriteList.removeAt(i);
      }
    }

    notifyListeners();
  }
}
