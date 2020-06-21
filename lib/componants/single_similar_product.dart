import 'package:ecommerce_app/componants/similar_prod_detail.dart';
import 'package:ecommerce_app/pages/prod_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimilarSingleProduct extends StatelessWidget {
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
  final bool isFavorite;
  final bool featured;
  final Function toggleFavorite;
  final List similarProduct;
  final placeholder;

  SimilarSingleProduct(
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
      this.toggleFavorite,
      this.similarProduct,
      this.placeholder});
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
                //print(sizes);
                //passing the values of the product to the productDetails page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProdDetails(
                        productDetailsName: name,
                        productDetailsOldPrice: oldPrice,
                        productDetailsPicture: images,
                        productDetailsPrice: price,
                        productBrand: brand,
                        productColors: colors,
                        productSizes: sizes,
                        isFavorite: isFavorite,
                        category: category,
                        similarProd: similarProduct),
                  ),
                );
              },
              child: Hero(
                tag: Text('name1'),
                child: Container(
                  height: 100.0,
                  width: 100.0,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Image.network(
//images[0],
//fit: BoxFit.cover,
//frameBuilder:
//(context, child, frame, wasSynchronouslyLoaded) {
//if (wasSynchronouslyLoaded) {
//return child;
//}
//return AnimatedSwitcher(
//duration: Duration(milliseconds: 500),
//child: frame != null ? child : placeholder,
//);
//},
//),
