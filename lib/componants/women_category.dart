import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
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
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    String womenCategory = 'Women';
    List<ProductsModel> womenCategoryList =
        CategoryOptions().getCategory(allProds, womenCategory);

    var favData = Provider.of<FavoritesProvider>(context);

    return GridView.builder(
      itemCount: womenCategoryList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, int index) => SingleProduct(
        name: womenCategoryList[index].name,
        color: womenCategoryList[index].color,
        images: womenCategoryList[index].images,
        price: womenCategoryList[index].price,
        oldPrice: womenCategoryList[index].oldPrice,
        brand: womenCategoryList[index].brand,
        colors: womenCategoryList[index].colors,
        sizes: womenCategoryList[index].sizes,
        isFavorite: womenCategoryList[index].favorite,
        category: womenCategoryList[index].category,
        similarProduct: CategoryOptions()
            .getCategory(allProds, womenCategoryList[index].category),
        toggleFavorite: () {
          setState(() {
            //===toggle favorite=====
            womenCategoryList[index].favorite =
                !womenCategoryList[index].favorite;

            //===Add or Remove  Favorite======
            womenCategoryList[index].favorite
                ? favData.addToFavorite(FavoritesModel(
                    name: womenCategoryList[index].name,
                    images: womenCategoryList[index].images,
                    price: womenCategoryList[index].price,
                    color: womenCategoryList[index].color,
                    oldPrice: womenCategoryList[index].oldPrice,
                    category: womenCategoryList[index].category,
                    brand: womenCategoryList[index].brand,
                    selectedColor: womenCategoryList[index].colors,
                    selectedSize: womenCategoryList[index].sizes,
                    favorite: womenCategoryList[index].favorite))
                : favData.removeFavorite(womenCategoryList[index].id);
          });
        },
        description: womenCategoryList[index].description,
        keyFeatures: womenCategoryList[index].keyFeatures,
      ),
    );
  }
}
