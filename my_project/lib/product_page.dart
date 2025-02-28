import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {"image": "assets/images/vitaminc.jpg", "name": "Vitamin C Serum", "price": 90},
    {"image": "assets/images/Hyaluronic.jpg", "name": "Hyaluronic Acid Face Serum", "price": 80},
    {"image": "assets/images/primer.jpeg", "name": "Elf Primer", "price": 70},
    {"image": "assets/images/fitme.png", "name": "Fitme Foundation", "price": 90},
    {"image": "assets/images/nars.jpeg", "name": "Nars Face Powder", "price": 95},
    {"image": "assets/images/NYX_BlushCollection.jpg", "name": "NYX Blush Collection", "price": 69},
    {"image": "assets/images/iconic.jpg", "name": "Iconic Illuminator", "price": 60},
    {"image": "assets/images/maybeline.jpg", "name": "Maybelline Mascara", "price": 60},
    {"image": "assets/images/hudabeauty.jpeg", "name": "Huda Beauty Pencil & Eyeliner", "price": 55},
    {"image": "assets/images/eyeshadow.jpg", "name": "Nude Eyeshadow Palette", "price": 75},
    {"image": "assets/images/maclipstick.jpg", "name": "Mac Lipstick", "price": 45},
    {"image": "assets/images/makeupfixer.jpeg", "name": "Lakme Makeup Fixer", "price": 40},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Products",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white), // 🔥 Back Icon ka color white
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // ✅ 3 Cards in one row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7, // Adjust height of cards
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      product["image"],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product["name"],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "\$${product["price"]}",
                    style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
