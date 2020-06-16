import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WomenCategory extends StatefulWidget {
  @override
  _WomenCategoryState createState() => _WomenCategoryState();
}

class _WomenCategoryState extends State<WomenCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    String womenCategory = 'Women';
    List<Products2> womenCategoryList =
        CategoryOptions().getCategory(allProds, womenCategory);

    var favData = Provider.of<FavoriteList>(context);

    return GridView.builder(
        itemCount: womenCategoryList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) => SingleProduct(
              name: womenCategoryList[index].name,
              images: womenCategoryList[index].images,
              price: womenCategoryList[index].price,
              oldPrice: womenCategoryList[index].oldPrice,
              brand: womenCategoryList[index].brand,
              colors: womenCategoryList[index].colors,
              sizes: womenCategoryList[index].sizes,
              isFavorite: womenCategoryList[index].favorite,
              category: womenCategoryList[index].category,
              toggleFavorite: () {
                setState(() {
                  //===toggle favorite=====
                  womenCategoryList[index].favorite =
                      !womenCategoryList[index].favorite;

                  //===Add or Remove  Favorite======
                  womenCategoryList[index].favorite
                      ? favData.addToFavorite(Products2(
                          name: womenCategoryList[index].name,
                          images: womenCategoryList[index].images,
                          price: womenCategoryList[index].price,
                          oldPrice: womenCategoryList[index].oldPrice,
                          brand: womenCategoryList[index].brand,
                          colors: womenCategoryList[index].colors,
                          sizes: womenCategoryList[index].sizes,
                          favorite: womenCategoryList[index].favorite))
                      : favData.removeFavorite(womenCategoryList[index].name);
                });
              },
            ));
  }
}
