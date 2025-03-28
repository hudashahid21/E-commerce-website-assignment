class CartItem {
  String title;
  String imageUrl;
  double price;
  int quantity;

  CartItem({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}
