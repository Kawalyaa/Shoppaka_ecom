import 'package:ecommerce_app/componants/search_text_field.dart';
import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearch extends StatefulWidget {
  static const String id = 'ProductSearch';
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    ///Get input texts from user assign it to _terms
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _searchBar() => Padding(
        padding: EdgeInsets.all(8),
        child: SearchField(
          textEditingController: _controller,
          focusNode: _focusNode,
        ),
      );

  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    var data = Provider.of<ProductProvider2>(context);
    final List searchResult = data.search(_terms, allProds);

    var favData = Provider.of<FavoriteList>(context);

    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _searchBar(),
              Expanded(
                  child: ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) => _terms.isEmpty
                          ? SizedBox()
                          : SingleProduct(
                              name: searchResult[index].name,
                              brand: searchResult[index].brand,
                              heroTag: searchResult[index].name,
                              isFavorite: searchResult[index].favorite,
                              toggleFavorite: () {
                                setState(() {
                                  searchResult[index].favorite =
                                      !searchResult[index].favorite;

                                  //===Add or Remove  Favorite======

                                  searchResult[index].favorite
                                      ? favData.addToFavorite(Products2(
                                          name: searchResult[index].name,
                                          images: searchResult[index].images,
                                          price: searchResult[index].price,
                                          oldPrice:
                                              searchResult[index].oldPrice,
                                          favorite:
                                              searchResult[index].favorite,
                                          brand: searchResult[index].brand,
                                          sizes: searchResult[index].sizes,
                                          colors: searchResult[index].colors))
                                      : favData.removeFavorite(
                                          searchResult[index].name);
                                });
                              },
                              images: searchResult[index].images,
                              price: searchResult[index].price,
                              oldPrice: searchResult[index].oldPrice,
                              sizes: searchResult[index].sizes,
                              colors: searchResult[index].colors,
                              category: searchResult[index].category,
                              similarProduct: CategoryOptions().getCategory(
                                  allProds, searchResult[index].category),
                            )))
            ],
          ),
        ),
      ),
    );
  }
}

//
//Container(
//width: 300,
//decoration: BoxDecoration(
//color: Colors.blueGrey[50],
//borderRadius: BorderRadius.all(
//Radius.circular(5.0),
//),
//),
//child: TextField(
//style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[300]),
//decoration: InputDecoration(
//contentPadding: EdgeInsets.all(10.0),
//border: OutlineInputBorder(
//borderRadius: BorderRadius.circular(5.0),
//borderSide: BorderSide(color: Colors.white),
//),
//hintText: 'Eg: iphone 11',
//prefix: Icon(
//Icons.search,
//color: Colors.blueGrey[300],
//),
//hintStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey[300]),
//),
//maxLines: 1,
//),
//)
