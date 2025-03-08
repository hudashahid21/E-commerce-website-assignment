import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> clearCart() async {
    var cartCollection = _firestore.collection('cart');
    var snapshots = await cartCollection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
