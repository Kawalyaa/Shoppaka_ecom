import 'package:ecommerce_app/app_data/app_data.dart';
import 'package:ecommerce_app/componants/featured_category.dart';
import 'package:ecommerce_app/componants/original_product_section.dart';
import 'package:ecommerce_app/componants/jewelries_category.dart';
import 'package:ecommerce_app/componants/men_category.dart';
import 'package:ecommerce_app/componants/featured_section.dart';
import 'package:ecommerce_app/componants/shoes_category.dart';
import 'package:ecommerce_app/componants/tech_category.dart';
import 'package:ecommerce_app/componants/women_category.dart';
import 'package:ecommerce_app/db/databse_services.dart';
import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/componants/products.dart';
import 'package:ecommerce_app/componants/category_option_detail.dart';
import 'package:ecommerce_app/componants/image_carousel.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/componants/navigation_drawer.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //FirebaseFirestore
  TextEditingController _searchController = TextEditingController();
  int selectedIndex;
  List<CategoryOptions> optionsList = AppData.categoryOptionList;
  Options categoryOption = Options.FEATURED;
  UserServices _userServices = UserServices();
  DatabaseServices _services = DatabaseServices();
  var userInfo;
  String _userName;
  String _userEmail;
  String _photoUrl;
  String _userId;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider2>(context);
    List<UserModel> userInfo = Provider.of<List<UserModel>>(context);
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
          ImageCarousel(), //Image carousel

          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              top: 20,
            ),
            child: Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
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
                  imageCaption: optionsList[index].imageCaption,
                  imageLocation: optionsList[index].imageLocation,
                  isSelected: selectedIndex == index,
                  onSelected: () {
                    setState(() {
                      selectedIndex = index;

                      _selectedOption(optionsList, index);
                    });
                  },
                );
              },
            ),
          ),
          // _productOptions()
          _swapDeals(),
          _productList1(),
          _productList2(),
          //Container(height: 800, child: Products()),
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
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  interestsContainer(
                      text: 'Swap for grade A',
                      colors: Color(0xffD1DAEE),
                      textColor: Color(0xff527EA5),
                      imageLink: 'images/banners/banner.jpg'),
                  SizedBox(
                    width: 6.0,
                  ),
                  interestsContainer(
                      text: 'Your swap deals',
                      colors: Color(0xffCED2F2),
                      textColor: Color(0xff625BC0),
                      imageLink: 'images/banners/banner.jpg'),
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
                      imageLink: 'images/banners/banner.jpg'),
                  SizedBox(
                    width: 6.0,
                  ),
                  interestsContainer(
                      text: 'Swap for grade B',
                      colors: Color(0xffFCEAC9),
                      textColor: Color(0xffAD8245),
                      imageLink: 'images/banners/banner.jpg'),
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
                        image: AssetImage('images/banners/banner.jpg'),
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
                  Positioned(
                    top: 10,
                    left: 110,
                    child: Text(
                      'Friedly Prices',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )),
          //Grid view
          Container(
            height: MediaQuery.of(context).size.height / 1.3,
            child: FeaturedSection(),
          ),
        ],
      );

  _productList2() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Padding(
//              padding: EdgeInsets.all(8.0),
//              child: Stack(
//                children: [
//                  Container(
//                    height: 55.0,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.only(
//                          topRight: Radius.circular(30.0),
//                          topLeft: Radius.circular(30.0),
//                          bottomRight: Radius.circular(10.0),
//                          bottomLeft: Radius.circular(10.0)),
//                      color: Colors.deepOrange,
//                    ),
//                  ),
//                  Container(
//                    height: 50,
//                    width: MediaQuery.of(context).size.width,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(30.0),
//                      image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage('images/banners/banner2.jpeg'),
//                      ),
//                    ),
//                  ),
//                  Positioned(
//                    top: 10,
//                    left: 50,
//                    child: Text(
//                      'Just for your!',
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 24.0,
//                          fontWeight: FontWeight.w900,
//                          fontStyle: FontStyle.italic),
//                    ),
//                  )
//                ],
//              )),
          //Grid view
          Container(
            height: MediaQuery.of(context).size.height / 1.3,
            child: OriginalProductSection(),
          ),
        ],
      );

//  _productOptions() {
//    switch (categoryOption) {
//      case Options.FEATURED:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//                padding: EdgeInsets.all(8.0),
//                child: Stack(
//                  children: [
//                    Container(
//                      height: 50,
//                      width: MediaQuery.of(context).size.width,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0),
//                        image: DecorationImage(
//                          fit: BoxFit.cover,
//                          image: AssetImage('images/banners/banner.jpg'),
//                        ),
//                      ),
//                    ),
//                    Container(
//                      decoration: BoxDecoration(
//                        color: Colors.black.withOpacity(0.1),
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      height: 50,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Positioned(
//                      top: 10,
//                      left: 110,
//                      child: Text(
//                        'Friedly Prices',
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 24.0,
//                            fontWeight: FontWeight.w900,
//                            fontStyle: FontStyle.italic),
//                      ),
//                    )
//                  ],
//                )),
//            //Grid view
//            Container(
//              height: MediaQuery.of(context).size.height / 1.3,
//              child: FeaturedSection(),
//            ),
//          ],
//        );
//        break;
//
//      case Options.ALL:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(15.0),
//              child: Text(
//                'All Products',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              ),
//            ),
//            //Grid view
//            Container(
//              height: 380,
//              child: Products(),
//            ),
//          ],
//        );
//        break;
//      case Options.SHOES:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(15.0),
//              child: Text(
//                'Shoes',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              ),
//            ),
//            //Grid view
//            Container(
//              height: 550,
//              child: ShoesCategory(),
//            ),
//          ],
//        );
//        break;
//      case Options.MEN:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(15.0),
//              child: Text(
//                'Men',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              ),
//            ),
//            //Grid view
//            Container(
//              height: 380,
//              child: MenCategory(),
//            ),
//          ],
//        );
//        break;
//      case Options.WOMEN:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(15.0),
//              child: Text(
//                'Women',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              ),
//            ),
//            //Grid view
//            Container(
//              height: 380,
//              child: WomenCategory(),
//            ),
//          ],
//        );
//        break;
//      case Options.TECH:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(15.0),
//              child: Text(
//                'Tech',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              ),
//            ),
//            //Grid view
//            Container(
//              height: 380,
//              child: TechCategory(),
//            ),
//          ],
//        );
//        break;
//      case Options.JEWELRY:
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(15.0),
//              child: Text(
//                'Jewelry',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, color: Colors.black54),
//              ),
//            ),
//            //Grid view
//            Container(
//              height: 380,
//              child: JewelriesCategory(),
//            ),
//          ],
//        );
//        break;
//      default:
//        return Container();
//    }
//  }

  _swapCard() {
    return Card(
      child: Stack(children: [Container()]),
    );
  }

  void _selectedOption(List<CategoryOptions> optList, int optIndex) {
    if (optList[optIndex].imageCaption == 'All') {
      categoryOption = Options.ALL;
    }
    if (optList[optIndex].imageCaption == 'Shoes') {
      categoryOption = Options.SHOES;
    }
    if (optList[optIndex].imageCaption == 'Men') {
      categoryOption = Options.MEN;
    }
    if (optList[optIndex].imageCaption == 'Women') {
      categoryOption = Options.WOMEN;
    }
    if (optList[optIndex].imageCaption == 'Tech') {
      categoryOption = Options.TECH;
    }
    if (optList[optIndex].imageCaption == 'Jewelries') {
      categoryOption = Options.JEWELRY;
    }
  }
}
