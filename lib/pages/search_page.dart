import 'package:ecommerce_app/componants/search_text_field.dart';
import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
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
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    var data = Provider.of<ProductProvider2>(context);
    final List<ProductsModel> searchResult = data.search(_terms, allProds);

    var favData = Provider.of<FavoritesProvider>(context);

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
                                  ? favData.addToFavorite(FavoritesModel(
                                      name: searchResult[index].name,
                                      images: searchResult[index].images,
                                      price: searchResult[index].price,
                                      oldPrice: searchResult[index].oldPrice,
                                      favorite: searchResult[index].favorite,
                                      brand: searchResult[index].brand,
                                      category: searchResult[index].category,
                                      selectedSize: searchResult[index].sizes,
                                      selectedColor:
                                          searchResult[index].colors))
                                  : favData.removeFavorite(index);
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
                          description: searchResult[index].description,
                          keyFeatures: searchResult[index].keyFeatures,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
