import 'package:flutter/material.dart';
import 'add_product_page.dart';
import 'manage_products_page.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Column(
        children: [
          ListTile(
            title: Text('Add Product'),
            trailing: Icon(Icons.add),
            onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProductPage())),
          ),
          ListTile(
            title: Text('Manage Products'),
            trailing: Icon(Icons.list),
            onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageProductsPage())),
          ),
        ],
      ),
    );
  }
}
