import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/image_card_model.dart';

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

  static List<ImageCardModel> imageCardList = [
    ImageCardModel(
      imageLink: 'images/carousel/carouselbanner0001.jpg',
    ),
    ImageCardModel(
      imageLink: 'images/carousel/carouselbanner2.jpg',
    ),
    ImageCardModel(
      imageLink: 'images/carousel/carouselbanner3.jpg',
    ),
    ImageCardModel(
      imageLink: 'images/carousel/carouselbanner4.png',
    ),
    ImageCardModel(
      imageLink: 'images/carousel/carouselbanner5.png',
    ),
  ];
}
