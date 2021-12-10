import 'package:ecommerce_app/model/product_details_model.dart';
import 'package:ecommerce_app/pages/prod_detail.dart';
import 'package:flutter/material.dart';

class FavDetail extends StatelessWidget {
  final String id;
  final String name;
  final String brand;
  final String category;
  final images;
  final double price;
  final double oldPrice;
  final int quantity;
  final colors;
  final sizes;
  final bool isFavorite;
  final bool featured;
  final Function removeFavorite;
  final List similarProducts;

  FavDetail(
      {this.id,
      this.name,
      this.brand,
      this.category,
      this.images,
      this.price,
      this.oldPrice,
      this.quantity,
      this.colors,
      this.sizes,
      this.isFavorite,
      this.featured,
      this.removeFavorite,
      this.similarProducts});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0),
            ],
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: removeFavorite,
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //print(sizes);
                //passing the values of the product to the productDetails page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProdDetails(
                      productDetailsModel: ProductDetailsModel(
                          heroTag: 'favTag',
                          productDetailsName: name,
                          productDetailsOldPrice: oldPrice,
                          productDetailsPicture: images,
                          productDetailsPrice: price,
                          productBrand: brand,
                          productColors: colors,
                          productSizes: sizes,
                          isFavorite: isFavorite,
                          similarProd: similarProducts),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: name,
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  child: Center(
                    child: FadeInImage.assetNetwork(
                        placeholder:
                            'images/img_place_holder/placeholder-image.png',
                        image: images[0],
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, url, error) => Icon(
                              Icons.error,
                            )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 5.0,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '\$$oldPrice',
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '\$$price',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
