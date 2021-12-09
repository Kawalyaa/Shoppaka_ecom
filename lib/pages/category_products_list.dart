import 'package:ecommerce_app/componants/category_option_detail.dart';
import 'package:ecommerce_app/componants/featured_category.dart';
import 'package:ecommerce_app/componants/jewelries_category.dart';
import 'package:ecommerce_app/componants/men_category.dart';
import 'package:ecommerce_app/componants/products.dart';
import 'package:ecommerce_app/componants/shoes_category.dart';
import 'package:ecommerce_app/componants/tech_category.dart';
import 'package:ecommerce_app/componants/women_category.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class CategoryProductsList extends StatefulWidget {
  static const String id = 'CategoryProductsList';
  @override
  _CategoryProductsListState createState() => _CategoryProductsListState();
}

class _CategoryProductsListState extends State<CategoryProductsList> {
  @override
  Widget build(BuildContext context) {
    ///Extract data from named route
    //var incomingOption = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 50,
                width: 40,
                child: Image.asset(
                  'images/logos/shoplaLogo.png',
                  fit: BoxFit.cover,
                )),
            Text(
              'Shopla',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: _switchSelection(),
    );
  }

  _switchSelection() {
    switch (categoryOption) {
      //case Options.ALL:
      // case Options.FEATURED:
      case Options.ALL:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'All Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              padding: EdgeInsets.only(bottom: 2.0),
              height: MediaQuery.of(context).size.height - 130,
              child: Products(),
            ),
          ],
        );
        break;

      case Options.SHOES:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Shoes',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              padding: EdgeInsets.only(bottom: 2.0),
              height: MediaQuery.of(context).size.height - 130,
              child: ShoesCategory(),
            ),
          ],
        );
        break;
      case Options.MEN:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Men',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: MenCategory(),
            ),
          ],
        );
        break;
      case Options.WOMEN:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Women',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: WomenCategory(),
            ),
          ],
        );
        break;
      case Options.TECH:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Tech Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: TechCategory(),
            ),
          ],
        );
        break;
      case Options.JEWELRY:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Jewelry',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: JewelriesCategory(),
            ),
          ],
        );
        break;
      case Options.FEATURED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Featured Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: FeaturedCategory(),
            ),
          ],
        );
        break;
      case Options.SORTED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Original Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            //Grid view
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: Products(),
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}
