import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeaturedCategory extends StatefulWidget {
  @override
  _FeaturedCategoryState createState() => _FeaturedCategoryState();
}

class _FeaturedCategoryState extends State<FeaturedCategory> {
  @override
  Widget build(BuildContext context) {
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    bool featured = true;
    List<ProductsModel> featuredList =
        CategoryOptions().getFeaturedProd(allProds, featured);
    var favData = Provider.of<FavoritesProvider>(context);

    return MasonryGridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      // padding: EdgeInsets.all(10),
      itemCount: featuredList.length,
      itemBuilder: (context, int index) => featuredList.isEmpty
          ? Container(
              child: Center(
                child: Image.asset('images/loading_gif/Spin-1s-200px.gif'),
              ),
            )
          : SingleProduct(
              heroTag: featuredList[index].name,
              name: featuredList[index].name,
              brand: featuredList[index].brand,
              color: featuredList[index].color,
              isFavorite: featuredList[index].favorite,
              toggleFavorite: () {
                setState(() {
                  featuredList[index].favorite = !featuredList[index].favorite;

                  //===Add or Remove  Favorite======

                  featuredList[index].favorite
                      ? favData.addToFavorite(FavoritesModel(
                          name: featuredList[index].name,
                          images: featuredList[index].images,
                          category: featuredList[index].category,
                          price: featuredList[index].price,
                          oldPrice: featuredList[index].oldPrice,
                          favorite: featuredList[index].favorite,
                          brand: featuredList[index].brand,
                          selectedSize: featuredList[index].sizes,
                          color: featuredList[index].color,
                          selectedColor: featuredList[index].colors))
                      : favData.removeFavorite(index);
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
              description: featuredList[index].description,
              keyFeatures: featuredList[index].keyFeatures,
            ),
      // staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    );
  }
}
