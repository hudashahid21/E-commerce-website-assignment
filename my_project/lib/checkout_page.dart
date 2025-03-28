import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems.values.toList();
    final totalPrice = cartProvider.totalPrice;

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(item.imageUrl, width: 50, height: 50),
                    title: Text(item.title),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Text('Total: \$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Add order placement logic
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
