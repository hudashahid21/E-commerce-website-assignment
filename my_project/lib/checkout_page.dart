import 'package:flutter/material.dart';
import 'cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalBill;

  const CheckoutPage({Key? key, required this.cartItems, required this.totalBill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
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
                    leading: Image.network(item.imageUrl, width: 50),
                    title: Text(item.title),
                    subtitle: Text("\$${item.price} x ${item.quantity}"),
                    trailing: Text("\$${(item.price * item.quantity).toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
            Text("Total: \$${totalBill.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle order placement logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order Placed Successfully!")),
                );
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
