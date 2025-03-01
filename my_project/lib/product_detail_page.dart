import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; // Default quantity

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image on the Left
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/placeholder.png',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 20),

            // Product Details on the Right
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "\$${widget.price}",
                    style: TextStyle(fontSize: 22, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // Quantity Selector
                  Row(
                    children: [
                      IconButton(
                        onPressed: decreaseQuantity,
                        icon: Icon(Icons.remove_circle_outline, color: Colors.black),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: increaseQuantity,
                        icon: Icon(Icons.add_circle_outline, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Add to Cart Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add to cart logic here
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
