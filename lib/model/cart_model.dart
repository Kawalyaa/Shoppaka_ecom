class CartModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final images;
  final double price;
  final double oldPrice;
  final int quantity;
  final bool favorite;
  final bool featured;
  final String selectedSize;
  final String selectedColor;
  final int qty;

  CartModel({
    this.id,
    this.name,
    this.brand,
    this.category,
    this.images,
    this.price,
    this.oldPrice,
    this.quantity,
    this.favorite,
    this.featured,
    this.selectedSize,
    this.selectedColor,
    this.qty,
  });
}
