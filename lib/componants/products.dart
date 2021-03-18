import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool myFav = false;
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    var favData = Provider.of<FavoriteList>(context);

    return allProds == null
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          )
        : StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            padding: EdgeInsets.all(10),
            itemCount: allProds.length,
            itemBuilder: (context, index) => allProds.isEmpty
                ? Container(
                    child: Center(
                      child:
                          Image.asset('images/loading_gif/Spin-1s-200px.gif'),
                    ),
                  )
                : SingleProduct(
                    heroTag: allProds[index].name,
                    name: allProds[index].name,
                    price: allProds[index].price,
                    oldPrice: allProds[index].oldPrice,
                    images: allProds[index].images,
                    sizes: allProds[index].sizes,
                    colors: allProds[index].colors,
                    isFavorite: allProds[index].favorite,
                    category: allProds[index].category,
                    toggleFavorite: () {
                      allProds[index].favorite = !allProds[index].favorite;

                      //===Add or Remove  Favorite======
                      allProds[index].favorite
                          ? favData.addToFavorite(Products2(
                              name: allProds[index].name,
                              images: allProds[index].images,
                              price: allProds[index].price,
                              oldPrice: allProds[index].oldPrice,
                              favorite: allProds[index].favorite,
                              brand: allProds[index].brand,
                              sizes: allProds[index].sizes,
                              colors: allProds[index].colors))
                          : favData.removeFavorite(allProds[index].name);
                    },
                    similarProduct: CategoryOptions()
                        .getCategory(allProds, allProds[index].category),
                  ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          );
  }
}
