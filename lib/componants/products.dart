import 'package:ecommerce_app/db/product_db.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/product_services.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final Firestore _firestore = Firestore.instance;
  final String collection = 'Products';
  //bool _isLoading = true;
  @override
  var product_list = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer.jpg',
      'old_price': 120,
      'price': 85,
    },
    {
      'name': 'Snikers',
      'picture': 'images/products/shoes.jpg',
      'old_price': 100, //Image carousel
      'price': 50,
    },
    {
      'name': 'Tip Dress',
      'picture': 'images/products/dress.jpg',
      'old_price': 65, //Image carousel
      'price': 57,
    },
    {
      'name': 'Fip Shirt',
      'picture': 'images/products/shirt.jpg',
      'old_price': 30, //Image carousel
      'price': 18,
    },
    {
      'name': 'SPants',
      'picture': 'images/products/sweaterpants.jpg',
      'old_price': 123, //Image carousel
      'price': 99,
    },
    {
      'name': 'R Snikers',
      'picture': 'images/products/snikers.webp',
      'old_price': 32, //Image carousel
      'price': 11,
    },
  ];
  @override
  Widget build(BuildContext context) {
    List featuredProds = Provider.of<List<Products2>>(context);
    List proImages = [];
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        }

        final products = snapshot.data.documents;
        final List<SingleProduct> allProducts = [];
        for (var prod in products) {
          final prodId = prod.data['id'];
          final prodName = prod.data['name'];
          final prodBrand = prod.data['brand'];
          final prodCategory = prod.data['category'];
          final prodImages = prod.data['images'];
          final prodPrice = prod.data['price'];
          final prodOldPrice = prod.data['oldPrice'];
          final prodQuantity = prod.data['quantity'];
          final prodColors = prod.data['colors'];
          final prodSizes = prod.data['sizes'];
          final prodFavorite = prod.data['favorite'];
          final prodFeatured = prod.data['featured'];

          final singleProduct = SingleProduct(
            id: prodId,
            name: prodName,
            brand: prodBrand,
            category: prodCategory,
            images: prodImages,
            price: prodPrice,
            oldPrice: prodOldPrice,
            quantity: prodQuantity,
            colors: prodColors,
            sizes: prodSizes,
            favorite: prodFavorite,
            featured: prodFeatured,
          ); //*********This code is not used******************

          allProducts.add(singleProduct);
        }

        //==============================================
        for (var featuredProd in featuredProds) {
          proImages = featuredProd.images;
        }

        return GridView.builder(
          itemCount: allProducts.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, int index) => SingleProduct(
            name: allProducts[index].name,
            images: proImages[0],
            oldPrice: allProducts[index].oldPrice,
            price: allProducts[index].price,
            favorite: allProducts[index].favorite,
            brand: allProducts[index].brand,
          ),
        );
      },
    );
  }
}

//**********Product Details*********
class SingleProduct extends StatelessWidget {
  final String id;
  final String name;
  final String brand;
  final String category;
  final images;
  final double price;
  final double oldPrice;
  final int quantity;
  final List colors;
  final List sizes;
  final bool favorite;
  final bool featured;

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
    this.favorite,
    this.featured,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
                  favorite
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
//passing the values of the product to the productDetails page
                    builder: (context) => ProductDetails(
                      productDetailsName: name,
                      productDetailsOldPrice: oldPrice,
                      productDetailsPicture: images,
                      productDetailsPrice: price,
                      productBrand: brand,
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
                    image: DecorationImage(
                        image: NetworkImage(images), fit: BoxFit.contain),
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
                      style: TextStyle(color: Colors.red),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

//Card(
//child: Hero(
//tag: prod_name,
//child: Material(
//child: InkWell(
//onTap: () => Navigator.of(context).push(
//MaterialPageRoute(
////passing the values of the product to the productDetails page
//builder: (context) => ProductDetails(
//productDetailsName: prod_name,
//productDetailsOldPrice: prod_oldprice,
//productDetailsPicture: prod_picture,
//productDetailsPrice: prod_price,
//),
//),
//),
//child: GridTile(
//footer: Container(
//color: Colors.white70,
//child: ListTile(
//leading: Text(
//prod_name,
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//title: Text(
//'\$$prod_price',
//style: TextStyle(
//color: Colors.black,
//fontWeight: FontWeight.w800,
//),
//),
//subtitle: Text(
//'\$$prod_oldprice',
//style: TextStyle(
//color: Colors.black45,
//fontWeight: FontWeight.w800,
//decoration: TextDecoration.lineThrough,
//),
//),
//),
//),
//child: Image.asset(
//prod_picture,
//fit: BoxFit.cover,
//)),
//),
//),
//),
//);

//
//_isLoading
//? Container(
//color: Colors.red,
//height: 80,
//width: 80,
//child: Center(
//child: CircularProgressIndicator(
//backgroundColor: Colors.black,
//strokeWidth: 6.0,
//),
//),
//)
//:
