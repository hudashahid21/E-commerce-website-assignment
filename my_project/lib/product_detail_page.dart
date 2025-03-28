import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'login.dart';

class ProductDetailPage extends StatelessWidget {
  final String title, description, imageUrl;
  final double price;

  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(redirectTo: 'product_detail', productTitle: title), // ✅ Fixed
      ),
    ).then((value) {
      if (value == title) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              title: title,
              description: description,
              price: price,
              imageUrl: imageUrl,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Image on Left Side
            Image.network(imageUrl, width: 200, height: 200, fit: BoxFit.cover),

            SizedBox(width: 20),

            // ✅ Product Details on Right Side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(description, style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 10),
                  Text("\$${price.toStringAsFixed(2)}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                  SizedBox(height: 20),
                  
                  // ✅ "Add to Cart" Button (Login Check)
                  user == null
                      ? ElevatedButton.icon(
                          onPressed: () => navigateToLogin(context),
                          icon: Icon(Icons.shopping_cart),
                          label: Text("Add to Cart"),
                        )
                      : Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            final cartItem = cartProvider.getCartItem(title);
                            if (cartItem == null) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  cartProvider.addToCart(
                                    CartItem(title: title, price: price, imageUrl: imageUrl, quantity: 1),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to cart!")));
                                },
                                icon: Icon(Icons.shopping_cart),
                                label: Text("Add to Cart"),
                              );
                            }
                            return Row(
                              children: [
                                IconButton(icon: Icon(Icons.remove), onPressed: () => cartProvider.decreaseQuantity(cartItem)),
                                Text("${cartItem.quantity}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                IconButton(icon: Icon(Icons.add), onPressed: () => cartProvider.increaseQuantity(cartItem)),
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
