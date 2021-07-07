import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
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
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    String techCategory = 'Tech';
    List<ProductsModel> techCategoryList =
        CategoryOptions().getCategory(allProds, techCategory);

    var favData = Provider.of<FavoritesProvider>(context);

    return GridView.builder(
      itemCount: techCategoryList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, int index) => SingleProduct(
        name: techCategoryList[index].name,
        images: techCategoryList[index].images,
        price: techCategoryList[index].price,
        color: techCategoryList[index].color,
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
                ? favData.addToFavorite(FavoritesModel(
                    name: techCategoryList[index].name,
                    images: techCategoryList[index].images,
                    price: techCategoryList[index].price,
                    oldPrice: techCategoryList[index].oldPrice,
                    brand: techCategoryList[index].brand,
                    color: techCategoryList[index].color,
                    category: techCategoryList[index].category,
                    selectedColor: techCategoryList[index].colors,
                    selectedSize: techCategoryList[index].sizes,
                    favorite: techCategoryList[index].favorite))
                : favData.removeFavorite(index);
          });
        },
        description: techCategoryList[index].description,
        keyFeatures: techCategoryList[index].keyFeatures,
      ),
    );
  }
}
