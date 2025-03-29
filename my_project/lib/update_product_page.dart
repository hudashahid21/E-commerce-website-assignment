import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProductPage extends StatefulWidget {
  final String productId;
  const UpdateProductPage({super.key, required this.productId});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  CollectionReference products = FirebaseFirestore.instance.collection('products');
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? imageUrl;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadProductData();
  }

  Future<void> loadProductData() async {
    DocumentSnapshot product = await products.doc(widget.productId).get();
    if (product.exists) {
      setState(() {
        titleController.text = product['title'];
        desController.text = product['description'];
        priceController.text = product['price'].toString();
        imageUrl = product['image'];
      });
    }
  }

  Future<void> getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List byteImage = await image.readAsBytes();
      setState(() {
        imageUrl = base64Encode(byteImage);
      });
    }
  }

  Future<void> updateProduct() async {
    if (titleController.text.isEmpty ||
        desController.text.isEmpty ||
        priceController.text.isEmpty ||
        imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and select an image")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await products.doc(widget.productId).update({
        'title': titleController.text,
        'description': desController.text,
        'price': double.parse(priceController.text),
        'image': imageUrl,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product updated successfully!")),
      );

      Navigator.pop(context);
    } catch (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update product: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Product Name", border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: desController,
                decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                maxLines: 3,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: getImage,
                  icon: Icon(Icons.upload_file),
                  label: Text("Choose File"),
                ),
              ),
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.memory(
                      base64Decode(imageUrl!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: updateProduct,
                  child: Text("Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
