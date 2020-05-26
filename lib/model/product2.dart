class Products2 {
  static const ID = 'id';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const BRAND = 'brand';
  static const IMAGES = 'images';
  static const CATEGORY = 'category';
  static const OLD_PRICE = 'oldPrice';
  static const COLORS = 'colors';
  static const SIZES = 'size';
  static const QUANTITY = 'quantity';
  static const FAVORITE = 'favorite';
  static const FEATURED = 'featured';

  final String id;
  final String name;
  final String brand;
  final String category;
  final images;
  final double price;
  final double oldPrice;
  final int quantity;
  final List colors;
  final List sizes;
  bool favorite;
  final bool featured;

  Products2({
    this.id,
    this.name,
    this.brand,
    this.category,
    this.images,
    this.price,
    this.oldPrice,
    this.quantity,
    this.colors,
    this.sizes,
    this.favorite,
    this.featured,
  });

  factory Products2.fromSnapShot(Map data) {
    return Products2(
      id: data[ID] ?? '',
      name: data[NAME] ?? '',
      brand: data[BRAND] ?? '',
      category: data[CATEGORY] ?? '',
      images: data[IMAGES] ?? [],
      price: data[PRICE] ?? 0,
      oldPrice: data[OLD_PRICE] ?? 0,
      quantity: data[QUANTITY] ?? 0,
      colors: data[COLORS] ?? [],
      sizes: data[SIZES] ?? [],
      favorite: data[FAVORITE] ?? false,
      featured: data[FEATURED] ?? false,
    );
  }
}
