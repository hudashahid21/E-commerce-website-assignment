import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white), // ✅ Fixes back icon color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Our E-Commerce App",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to our e-commerce platform! We bring you the best products at the best prices. "
                "Our mission is to make online shopping easy, fast, and secure. We offer a wide range of beauty, "
                "skin care, and lifestyle products to suit all your needs.",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/about.jpg',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Makeup & Beauty",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Explore the best makeup and beauty products. Our collection includes top brands that enhance "
                "your natural beauty and keep your skin flawless all day long.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/about1.jpg',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Skin Care",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Our skincare range is designed to rejuvenate and nourish your skin. From cleansers to "
                "moisturizers, find the perfect match for your skin type and glow with confidence!",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Why Choose Us?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "✔ Best Quality Products\n"
                "✔ Fast & Secure Delivery\n"
                "✔ 24/7 Customer Support\n"
                "✔ Exclusive Discounts & Offers",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
