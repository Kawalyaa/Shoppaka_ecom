import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/cart_products.dart';

class ShoppingCart extends StatefulWidget {
  static const String id = 'shoppingCart';
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w900,
            fontFamily: 'Poppins',
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // appProvider.myFeatureProduct();
            },
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  'Total',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '\$185',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                elevation: 2.0,
                color: Colors.red,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 200.0,
                  height: 35.0,
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: ShoppingCartProducts(),
    );
  }
}
