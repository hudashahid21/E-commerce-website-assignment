import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageProductsPage extends StatefulWidget {
  @override
  _ManageProductsPageState createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  void deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection('Product').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Products')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Product').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                title: Text(document['Title']),
                subtitle: Text(document['Description']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteProduct(document.id),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
