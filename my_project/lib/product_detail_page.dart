import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project/signup.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Product Image with Adjusted Dimensions
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.38, // 🔥 Slightly Wider
                  height: 500, // 🔥 Increased Height for Balance
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 25), // 🔥 Extra Space for Better Separation

            // ✅ Right Side (Details)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, // 🔥 Center Align Content
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // ✅ Description with Wrapping
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                    maxLines: 5, // 🔥 Prevent Overflow
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // ✅ Price Aligned Neatly
                  Text(
                    "\$${widget.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 30),

                  // ✅ Cart Button or Quantity Adjuster (Properly Positioned)
                  FirebaseAuth.instance.currentUser == null
                      ? SizedBox(
                          width: 200, // 🔥 Proper Width for Better UI
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Redirect to Signup/Login page if not logged in
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text("Add to Cart"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      : Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            final index = cartProvider.cartItems.indexWhere((item) => item.title == widget.title);
                            return index == -1
                                ? SizedBox(
                                    width: 200, // 🔥 Keep Width Consistent
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        cartProvider.addToCart(widget.title, widget.price, widget.imageUrl);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Item added to cart!")),
                                        );
                                      },
                                      icon: const Icon(Icons.shopping_cart),
                                      label: const Text("Add to Cart"),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        textStyle: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () => cartProvider.decreaseQuantity(index),
                                      ),
                                      Text(
                                        "${cartProvider.cartItems[index].quantity}",
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
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
