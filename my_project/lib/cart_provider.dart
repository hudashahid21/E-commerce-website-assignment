import 'package:flutter/material.dart';

class CartItem {
  final String title, imageUrl;
  final double price;
  int quantity;

  CartItem({required this.title, required this.imageUrl, required this.price, required this.quantity});
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  double get totalPrice {
    return _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addToCart(CartItem item) {
    if (_items.containsKey(item.title)) {
      _items[item.title]!.quantity += 1;
    } else {
      _items[item.title] = item;
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item.title);
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    _items[item.title]!.quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (_items[item.title]!.quantity > 1) {
      _items[item.title]!.quantity -= 1;
    } else {
      _items.remove(item.title);
    }
    notifyListeners();
  }

  CartItem? getCartItem(String title) {
    return _items[title];
  }
}
