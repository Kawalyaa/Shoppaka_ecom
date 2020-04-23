import 'product_db.dart';
import 'package:ecommerce_app/model/product.dart';

//*********This code is not used******************

//========can easily  use provider here========
class Services {
  static List<Product> products = [];

  //get products
  Future<Null> getProducts() async {
    await ProductCRUD().allProducts();
  }

  //upload image and get image url
  Future<String> addImageOfProduct(_image, imageName) async {
    String downloadUrl =
        await ProductCRUD().uploadProductImage(_image, imageName);
    return downloadUrl;
  }

  //Fetch image

  //add products
  void addProduct(productData) {
    ProductCRUD().addProduct(productData);
  }
}
