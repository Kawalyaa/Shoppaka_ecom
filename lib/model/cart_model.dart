class CartModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final List images;
  final double price;
  final double oldPrice;
  final bool favorite;
  final bool featured;
  final String selectedSize;
  final String selectedColor;
  int qty;

  CartModel({
    this.id,
    this.name,
    this.qty = 1,
    this.brand,
    this.category,
    this.images,
    this.price,
    this.oldPrice,
    this.favorite,
    this.featured,
    this.selectedSize,
    this.selectedColor,
  });

  Map toJson() => {
        'id': id,
        'name': name,
        'qty': 1,
        'brand': brand,
        'category': category,
        'images': images,
        'price': price,
        'oldPrice': oldPrice,
        'favorite': favorite,
        'featured': featured,
        'selectedSize': selectedSize,
        'selectedColor': selectedColor,
      };

  CartModel.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        qty = json['qty'],
        brand = json['brand'],
        category = json['category'],
        images = json['images'],
        price = json['price'],
        oldPrice = json['oldPrice'],
        favorite = json['favorite'],
        featured = json['featured'],
        selectedColor = json['selectedColor'],
        selectedSize = json['selectedSize'];


  Map<String,dynamic> toMap()=>{
    'id': id,
    'name': name,
    'qty': 1,
    'brand': brand,
    'category': category,
    'images': images,
    'price': price,
    'oldPrice': oldPrice,
    'favorite': favorite,
    'featured': featured,
    'selectedSize': selectedSize,
    'selectedColor': selectedColor,
  };

}
