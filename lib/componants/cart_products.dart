import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShoppingCartProducts extends StatefulWidget {
  @override
  _ShoppingCartProductsState createState() => _ShoppingCartProductsState();
}

class _ShoppingCartProductsState extends State<ShoppingCartProducts> {
//  var itemsAddedOnCart = [
//    {
//      'name': 'Blazer',
//      'picture': 'images/products/blazer.jpg',
//      'price': 85,
//      'color': 'brown',
//      'size': 'M',
//      'qty': 1
//    },
//    {
//      'name': 'Snikers',
//      'picture': 'images/products/shoes.jpg',
//      'price': 50,
//      'color': 'Siver',
//      'size': '6',
//      'qty': 2
//    }
//  ];
  @override
  Widget build(BuildContext context) {
    var getValue = Provider.of<ProductProvider2>(context);
    List<CartModel> cartList = getValue.cartProductList;
    return ListView.builder(
      itemCount: cartList.length,
      itemBuilder: (context, index) => CartItems(
        name: cartList[index].name,
        picture: cartList[index].images[0],
        price: cartList[index].price,
        selectedSize: cartList[index].selectedSize,
        selectedColor: cartList[index].selectedColor,
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  final String name;
  final String picture;
  final String size;
  final double price;
  final String selectedColor;
  final String selectedSize;
  int quantity;

  CartItems(
      {this.name,
      this.picture,
      this.size,
      this.selectedColor,
      this.price,
      this.selectedSize,
      this.quantity = 1});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network(
            picture,
            width: 80.0,
            height: 80.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  //******Size section******
                  Text('Size :'),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '$size',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),

                  //*****Color section*******
                  Text('Color :'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$selectedColor',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),

              //******Price Section******
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  '\$$price',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 30.0,
          ),
          //*******Icon Button section*****
          Column(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_up),
              ),
              Text('$quantity'),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down))
            ],
          )
        ],
      ),
    ));
  }
}
