import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OriginalProductSection extends StatefulWidget {
  final Function orignProdCallback;
  OriginalProductSection({this.orignProdCallback});
  @override
  _OriginalProductSectionState createState() => _OriginalProductSectionState();
}

class _OriginalProductSectionState extends State<OriginalProductSection> {
  @override
  Widget build(BuildContext context) {
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    String shoesCat = 'phones';
    List<ProductsModel> phonesList =
        CategoryOptions().getCategory(allProds, shoesCat);
    var favData = Provider.of<FavoritesProvider>(context);
    phonesList.sort((a, b) => a.name.compareTo(b.name));

    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height / 1.7,
          color: Color(0xffEE7D6D), //0xff00422D
        ),
        Positioned(
          top: size.height / 65,
          child: Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Original products',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: widget.orignProdCallback,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('View All'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: size.height / 10,
          child: Container(
            height: size.height,
            padding: EdgeInsets.only(left: 2, right: 2),
            width: size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                padding: EdgeInsets.all(10),
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return phonesList.isEmpty
                      ? Container(
                          child: Center(
                            child: Image.asset(
                                'images/loading_gif/Spin-1s-200px.gif'),
                          ),
                        )
                      : SingleProduct(
                          name: phonesList[index].name,
                          color: phonesList[index].color,
                          brand: phonesList[index].brand,
                          heroTag: phonesList[index].brand,
                          isFavorite: phonesList[index].favorite,
                          toggleFavorite: () {
                            setState(() {
                              phonesList[index].favorite =
                                  !phonesList[index].favorite;

                              //===Add or Remove  Favorite======
                              phonesList[index].favorite
                                  ? favData.addToFavorite(FavoritesModel(
                                      name: phonesList[index].name,
                                      images: phonesList[index].images,
                                      price: phonesList[index].price,
                                      color: phonesList[index].color,
                                      description:
                                          phonesList[index].description,
                                      keyFeatures:
                                          phonesList[index].keyFeatures,
                                      category: phonesList[index].category,
                                      oldPrice: phonesList[index].oldPrice,
                                      favorite: phonesList[index].favorite,
                                      brand: phonesList[index].brand,
                                      selectedSize: phonesList[index].sizes,
                                      selectedColor: phonesList[index].colors))
                                  : favData
                                      .removeFavorite(phonesList[index].id);
                            });
                          },
                          images: phonesList[index].images,
                          price: phonesList[index].price,
                          oldPrice: phonesList[index].oldPrice,
                          sizes: phonesList[index].sizes,
                          colors: phonesList[index].colors,
                          category: phonesList[index].category,
                          similarProduct: CategoryOptions().getCategory(
                              allProds, phonesList[index].category),
                          description: phonesList[index].description,
                          keyFeatures: phonesList[index].keyFeatures,
                        );
                },
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              ),
            ),
          ),
        )
      ],
    );
  }
}
