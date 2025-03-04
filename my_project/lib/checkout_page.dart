import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: cartProvider.cartItems.map((item) {
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text("\$${item.price.toStringAsFixed(2)} x ${item.quantity}"),
                  );
                }).toList(),
              ),
            ),
            Divider(),
            Text(
              "Total: \$${cartProvider.getTotalPrice().toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order placed successfully!")),
                );
                Navigator.pop(context);
              },
              child: Text("Confirm Order"),
            ),
          ],
        ),
      ),
    );
  }
}
