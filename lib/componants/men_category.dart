import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenCategory extends StatefulWidget {
  @override
  _MenCategoryState createState() => _MenCategoryState();
}

class _MenCategoryState extends State<MenCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    String menCategory = 'Men';
    List<Products2> menCategoryList =
        CategoryOptions().getCategory(allProds, menCategory);

    var favData = Provider.of<FavoriteList>(context);

    return GridView.builder(
        itemCount: menCategoryList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) => SingleProduct(
              name: menCategoryList[index].name,
              images: menCategoryList[index].images,
              price: menCategoryList[index].price,
              oldPrice: menCategoryList[index].oldPrice,
              brand: menCategoryList[index].brand,
              colors: menCategoryList[index].colors,
              sizes: menCategoryList[index].sizes,
              isFavorite: menCategoryList[index].favorite,
              similarProduct: CategoryOptions()
                  .getCategory(allProds, menCategoryList[index].category),
              toggleFavorite: () {
                setState(() {
                  menCategoryList[index].favorite =
                      !menCategoryList[index].favorite;

                  //===Add or Remove  Favorite======
                  menCategoryList[index].favorite
                      ? favData.addToFavorite(Products2(
                          name: menCategoryList[index].name,
                          images: menCategoryList[index].images,
                          price: menCategoryList[index].price,
                          oldPrice: menCategoryList[index].oldPrice,
                          brand: menCategoryList[index].brand,
                          colors: menCategoryList[index].colors,
                          sizes: menCategoryList[index].sizes,
                          favorite: menCategoryList[index].favorite))
                      : favData.removeFavorite(menCategoryList[index].name);
                });
              },
            ));
  }
}
