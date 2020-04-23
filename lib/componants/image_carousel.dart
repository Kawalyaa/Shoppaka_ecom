import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/carousel/accessories.jpg'),
          AssetImage('images/carousel/blazer.jpg'),
          AssetImage('images/carousel/fashion1.jpg'),
          AssetImage('images/carousel/fashion2.jpg'),
          AssetImage('images/carousel/polka.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 1.0,
        dotBgColor: Colors.transparent,
      ),
    );
  }
}
