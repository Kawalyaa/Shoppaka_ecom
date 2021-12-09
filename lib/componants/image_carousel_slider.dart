import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/model/image_card_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/db/app_data.dart';

class ImageCarouselSlider extends StatefulWidget {
  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int _currentIndex = 0;
  ImageCardModel _cardModel = ImageCardModel();
  //TODO >>>>>>>>>>>>>>>
  List<ImageCardModel> _cardList = AppData.imageCardList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.0,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 160,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                autoPlay: true,
                reverse: false,
                initialPage: _currentIndex,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal),
            items: _cardList
                .map(
                  (card) => _singleCard(image: card.imageLink),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _cardModel.map<Widget>(
              _cardList,
              (index, item) => Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? kColorRed : Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _singleCard({String image}) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            )),
      );
}
