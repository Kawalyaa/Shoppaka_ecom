import 'package:ecommerce_app/componants/image_carousel_slider.dart';
import 'package:ecommerce_app/componants/original_product_section.dart';
import 'package:ecommerce_app/componants/featured_section.dart';
import 'package:ecommerce_app/db/app_data.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/pages/category_products_list.dart';
import 'package:ecommerce_app/pages/search_page.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/category_option_detail.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/componants/navigation_drawer.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

Options categoryOption = Options.ALL;

class HomePage extends StatefulWidget {
  static const String id = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditingController _searchController = TextEditingController();
  int selectedIndex;
  List<CategoryOptions> optionsList = AppData.categoryOptionsList;
//  Options categoryOption = Options.ALL;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider2>(context);
    List cartList = data.cartProductList;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: _searchBar(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
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
          ImageCarouselSlider(),
          //ImageCarousel(), //Image carousel

          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 20),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
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
                  caption: optionsList[index].caption,
                  imageLocation: optionsList[index].imageLocation,
                  isSelected: selectedIndex == index,
                  onSelected: () {
                    Navigator.pushNamed(context, CategoryProductsList.id,
                        arguments: categoryOption);

                    setState(() {
                      selectedIndex = index;
                      _selectedOption(optionsList, index);
                    });
                  },
                );
              },
            ),
          ),
          _productList1(),

          _productList2(),
        ],
      ),
    );
  }

  Expanded interestsContainer(
      {Color colors, String text, Color textColor, var imageLink}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: colors, borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Container(
              width: 101,
              padding: EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, right: 4.0, bottom: 4.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    image: DecorationImage(
                        image: AssetImage(
                          imageLink,
                        ),
                        fit: BoxFit.cover)),
                height: 58,
                width: 63,
              ),
            )
          ],
        ),
      ),
    );
  }

  _productList1() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: FeaturedSection(
              featuredCallback: () {
                categoryOption = Options.FEATURED;
                Navigator.pushNamed(context, CategoryProductsList.id,
                    arguments: categoryOption);
              },
            ),
          ),
        ],
      );

  _productList2() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: OriginalProductSection(
              orignProdCallback: () {
                categoryOption = Options.SORTED;
                Navigator.pushNamed(context, CategoryProductsList.id,
                    arguments: categoryOption);
              },
            ),
          ),
        ],
      );

  void _selectedOption(List<CategoryOptions> optList, int optIndex) {
    if (optList[optIndex].caption == 'All') {
      categoryOption = Options.ALL;
    }
    if (optList[optIndex].caption == 'phones') {
      categoryOption = Options.HIGH_END;
    }
    if (optList[optIndex].caption == 'Shoes') {
      categoryOption = Options.SHOES;
    }
    if (optList[optIndex].caption == 'Men') {
      categoryOption = Options.MEN;
    }
    if (optList[optIndex].caption == 'Women') {
      categoryOption = Options.WOMEN;
    }

    if (optList[optIndex].caption == 'Jewelries') {
      categoryOption = Options.JEWELRY;
    }
  }

  _searchBar() => Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProductSearch.id);
              },
              child: Container(
                height: 39,
                decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  textAlign: TextAlign.left,
                  enabled: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
        ],
      );
}
