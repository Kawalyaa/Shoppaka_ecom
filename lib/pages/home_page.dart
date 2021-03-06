import 'package:ecommerce_app/db/product_services.dart';
import 'package:ecommerce_app/model/product2.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/products.dart';
import 'package:ecommerce_app/componants/horizontal_listview.dart';
import 'package:ecommerce_app/componants/image_carousel.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/componants/navigation_drawer.dart';
import 'package:ecommerce_app/constants.dart';
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
    var aList = Provider.of<List<Products2>>(context);
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
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ShoppingCart.id);
            },
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
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: aList == null
                ? CircularProgressIndicator()
                : Text(aList.length.toString() ?? ''),
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
