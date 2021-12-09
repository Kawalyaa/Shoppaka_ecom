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
  final double price;
  final double oldPrice;
  final int quantity;
  final List colors;
  final List sizes;
  final List similarProduct;
  final bool isFavorite;
  final bool featured;
  final Function toggleFavorite;
  final Widget placeholder;
  final heroTag;

  SingleProduct(
      {this.id,
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
      this.similarProduct});
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
                      color: Colors.red,
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
                      ),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: heroTag,
                child: Container(
                  height: MediaQuery.of(context).size.height / 6.2,
                  width: MediaQuery.of(context).size.height / 5.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: 'images/loading_gif/Spin-1s-200px.gif',
                      image: images[0]),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'UGX$oldPrice',
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'UGX$price',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
