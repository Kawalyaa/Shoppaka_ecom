import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OriginalProductSection extends StatefulWidget {
  @override
  _OriginalProductSectionState createState() => _OriginalProductSectionState();
}

class _OriginalProductSectionState extends State<OriginalProductSection> {
  @override
  Widget build(BuildContext context) {
    List<Products2> allProds = Provider.of<List<Products2>>(context);
    String shoesCat = 'Shoes';
    List<Products2> shoesList =
        CategoryOptions().getCategory(allProds, shoesCat);
    var favData = Provider.of<FavoriteList>(context);

    var size = MediaQuery.of(context).size;
    var _time = DateTime.now().microsecond.toString();
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
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Veiw All'),
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
            height: size.height / 1.6,
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
                  return shoesList.isEmpty
                      ? Container(
                          child: Center(
                            child: Image.asset(
                                'images/loading_gif/Spin-1s-200px.gif'),
                          ),
                        )
                      : SingleProduct(
                          name: shoesList[index].name,
                          brand: shoesList[index].brand,
                          heroTag: shoesList[index].brand,
                          isFavorite: shoesList[index].favorite,
                          toggleFavorite: () {
                            setState(() {
                              shoesList[index].favorite =
                                  !shoesList[index].favorite;

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
                                  : favData
                                      .removeFavorite(shoesList[index].name);
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