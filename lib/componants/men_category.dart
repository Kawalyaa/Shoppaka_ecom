import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
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
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    String menCategory = 'Men';
    List<ProductsModel> menCategoryList =
        CategoryOptions().getCategory(allProds, menCategory);

    var favData = Provider.of<FavoritesProvider>(context);

    return GridView.builder(
      itemCount: menCategoryList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, int index) => SingleProduct(
        name: menCategoryList[index].name,
        images: menCategoryList[index].images,
        price: menCategoryList[index].price,
        oldPrice: menCategoryList[index].oldPrice,
        color: menCategoryList[index].color,
        brand: menCategoryList[index].brand,
        colors: menCategoryList[index].colors,
        sizes: menCategoryList[index].sizes,
        isFavorite: menCategoryList[index].favorite,
        similarProduct: CategoryOptions()
            .getCategory(allProds, menCategoryList[index].category),
        toggleFavorite: () {
          setState(() {
            menCategoryList[index].favorite = !menCategoryList[index].favorite;

            //===Add or Remove  Favorite======
            menCategoryList[index].favorite
                ? favData.addToFavorite(FavoritesModel(
                    name: menCategoryList[index].name,
                    images: menCategoryList[index].images,
                    price: menCategoryList[index].price,
                    category: menCategoryList[index].category,
                    oldPrice: menCategoryList[index].oldPrice,
                    brand: menCategoryList[index].brand,
                    selectedColor: menCategoryList[index].colors,
                    selectedSize: menCategoryList[index].sizes,
                    color: menCategoryList[index].color,
                    favorite: menCategoryList[index].favorite))
                : favData.removeFavorite(index);
          });
        },
        description: menCategoryList[index].description,
        keyFeatures: menCategoryList[index].keyFeatures,
      ),
    );
  }
}
