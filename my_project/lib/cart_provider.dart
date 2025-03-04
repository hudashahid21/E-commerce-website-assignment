import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(String title, double price, String imageUrl) {
    var existingItem =
        _cartItems.firstWhere((item) => item.title == title, orElse: () => CartItem(title: '', price: 0, imageUrl: ''));

    if (existingItem.title.isNotEmpty) {
      existingItem.quantity++;
    } else {
      _cartItems.add(CartItem(title: title, price: price, imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    return _cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  int getTotalItems() {
    return _cartItems.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
