import 'package:ecommerce_app/componants/single_product.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeaturedSection extends StatefulWidget {
  final Function featuredCallback;
  FeaturedSection({this.featuredCallback});
  @override
  _FeaturedSectionState createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  @override
  Widget build(BuildContext context) {
    List<ProductsModel> allProds = Provider.of<List<ProductsModel>>(context);
    bool featured = true;
    List<ProductsModel> featuredList =
        CategoryOptions().getFeaturedProd(allProds, featured);
    var favData = Provider.of<FavoritesProvider>(context);

    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height / 1.7,
          color: Color(0xff2FC5BA), //0xff04c48E
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
                    'Featured',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: widget.featuredCallback,
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
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                padding: EdgeInsets.all(10),
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return featuredList.isEmpty
                      ? Container(
                          child: Center(
                            child: Image.asset(
                                'images/loading_gif/Spin-1s-200px.gif'),
                          ),
                        )
                      : SingleProduct(
                          name: featuredList[index].name,
                          brand: featuredList[index].brand,
                          heroTag: featuredList[index].name,
                          color: featuredList[index].color,
                          isFavorite: featuredList[index].favorite,
                          toggleFavorite: () {
                            setState(() {
                              featuredList[index].favorite =
                                  !featuredList[index].favorite;

                              //===Add or Remove  Favorite======

                              featuredList[index].favorite
                                  ? favData.addToFavorite(FavoritesModel(
                                      name: featuredList[index].name,
                                      images: featuredList[index].images,
                                      price: featuredList[index].price,
                                      oldPrice: featuredList[index].oldPrice,
                                      favorite: featuredList[index].favorite,
                                      brand: featuredList[index].brand,
                                      category: featuredList[index].category,
                                      color: featuredList[index].color,
                                      description:
                                          featuredList[index].description,
                                      keyFeatures:
                                          featuredList[index].keyFeatures,
                                      selectedSize: featuredList[index].sizes,
                                      selectedColor:
                                          featuredList[index].colors))
                                  : favData.removeFavorite(index);
                            });
                          },
                          images: featuredList[index].images,
                          price: featuredList[index].price,
                          oldPrice: featuredList[index].oldPrice,
                          sizes: featuredList[index].sizes,
                          colors: featuredList[index].colors,
                          category: featuredList[index].category,
                          similarProduct: CategoryOptions().getCategory(
                              allProds, featuredList[index].category),
                          description: featuredList[index].description,
                          keyFeatures: featuredList[index].keyFeatures,
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
