import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/pages/prod_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    List<Products2> featuredProds = Provider.of<List<Products2>>(context);

    return featuredProds == null
        ? Center(
            child: Container(
              height: 200.0,
              child: CircularProgressIndicator(),
            ),
          )
        : GridView.builder(
            itemCount: featuredProds.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, int index) => SingleProduct(
                  name: featuredProds[index].name,
                  brand: featuredProds[index].brand,
                  isFavorite: featuredProds[index].favorite,
                  toggleFavorite: () {
                    setState(() {
                      featuredProds[index].favorite =
                          !featuredProds[index].favorite;
                    });
                  },
                  images: featuredProds[index].images,
                  price: featuredProds[index].price,
                  oldPrice: featuredProds[index].oldPrice,
                  sizes: featuredProds[index].sizes,
                  colors: featuredProds[index].colors,
                ));
  }
}

class SingleProduct extends StatelessWidget {
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
  bool isFavorite;
  final bool featured;
  final Function toggleFavorite;

  SingleProduct({
    this.id,
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
  });
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
                    ),
                  ),
                );
              },
              child: Hero(
                tag: name,
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(images[0]), fit: BoxFit.cover),
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
