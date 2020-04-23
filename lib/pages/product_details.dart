import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home_page.dart';

class ProductDetails extends StatefulWidget {
  static const String id = 'productDetails';
  final productDetailsName;
  final productDetailsPicture;
  final productDetailsPrice;
  final productDetailsOldPrice;
  final productBrand;

  ProductDetails({
    this.productDetailsPicture,
    this.productDetailsName,
    this.productDetailsOldPrice,
    this.productDetailsPrice,
    this.productBrand,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              )),
          child: Text(
            'Shopla',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
                fontSize: 24.0,
                fontStyle: FontStyle.italic),
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: widget.productDetailsName,
            child: Container(
              height: 300.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(widget.productDetailsPicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Row(
              children: <Widget>[
                Text(
                  widget.productDetailsName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '\$${widget.productDetailsOldPrice}',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '\$${widget.productDetailsPrice}',
                  style: TextStyle(color: Colors.red, fontSize: 18.0),
                )
              ],
            ),
          ),

          Row(
            children: <Widget>[
              //*********Button 1******
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Size'),
                          content: Text('Choose the Size'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  elevation: 0.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Size')),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              //*********Button 2******
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Color'),
                            content: Text('Choose the Color'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        });
                  },
                  elevation: 0.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Color')),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              //*********Button 3******
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Quantity'),
                            content: Text('Choose the Quantity'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        });
                  },
                  elevation: 0.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Qtn')),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Material(
                  elevation: 2.0,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    onPressed: () {},
                    elevation: 0.2,
                    child: Text(
                      'Buy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ],
          ),
          Divider(),
          ListTile(
            title: Text('Product Details'),
            subtitle: Text(
                'The latest fasion trending in town.This fashion is fitting and classic for both the youth and elders,they are strong and with colors that can not be breached'),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Name',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.productDetailsName,
                    style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Brand',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('${widget.productBrand}',
                    style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Condition',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  (5.0),
                ),
                child: Text('New', style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
          //******SIMILAR PRODUCTS*******
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Similar Products'),
          ),
          Container(
            height: 360.0,
            child: SimilarProducts(),
          ),
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  bool _isFavorite = false;
  var productsList = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer.jpg',
      'old_price': 120,
      'price': 85,
    },
    {
      'name': 'Snikers',
      'picture': 'images/products/shoes.jpg',
      'old_price': 100,
      'price': 50,
    },
    {
      'name': 'Tip Dress',
      'picture': 'images/products/dress.jpg',
      'old_price': 65,
      'price': 57,
    },
    {
      'name': 'Fip Shirt',
      'picture': 'images/products/shirt.jpg',
      'old_price': 30,
      'price': 18,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productsList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, int index) => SimilarProductDetails(
        prodName: productsList[index]['name'],
        prodPicture: productsList[index]['picture'],
        prodOldPrice: productsList[index]['old_price'],
        prodPrice: productsList[index]['price'],
        isFavorite: _isFavorite,
      ),
    );
  }
}

class SimilarProductDetails extends StatelessWidget {
  final String prodName;
  final String prodPicture;
  final int prodOldPrice;
  final int prodPrice;
  final isFavorite;
  SimilarProductDetails(
      {this.prodName,
      this.prodPicture,
      this.prodOldPrice,
      this.prodPrice,
      this.isFavorite});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 2.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              productDetailsName: prodName,
              productDetailsPicture: prodPicture,
              productDetailsOldPrice: prodOldPrice,
              productDetailsPrice: prodPrice,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all((5.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    isFavorite
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
              Hero(
                tag: prodPicture,
                child: Container(
                  height: 85.0,
                  width: 85.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(prodPicture),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                prodName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\$$prodOldPrice',
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '\$$prodOldPrice',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Container(
//height: 300.0,
//child: GridTile(
//child: Container(
//color: Colors.white,
//child: Image.network(widget.productDetailsPicture),
//),
//footer: Container(
//color: Colors.white,
//child: ListTile(
//leading: Text(widget.productDetailsName,
//style: TextStyle(
//fontWeight: FontWeight.bold, fontSize: 20.0)),
//title: Row(
//children: <Widget>[
//Expanded(
//child: Text(
//'\$${widget.productDetailsOldPrice}',
//style: TextStyle(
//fontSize: 18.0,
//color: Colors.black54,
//decoration: TextDecoration.lineThrough),
//),
//),
//Expanded(
//child: Text(
//'\$${widget.productDetailsPrice}',
//style: TextStyle(color: Colors.black, fontSize: 18.0),
//),
//)
//],
//),
//),
//),
//),
//),
