import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/pages/checkout_page.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/cart-product-detail.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'loading_page.dart';

class ShoppingCart extends StatefulWidget {
  static const String id = 'shoppingCart';

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    var getValue = Provider.of<ProductProvider2>(context);
    UserProv auth = Provider.of<UserProv>(context);

    List<CartModel> cartList = getValue.cartProductList;
    double totalPrice = getValue.getTotalPrice();

    return cartList.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'My Cart',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22.0,
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    'images/cart/empty_cart.jpeg',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Your Cart Is Empty\n Add Items',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ))
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'My Cart',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22.0,
                ),
              ),
              backgroundColor: Colors.white,
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
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'UGX${totalPrice.roundToDouble()}',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      elevation: 2.0,
                      color: kColorRed,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: () async {
                          //await auth.reloadUser();
                          switch (auth.status) {
                            case Status.Unauthenticated:
                              return Navigator.pushNamed(context, Login.id);
                            case Status.Authenticating:
                            case Status.Authenticated:
                              return Navigator.pushNamed(context, Checkout.id,
                                  arguments: Checkout(
                                    productPrice: totalPrice.roundToDouble(),
                                  ));
                            default:
                              return LoadingPage();
                          }
                        },
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
            body: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) => CartItems(
                name: cartList[index].name,
                picture: cartList[index].images[0],
                price: cartList[index].price,
                selectedSize: cartList[index].selectedSize,
                selectedColor: cartList[index].selectedColor,
                quantity: cartList[index].qty,
                buttonUp: () {
                  getValue.increaseQty(index);
                },
                buttonDown: () {
                  getValue.decreaseQty(index);
                },
                deleteItem: () {
                  getValue.removeProduct(index);
                  // getValue.removeAllCartProducts();
                },
              ),
            ),
          );
  }
}

//TODO 1 Add description to products
