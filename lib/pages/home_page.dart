import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/products.dart';
import 'package:ecommerce_app/componants/horizontal_listview.dart';
import 'package:ecommerce_app/componants/image_carousel.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/componants/navigation_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider2>(context);
    List cartList = data.cartProductList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopla',
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              fontSize: 24.0,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ShoppingCart.id);
            },
            child: Stack(children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: null,
              ),
              Positioned(
                top: 2,
                right: 2,
                child: cartList.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.red),
                        child: Text(
                            '${cartList.length > 0 ? cartList.length : null}'),
                      )
                    : Container(),
              )
            ]),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      drawer: NavigationDrawer(), //Navigation drawer
      body: ListView(
        children: <Widget>[
          ImageCarousel(), //Image carousel

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Categories'),
          ),

          HorizontalList(), //Horizontal list

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Recent Products'),
          ),

          //Grid view
          Container(
            height: 320,
            child: Products(),
          )

          //Horizontal ListView
        ],
      ),
    );
  }
}
