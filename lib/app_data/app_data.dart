import 'package:ecommerce_app/model/categary_options.dart';

class AppData {
  static List<CategoryOptions> categoryOptionList = [
    CategoryOptions(
      imageCaption: 'All',
    ),
    CategoryOptions(
      imageLocation: 'images/shoes.png',
      imageCaption: 'Shoes',
    ),
    CategoryOptions(
      imageLocation: 'images/jeans.png',
      imageCaption: 'Men',
    ),
    CategoryOptions(
      imageLocation: 'images/dress.png',
      imageCaption: 'Women',
    ),
    CategoryOptions(
      imageLocation: 'images/blazer.png',
      imageCaption: 'Blazers',
    ),
    CategoryOptions(
      imageLocation: 'images/necklace.png',
      imageCaption: 'Jewelries',
    ),
  ];
}
