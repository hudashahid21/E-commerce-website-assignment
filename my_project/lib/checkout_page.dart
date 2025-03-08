import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final double totalPrice;

  CheckoutPage({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Bill: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // ✅ Back ho jaye, cart delete nahi hoga!
              },
              child: Text('Back to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
