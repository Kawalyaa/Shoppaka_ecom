import 'package:ecommerce_app/model/categary_options.dart';
import 'package:ecommerce_app/model/image_card_model.dart';

class AppData<T> {
  static List<CategoryOptions> categoryOptionsList = [
    CategoryOptions(
      caption: 'All',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/iphone.png',
      caption: 'Phones',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/budget.jpeg',
      caption: 'Budget',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/used.jpeg',
      caption: 'Used',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/earphone.jpg',
      caption: 'Earphones',
    ),
    CategoryOptions(
      imageLocation: 'images/categories_icons/charger.jpg',
      caption: 'Chargers+',
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
