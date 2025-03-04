import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'auth.dart'; // Ensure this file has the Signup and Login screens

class ProductDetailPage extends StatefulWidget {
  final String title, description, imageUrl;
  final double price;

  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(widget.imageUrl, height: 300, fit: BoxFit.cover),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(widget.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                    "\$${widget.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  FirebaseAuth.instance.currentUser == null
                      ? ElevatedButton.icon(
                          onPressed: () {
                            // Redirect to Signup/Login page if not logged in
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Signup()), // Update as per your Signup/Login page
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text("Add to Cart"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          ),
                        )
                      : Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            final index = cartProvider.cartItems.indexWhere((item) => item.title == widget.title);
                            return index == -1
                                ? ElevatedButton.icon(
                                    onPressed: () {
                                      cartProvider.addToCart(widget.title, widget.price, widget.imageUrl);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Item added to cart!")),
                                      );
                                    },
                                    icon: const Icon(Icons.shopping_cart),
                                    label: const Text("Add to Cart"),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    ),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () => cartProvider.decreaseQuantity(index),
                                      ),
                                      Text("${cartProvider.cartItems[index].quantity}"),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () => cartProvider.increaseQuantity(index),
                                      ),
                                    ],
                                  );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
