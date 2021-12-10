import 'package:ecommerce_app/componants/fav_detail.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Favorites extends StatefulWidget {
  static const String id = 'favorites';
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider2>(context);
    List cartList = data.cartProductList;

    //Favorites provider

    var favData = Provider.of<FavoritesProvider>(context);
    List<FavoritesModel> favList = favData.favoriteList;

//All products
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ShoppingCart.id);
            },
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 2,
                child: cartList.isNotEmpty
                    ? Container(
                        height: 18.0,
                        width: 18.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kColorRed),
                        child: Center(
                          child: Text(
                            '${cartList.length}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      )
                    : Container(),
              )
            ]),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: favList.isEmpty
          ? Center(
              child: Container(
              child: Text(
                'No Favorites',
                style: TextStyle(
                    color: kColorRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ))
          : ListView.builder(
              itemCount: favList.length,
              itemBuilder: (context, int index) => FavDetail(
                name: favList[index].name,
                brand: favList[index].brand,
                isFavorite: favList[index].favorite,
                removeFavorite: () {
                  favData.removeFavorite(favList[index].id);
                },
                images: favList[index].images,
                price: favList[index].price,
                oldPrice: favList[index].oldPrice,
                sizes: favList[index].selectedSize,
                colors: favList[index].selectedColor,
                description: favList[index].description,
                keyFeatures: favList[index].keyFeatures,
                color: favList[index].color,
                similarProducts: CategoryOptions()
                    .getCategory(allProds, favList[index].category),
              ),
            ),
    );
  }
}
