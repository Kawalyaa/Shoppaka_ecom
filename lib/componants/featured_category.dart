import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/model/categary_options.dart';

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
    var favData = Provider.of<FavoriteList>(context);

    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      padding: EdgeInsets.all(10),
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
              isFavorite: featuredList[index].favorite,
              toggleFavorite: () {
                setState(() {
                  featuredList[index].favorite = !featuredList[index].favorite;

                  //===Add or Remove  Favorite======

                  featuredList[index].favorite
                      ? favData.addToFavorite(ProductsModel(
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
            ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    );
  }
}
