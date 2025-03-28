import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderListPage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userid', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return Center(child: Text("No orders found"));
          }

          return ListView(
            children: orders.map((order) {
              return ListTile(
                title: Text("Order #${order.id.substring(0, 8)}"),
                subtitle: Text("Total: \$${order['totalPrice']}"),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
