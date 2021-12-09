import 'package:ecommerce_app/model/product2.dart';
import 'package:flutter/cupertino.dart';

class CategoryOptions {
  String imageLocation;
  String caption;
  bool isSelected;
  CategoryOptions({this.caption, this.imageLocation, this.isSelected});

  List<Products2> getCategory(
      List<Products2> productList, String categoryName) {
    List<Products2> categoryList = [];
    try {
      categoryList = productList
          .where((products2) => products2.category.contains(categoryName))
          .toList();
    } catch (e) {}

    return categoryList;
  }

  List<Products2> getFeaturedProd(
      List<Products2> productList, bool isFeatured) {
    List<Products2> featuredList = [];
    try {
      featuredList = productList
          .where((products2) => products2.featured == isFeatured)
          .toList();
    } catch (e) {}

    return featuredList;
  }
}
