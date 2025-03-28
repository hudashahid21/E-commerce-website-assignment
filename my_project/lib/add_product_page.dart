import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  CollectionReference products = FirebaseFirestore.instance.collection('products');
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<String> imgUrls = [];
  final ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      if (images.length < 1 || images.length > 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select between 2 and 6 images")),
        );
        return;
      }

      List<String> base64Images = [];
      for (var image in images) {
        final Uint8List byteImage = await image.readAsBytes();
        final String base64img = base64Encode(byteImage);
        base64Images.add(base64img);
      }

      setState(() {
        imgUrls = base64Images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new product"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/add");
            },
          ),
        ],
      ),
   body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Center(
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter the title of the product",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: desController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter the description of the product",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Price",
                hintText: "Enter the price of the product",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            ElevatedButton.icon(
              onPressed: getImage,
              icon: Icon(Icons.upload_file),
              label: Text("Choose Files"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              ),
            ),
            if (imgUrls.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemCount: imgUrls.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        base64Decode(imgUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () async {
                if (imgUrls.length < 3 || imgUrls.length > 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select between 3 and 6 images")),
                  );
                  return;
                }
                
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(child: CircularProgressIndicator()),
                );
                
                try {
                  await products.add({
                    'title': titleController.text,
                    'description': desController.text,
                    'price': double.parse(priceController.text),
                    'images': imgUrls,
                  });
                  Navigator.pop(context);
                  titleController.clear();
                  desController.clear();
                  priceController.clear();
                  setState(() => imgUrls = []);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Product added successfully")),
                  );
                  Navigator.pop(context);
                } catch (error) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add product")),
                  );
                }
              },
              child: Text("Add Product"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

    );
  }
}