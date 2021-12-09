import 'package:ecommerce_app/model/products_model.dart';
import 'package:flutter/cupertino.dart';

class CategoryOptions {
  String imageLocation;
  String caption;
  bool isSelected;
  CategoryOptions({this.caption, this.imageLocation, this.isSelected});

  List<ProductsModel> getCategory(
      List<ProductsModel> productList, String categoryName) {
    List<ProductsModel> categoryList = [];
    try {
      categoryList = productList
          .where((products2) => products2.category.contains(categoryName))
          .toList();
    } catch (e) {}

    return categoryList;
  }

  List<ProductsModel> getFeaturedProd(
      List<ProductsModel> productList, bool isFeatured) {
    List<ProductsModel> featuredList = [];
    try {
      featuredList = productList
          .where((products2) => products2.featured == isFeatured)
          .toList();
    } catch (e) {}

    return featuredList;
  }
}
