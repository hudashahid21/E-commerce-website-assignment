import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get cartItems => _items;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addToCart(CartItem item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity++;
    } else {
      _items[item.id] = item;
    }
    _saveCartToFirebase();
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (_items.containsKey(id)) {
      if (_items[id]!.quantity > 1) {
        _items[id]!.quantity--;
      } else {
        removeItem(id);
      }
      _saveCartToFirebase();
      notifyListeners();
    }
  }

  void increaseQuantity(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity++;
      _saveCartToFirebase();
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.remove(id);
    _saveCartToFirebase();
    notifyListeners();
  }

  CartItem? getCartItem(String id) {
    return _items[id];
  }

  void _saveCartToFirebase() {
    final cartCollection = FirebaseFirestore.instance.collection('cart');
    cartCollection.doc('user_cart').set({
      'items': _items.values.map((item) => item.toMap()).toList(),
    });
  }

  void clearCart() {
    _items.clear();
    FirebaseFirestore.instance.collection('cart').doc('user_cart').delete();
    notifyListeners();
  }
}
