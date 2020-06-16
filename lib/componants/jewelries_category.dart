import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JewelriesCategory extends StatefulWidget {
  @override
  _JewelriesCategoryState createState() => _JewelriesCategoryState();
}

class _JewelriesCategoryState extends State<JewelriesCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    String jewelriesCategory = 'Jewelries';
    List<Products2> jewelriesCategoryList =
        CategoryOptions().getCategory(allProds, jewelriesCategory);

    var favData = Provider.of<FavoriteList>(context);

    return GridView.builder(
        itemCount: jewelriesCategoryList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) => SingleProduct(
              name: jewelriesCategoryList[index].name,
              images: jewelriesCategoryList[index].images,
              price: jewelriesCategoryList[index].price,
              oldPrice: jewelriesCategoryList[index].oldPrice,
              brand: jewelriesCategoryList[index].brand,
              colors: jewelriesCategoryList[index].colors,
              sizes: jewelriesCategoryList[index].sizes,
              isFavorite: jewelriesCategoryList[index].favorite,
              toggleFavorite: () {
                setState(() {
                  //===toggle favorite=====
                  jewelriesCategoryList[index].favorite =
                      !jewelriesCategoryList[index].favorite;

                  //===Add or Remove  Favorite======
                  jewelriesCategoryList[index].favorite
                      ? favData.addToFavorite(Products2(
                          name: jewelriesCategoryList[index].name,
                          images: jewelriesCategoryList[index].images,
                          price: jewelriesCategoryList[index].price,
                          oldPrice: jewelriesCategoryList[index].oldPrice,
                          brand: jewelriesCategoryList[index].brand,
                          colors: jewelriesCategoryList[index].colors,
                          sizes: jewelriesCategoryList[index].sizes,
                          favorite: jewelriesCategoryList[index].favorite))
                      : favData
                          .removeFavorite(jewelriesCategoryList[index].name);
                });
              },
            ));
  }
}
