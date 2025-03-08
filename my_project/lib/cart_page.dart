import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() async {
    QuerySnapshot cartItems = await _firestore.collection('cart').get();
    double total = 0.0;
    for (var doc in cartItems.docs) {
      total += (doc['price'] * doc['quantity']);
    }
    setState(() {
      totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('cart').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                var cartItems = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    var item = cartItems[index];
                    return ListTile(
                      title: Text(item['productname']),
                      subtitle: Text('Quantity: ${item['quantity']}'),
                      trailing: Text('\$${item['price']}'),
                    );
                  },
                );
              },
            ),
          ),
          Text('Total: \$${totalPrice.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(totalPrice: totalPrice),
                ),
              );
            },
            child: Text('Proceed to Checkout'),
          ),
        ],
      ),
    );
  }
}
