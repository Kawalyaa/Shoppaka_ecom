import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesProvider with ChangeNotifier {
  FavoritesProvider() {
    initialState();
  }

  List<FavoritesModel> _favoriteList = [];
  List<FavoritesModel> get favoriteList => _favoriteList;

  void initialState() {
    syncDataWithProvider();
  }

  void addToFavorite(FavoritesModel favorite) {
    bool isPresent;

    if (_favoriteList.length > 0) {
      for (int i = 0; i < _favoriteList.length; i++) {
        if (_favoriteList[i].name == favorite.name) {
          isPresent = true;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        _favoriteList.add(favorite);
      }
    } else {
      _favoriteList.add(favorite);
    }

    //Remove duplicates
    final uniqItems = _favoriteList.map((e) => e.name).toSet();
    _favoriteList.retainWhere((item) => uniqItems.remove(item.name));

    updateSharedPreferences();

    notifyListeners();
  }

  void removeFavorite(String id) {
    _favoriteList.remove(id);
    updateSharedPreferences();
    notifyListeners();
  }

  void removeFavName(String name) {
    _favoriteList.removeWhere((element) => element.name == name);
    updateSharedPreferences();
    notifyListeners();
  }

  ///*******Add encoded objects from _cartProductsList  to prefs
  void updateSharedPreferences() async {
    List<String> prefCart =
        _favoriteList.map((item) => json.encode(item.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favKey', prefCart);
  }

  ///Get decoded data from prefs to _cartProductList
  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('favKey');

    if (result != null) {
      _favoriteList = result
          .map((item) => FavoritesModel.fromJson(json.decode(item)))
          .toList();
    }
    notifyListeners();
  }
}
