import 'package:ecommerce_app/componants/image_carousel_slider.dart';
import 'package:ecommerce_app/componants/original_product_section.dart';
import 'package:ecommerce_app/componants/featured_section.dart';
import 'package:ecommerce_app/db/app_data.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/pages/category_products_list.dart';
import 'package:ecommerce_app/pages/search_page.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/category_option_detail.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/componants/navigation_drawer.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
    List<UserModel> userInfo = Provider.of<List<UserModel>>(context);
    List cartList = data.cartProductList;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProductSearch.id);
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
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
          ),
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
      drawer: userInfo == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : NavigationDrawer(
              name: userInfo[0].name,
              address: userInfo[0].address,
              photo: userInfo[0].photo,
              email: userInfo[0].email,
            ), //Navigation drawer
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

                      ///When pressed should Navigate with 'categoryOption'
                      //TODO USE PROVIDER FOR  'categoryOption'

                      _selectedOption(optionsList, index);
                    });
                  },
                );
              },
            ),
          ),
          _swapDeals(),
          _productList1(),
          _productList2(),
        ],
      ),
    );
  }

  _swapDeals() => Container(
        //height: 85,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For Your Interests',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  interestsContainer(
                      text: 'Swap for grade A',
                      colors: Color(0xffD1DAEE),
                      textColor: Color(0xff527EA5),
                      imageLink: 'images/interests/laptop.jpg'),
                  SizedBox(
                    width: 6.0,
                  ),
                  interestsContainer(
                      text: 'Your swap deals',
                      colors: Color(0xffCED2F2),
                      textColor: Color(0xff625BC0),
                      imageLink: 'images/interests/laptop2.jpeg'),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  interestsContainer(
                      text: 'Pay in installments',
                      colors: Color(0xffC9F1ED),
                      textColor: Color(0xff39A9AF),
                      imageLink: 'images/interests/laptop3.jpeg'),
                  SizedBox(
                    width: 6.0,
                  ),
                  interestsContainer(
                      text: 'Swap for grade B',
                      colors: Color(0xffFCEAC9),
                      textColor: Color(0xffAD8245),
                      imageLink: 'images/interests/speaker.jpg'),
                ],
              )
            ],
          ),
        ),
      );

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
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/banners/banner3.png'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 50.0,
                    child: RotateAnimatedTextKit(
                        repeatForever: true,
                        text: ["Friendly Prices", "Top Brands", "Best Offers"],
                        textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                blurRadius: 8.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                blurRadius: 8.0,
                                color: kColorRed,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                            fontFamily: "Horizon",
                            color: Colors.white),
                        textAlign: TextAlign.start),
                  )
                ],
              )),
          //Grid view
          Container(
            height: MediaQuery.of(context).size.height / 1.3,
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
            height: MediaQuery.of(context).size.height / 1.3,
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
    if (optList[optIndex].caption == 'Shoes') {
      categoryOption = Options.SHOES;
    }
    if (optList[optIndex].caption == 'Men') {
      categoryOption = Options.MEN;
    }
    if (optList[optIndex].caption == 'Women') {
      categoryOption = Options.WOMEN;
    }
    if (optList[optIndex].caption == 'Tech') {
      categoryOption = Options.TECH;
    }
    if (optList[optIndex].caption == 'Jewelries') {
      categoryOption = Options.JEWELRY;
    }
  }
}

//Text(
//'Shopla',
//style: TextStyle(
//color: Colors.black54,
//fontWeight: FontWeight.w900,
//fontFamily: 'Poppins',
//fontSize: 24.0,
//fontStyle: FontStyle.italic),
//)
