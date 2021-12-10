import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
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
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    String jewelriesCategory = 'Jewelries';
    List<ProductsModel> jewelriesCategoryList =
        CategoryOptions().getCategory(allProds, jewelriesCategory);

    var favData = Provider.of<FavoritesProvider>(context);

    return GridView.builder(
        itemCount: jewelriesCategoryList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) => SingleProduct(
              name: jewelriesCategoryList[index].name,
              images: jewelriesCategoryList[index].images,
              price: jewelriesCategoryList[index].price,
              color: jewelriesCategoryList[index].color,
              oldPrice: jewelriesCategoryList[index].oldPrice,
              brand: jewelriesCategoryList[index].brand,
              colors: jewelriesCategoryList[index].colors,
              sizes: jewelriesCategoryList[index].sizes,
              isFavorite: jewelriesCategoryList[index].favorite,
              similarProduct: CategoryOptions()
                  .getCategory(allProds, jewelriesCategoryList[index].category),
              toggleFavorite: () {
                setState(() {
                  //===toggle favorite=====
                  jewelriesCategoryList[index].favorite =
                      !jewelriesCategoryList[index].favorite;

                  //===Add or Remove  Favorite======
                  jewelriesCategoryList[index].favorite
                      ? favData.addToFavorite(FavoritesModel(
                          name: jewelriesCategoryList[index].name,
                          images: jewelriesCategoryList[index].images,
                          price: jewelriesCategoryList[index].price,
                          color: jewelriesCategoryList[index].color,
                          oldPrice: jewelriesCategoryList[index].oldPrice,
                          brand: jewelriesCategoryList[index].brand,
                          category: jewelriesCategoryList[index].category,
                          selectedColor: jewelriesCategoryList[index].colors,
                          selectedSize: jewelriesCategoryList[index].sizes,
                          favorite: jewelriesCategoryList[index].favorite))
                      : favData.removeFavorite(index);
                });
              },
              description: jewelriesCategoryList[index].description,
              keyFeatures: jewelriesCategoryList[index].keyFeatures,
            ));
  }
}
