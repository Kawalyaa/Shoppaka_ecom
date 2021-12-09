import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/model/categary_options.dart';

class FeaturedCategory extends StatefulWidget {
  @override
  _FeaturedCategoryState createState() => _FeaturedCategoryState();
}

class _FeaturedCategoryState extends State<FeaturedCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    bool featured = true;
    List<Products2> featuredList =
        CategoryOptions().getFeaturedProd(allProds, featured);
    var favData = Provider.of<FavoriteList>(context);

    return GridView.builder(
        itemCount: featuredList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) => SingleProduct(
              name: featuredList[index].name,
              brand: featuredList[index].brand,
              isFavorite: featuredList[index].favorite,
              toggleFavorite: () {
                setState(() {
                  featuredList[index].favorite = !featuredList[index].favorite;

                  //===Add or Remove  Favorite======

                  featuredList[index].favorite
                      ? favData.addToFavorite(Products2(
                          name: featuredList[index].name,
                          images: featuredList[index].images,
                          price: featuredList[index].price,
                          oldPrice: featuredList[index].oldPrice,
                          favorite: featuredList[index].favorite,
                          brand: featuredList[index].brand,
                          sizes: featuredList[index].sizes,
                          colors: featuredList[index].colors))
                      : favData.removeFavorite(featuredList[index].name);
                });
              },
              images: featuredList[index].images,
              price: featuredList[index].price,
              oldPrice: featuredList[index].oldPrice,
              sizes: featuredList[index].sizes,
              colors: featuredList[index].colors,
              category: featuredList[index].category,
              similarProduct: CategoryOptions()
                  .getCategory(allProds, featuredList[index].category),
            ));
  }
}
