import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TechCategory extends StatefulWidget {
  @override
  _TechCategoryState createState() => _TechCategoryState();
}

class _TechCategoryState extends State<TechCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    String techCategory = 'Tech';
    List<Products2> techCategoryList =
        CategoryOptions().getCategory(allProds, techCategory);

    var favData = Provider.of<FavoriteList>(context);

    return GridView.builder(
        itemCount: techCategoryList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) => SingleProduct(
              name: techCategoryList[index].name,
              images: techCategoryList[index].images,
              price: techCategoryList[index].price,
              oldPrice: techCategoryList[index].oldPrice,
              brand: techCategoryList[index].brand,
              colors: techCategoryList[index].colors,
              sizes: techCategoryList[index].sizes,
              isFavorite: techCategoryList[index].favorite,
              category: techCategoryList[index].category,
              similarProduct: CategoryOptions()
                  .getCategory(allProds, techCategoryList[index].category),
              toggleFavorite: () {
                setState(() {
                  //===toggle favorite=====
                  techCategoryList[index].favorite =
                      !techCategoryList[index].favorite;

                  //===Add or Remove  Favorite======
                  techCategoryList[index].favorite
                      ? favData.addToFavorite(Products2(
                          name: techCategoryList[index].name,
                          images: techCategoryList[index].images,
                          price: techCategoryList[index].price,
                          oldPrice: techCategoryList[index].oldPrice,
                          brand: techCategoryList[index].brand,
                          colors: techCategoryList[index].colors,
                          sizes: techCategoryList[index].sizes,
                          favorite: techCategoryList[index].favorite))
                      : favData.removeFavorite(techCategoryList[index].name);
                });
              },
            ));
  }
}
