import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/model/categary_options.dart';

class ShoesCategory extends StatefulWidget {
  @override
  _ShoesCategoryState createState() => _ShoesCategoryState();
}

class _ShoesCategoryState extends State<ShoesCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    String shoesCat = 'Shoes';
    List<Products2> shoesList =
        CategoryOptions().getCategory(allProds, shoesCat);
    var favData = Provider.of<FavoriteList>(context);

    return StaggeredGridView.countBuilder(
      // physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.all(10),
      itemCount: shoesList.length,
      itemBuilder: (context, index) => shoesList.isEmpty
          ? Container(
              child: Center(
                child: Image.asset('images/loading_gif/Spin-1s-200px.gif'),
              ),
            )
          : SingleProduct(
              heroTag: shoesList[index].name,
              name: shoesList[index].name,
              brand: shoesList[index].brand,
              isFavorite: shoesList[index].favorite,
              toggleFavorite: () {
                setState(() {
                  shoesList[index].favorite = !shoesList[index].favorite;

                  //===Add or Remove  Favorite======
                  shoesList[index].favorite
                      ? favData.addToFavorite(Products2(
                          name: shoesList[index].name,
                          images: shoesList[index].images,
                          price: shoesList[index].price,
                          oldPrice: shoesList[index].oldPrice,
                          favorite: shoesList[index].favorite,
                          brand: shoesList[index].brand,
                          sizes: shoesList[index].sizes,
                          colors: shoesList[index].colors))
                      : favData.removeFavorite(shoesList[index].name);
                });
              },
              images: shoesList[index].images,
              price: shoesList[index].price,
              oldPrice: shoesList[index].oldPrice,
              sizes: shoesList[index].sizes,
              colors: shoesList[index].colors,
              category: shoesList[index].category,
              similarProduct: CategoryOptions()
                  .getCategory(allProds, shoesList[index].category),
            ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    );
  }
}
