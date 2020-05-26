import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';

class AppData {
  static List<CategoryOptions> categoryOptionList = [
    CategoryOptions(
      imageCaption: 'All',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/shoes.png',
      imageCaption: 'Shoes',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/jeans.png',
      imageCaption: 'Men',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/dress.png',
      imageCaption: 'Women',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/iphone.png',
      imageCaption: 'Tech',
    ),
    CategoryOptions(
      imageLocation: 'images/category_icons/necklace.png',
      imageCaption: 'Jewelries',
    ),
  ];
}
