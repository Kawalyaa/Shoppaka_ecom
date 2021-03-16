import 'package:ecommerce_app/model/categary_options.dart';

class AppData {
  static List<CategoryOptions> categoryOptionList = [
    CategoryOptions(
      caption: 'All',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/shoes.png',
      caption: 'Shoes',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/jeans.png',
      caption: 'Men',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/dress.png',
      caption: 'Women',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/iphone.png',
      caption: 'Tech',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/necklace.png',
      caption: 'Jewelries',
    ),
  ];
}
