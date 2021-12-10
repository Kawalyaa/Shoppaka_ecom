import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductImageSlider extends StatefulWidget {
  final List imageList;
  ProductImageSlider({this.imageList});
  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 276.0,
                autoPlay: true,
                reverse: false,
                initialPage: _currentIndex,
                autoPlayInterval: Duration(seconds: 10),
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: Duration(seconds: 2),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal),
            items: widget.imageList
                .map(
                  (image) => _singleCard(image: image),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imageList.length,
              (index) => _currentIndex == index ? _activeDot() : _inactiveDot(),
            ),
          )
        ],
      ),
    );
  }

  Widget _singleCard({String image}) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: FadeInImage.assetNetwork(
              image: image,
              placeholder: 'images/loading_gif/Spin-1s-200px.gif',
              fit: BoxFit.cover,
              imageErrorBuilder: (context, url, error) => Icon(
                    Icons.error,
                  )),
        ),
      );

  Widget _activeDot() => Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 20,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
      ));

  Widget _inactiveDot() => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 8,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
}
