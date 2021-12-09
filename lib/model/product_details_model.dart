import 'package:ecommerce_app/model/products_model.dart';

class ProductDetailsModel {
  final productDetailsName;
  final List productDetailsPicture;
  final productDetailsPrice;
  final productDetailsOldPrice;
  final productBrand;
  final List productSizes;
  final List productColors;
  final String category;
  final String heroTag;
  final List<ProductsModel> similarProd;
  bool isFavorite;
  ProductDetailsModel(
      {this.productDetailsPicture,
      this.heroTag,
      this.productDetailsName,
      this.productDetailsOldPrice,
      this.productDetailsPrice,
      this.productBrand,
      this.productSizes,
      this.productColors,
      this.isFavorite,
      this.category,
      this.similarProd});
}
