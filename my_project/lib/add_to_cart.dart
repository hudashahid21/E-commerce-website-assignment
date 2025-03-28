import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addToCart(String productId, String productName, double price, String imageUrl) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("User not logged in!");
    return;
  }

  final cartRef = FirebaseFirestore.instance.collection('cart');
  final existingItem = await cartRef
      .where('userid', isEqualTo: user.uid)
      .where('productid', isEqualTo: productId)
      .get();

  if (existingItem.docs.isEmpty) {
    await cartRef.add({
      'userid': user.uid,
      'productid': productId,
      'productname': productName,
      'price': price,
      'quantity': 1,
      'image': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      print("Product added to cart successfully!");
    }).catchError((error) {
      print("Failed to add product: $error");
    });
  } else {
    final docId = existingItem.docs.first.id;
    int currentQuantity = existingItem.docs.first['quantity'];
    await cartRef.doc(docId).update({'quantity': currentQuantity + 1}).then((value) {
      print("Product quantity updated!");
    }).catchError((error) {
      print("Failed to update product quantity: $error");
    });
  }
}
