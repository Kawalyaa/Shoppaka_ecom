import 'package:ecommerce_app/app_data/app_data.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/products.dart';
import 'package:ecommerce_app/componants/category_option_detail.dart';
import 'package:ecommerce_app/componants/image_carousel.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/componants/navigation_drawer.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  int selectedIndex;
  List<CategoryOptions> optionsList = AppData.categoryOptionList;
  Options categoryOption = Options.FEATURED;

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
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ShoppingCart.id);
            },
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 2,
                child: cartList.isNotEmpty
                    ? Container(
                        height: 18.0,
                        width: 18.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kColorRed),
                        child: Center(
                          child: Text(
                            '${cartList.length}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
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

          //Horizontal list view
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: 80.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: optionsList.length,
              itemBuilder: (context, int index) {
                return SelectCategory(
                  imageCaption: optionsList[index].imageCaption,
                  imageLocation: optionsList[index].imageLocation,
                  isSelected: selectedIndex == index,
                  onSelected: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          //======HorizontalList(), //Horizontal list

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
