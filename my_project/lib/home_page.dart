import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'assets/images/sale.jpg',
    'assets/images/beauty.jpg',
    'assets/images/nykaa.png',
    'assets/images/skin.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),  // ✅ Now using reusable Navbar
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),

            // SLIDER WITH BETTER SIZING & FIT
            CarouselSlider(
              options: CarouselOptions(
                height: 360, // Increased height for better visibility
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.95,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
              ),
              items: images.map((item) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 30),

            // BEAUTY SALE SECTION
            Text("MAKEUP SALE", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Discover the best deals on top makeup products! Up to 50% off on selected items.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 40),

            // SKIN CARE SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/skin-care.jpg',
                      fit: BoxFit.cover,
                      height: 220,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Skin Care",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Explore our range of skin care products designed to rejuvenate and nourish your skin. "
                          "From cleansers to moisturizers, find what suits your skin type best.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),

      // FOOTER SECTION
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("LuxeSkin & Beauty", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Contact: +1 234 567 890", style: TextStyle(color: Colors.white)),
            Text("Email: support@LuxeSkin.com", style: TextStyle(color: Colors.white)),
            Text("Privacy Policy | Terms of Service", style: TextStyle(color: Colors.white)),
            Text("© 2025 All Rights Reserved", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
