import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/product2.dart';

class AppData {
  static List<CategoryOptions> categoryOptionsList = [
    CategoryOptions(
      caption: 'All',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/shoe-icon.jpg',
      caption: 'Shoes',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/men-trouser.png',
      caption: 'Men',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/dress.jpg',
      caption: 'Women',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/iphone.png',
      caption: 'Tech',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/jewelry.jpeg',
      caption: 'Jewelries',
    ),
  ];
}
