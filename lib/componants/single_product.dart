import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/model/product_details_model.dart';
import 'package:ecommerce_app/pages/prod_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String id;
  final String name;
  final String brand;
  final String category;
  final List images;
  final int price;
  final int oldPrice;
  final int quantity;
  final List colors;
  final String color;
  final List sizes;
  final List similarProduct;
  final bool isFavorite;
  final bool featured;
  final Function toggleFavorite;
  final Widget placeholder;
  final heroTag;
  final List description;
  final List keyFeatures;

  SingleProduct({
    this.id,
    this.name,
    this.heroTag,
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
    this.toggleFavorite,
    this.placeholder,
    this.similarProduct,
    this.description,
    this.keyFeatures,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    //var _time = DateTime.now().toString();
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: toggleFavorite,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: kColorRed,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //passing the values of the product to the productDetails page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProdDetails(
                      productDetailsModel: ProductDetailsModel(
                        productDetailsName: name,
                        heroTag: name,
                        productDetailsOldPrice: oldPrice,
                        productDetailsPicture: images,
                        productDetailsPrice: price,
                        productBrand: brand,
                        productColors: colors,
                        productSizes: sizes,
                        isFavorite: isFavorite,
                        category: category,
                        similarProd: similarProduct,
                        description: description,
                        keyFeatures: keyFeatures,
                        color: color,
                      ),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: heroTag,
                child: Container(
                  height: 105,
                  width: 105,
                  // height: MediaQuery.of(context).size.height / 6.2,
                  //width: MediaQuery.of(context).size.height / 5.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.scaleDown,
                    placeholder: 'images/loading_gif/Spin-1s-200px.gif',
                    image: images[0],
                    imageErrorBuilder: (context, url, error) => Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'UGX $oldPrice',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough, fontSize: 13.0),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'UGX $price',
                  style: TextStyle(
                      color: kColorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
