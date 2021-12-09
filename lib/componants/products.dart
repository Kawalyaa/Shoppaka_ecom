import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool myFav = false;
  @override
  Widget build(BuildContext context) {
    List<Products2> featuredProds = Provider.of<List<Products2>>(context);
    var favData = Provider.of<FavoriteList>(context);

    return featuredProds == null
        ? Center(
            child: Container(
              height: 200.0,
              child: CircularProgressIndicator(),
            ),
          )
        : GridView.builder(
            itemCount: featuredProds.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, int index) => SingleProduct(
              name: featuredProds[index].name,
              price: featuredProds[index].price,
              oldPrice: featuredProds[index].oldPrice,
              images: featuredProds[index].images,
              sizes: featuredProds[index].sizes,
              colors: featuredProds[index].colors,
              isFavorite: featuredProds[index].favorite,
              toggleFavorite: () {
                featuredProds[index].favorite = !featuredProds[index].favorite;

                //===Add or Remove  Favorite======
                featuredProds[index].favorite
                    ? favData.addToFavorite(Products2(
                        name: featuredProds[index].name,
                        images: featuredProds[index].images,
                        price: featuredProds[index].price,
                        oldPrice: featuredProds[index].oldPrice,
                        favorite: featuredProds[index].favorite,
                        brand: featuredProds[index].brand,
                        sizes: featuredProds[index].sizes,
                        colors: featuredProds[index].colors))
                    : favData.removeFavorite(featuredProds[index].name);
              },
            ),
          );
  }
}
