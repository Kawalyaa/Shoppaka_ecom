import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Categories(
            imageLocation: 'images/blazer.png',
            imageCaption: 'Blazers',
          ),
          Categories(
            imageLocation: 'images/dress.png',
            imageCaption: 'Dresses',
          ),
          Categories(
            imageLocation: 'images/jacket.png',
            imageCaption: 'Jackets',
          ),
          Categories(
            imageLocation: 'images/jeans.png',
            imageCaption: 'Jeans',
          ),
          Categories(
            imageLocation: 'images/necklace.png',
            imageCaption: 'Jeweries',
          ),
          Categories(
            imageLocation: 'images/shoes.png',
            imageCaption: 'Shoes',
          ),
          Categories(
            imageLocation: 'images/tshirt.png',
            imageCaption: 'Tshirts',
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  Categories({this.imageLocation, this.imageCaption});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              imageLocation,
              height: 80.0,
            ),
            subtitle: Text(
              imageCaption,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
