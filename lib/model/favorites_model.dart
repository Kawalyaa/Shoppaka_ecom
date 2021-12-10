class FavoritesModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final List images;
  final int price;
  final int oldPrice;
  final bool favorite;
  final bool featured;
  final List selectedSize;
  final List selectedColor;
  final String color;
  final List description;
  final List keyFeatures;
  int qty;

  FavoritesModel({
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
    this.color,
    this.description,
    this.keyFeatures,
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
        'color': color,
        'description': description,
        'keyFeatures': keyFeatures,
      };

  FavoritesModel.fromJson(Map json)
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
        selectedSize = json['selectedSize'],
        description = json['description'],
        keyFeatures = json['keyFeatures'],
        color = json['color'];

  Map<String, dynamic> toMap() => {
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
        'color': color,
        'description': description,
        'keyFeatures': keyFeatures,
      };
}
