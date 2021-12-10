import 'package:ecommerce_app/model/products_model.dart';
import 'package:flutter/material.dart';

class FavoriteList with ChangeNotifier {
  List<ProductsModel> _favoriteList = [];
  List<ProductsModel> get favoriteList => _favoriteList;

  void addToFavorite(ProductsModel products2) {
    bool isPresent;

    if (_favoriteList.length > 0) {
      for (int i = 0; i < _favoriteList.length; i++) {
        if (_favoriteList[i].name == products2.name) {
          //_favoriteList[i] = products2;
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
