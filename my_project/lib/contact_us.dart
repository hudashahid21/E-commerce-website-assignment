import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contact Us", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/contact.jpg',
                  height: 220, // Adjusted height
                  width: double.infinity, // Full width
                  fit: BoxFit.cover, // Covers area properly
                ),
              ),
              SizedBox(height: 15),

              // Form Heading
              Center(
                child: Text(
                  "Get in Touch",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 12),

              // Contact Form
              Container(
                width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person, size: 22), // Adjusted icon size
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your name" : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Contact Number",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone, size: 22), // Adjusted icon size
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your contact number" : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Message",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.message, size: 22), // Adjusted icon size
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your message" : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Message Sent Successfully!")),
                            );
                          }
                        },
                        child: Text("Send", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Contact Information
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Our Contact Information",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(top: 4), // Adjusted spacing
                          child: Icon(Icons.phone, color: Colors.black, size: 24),
                        ),
                        title: Text("+1 234 567 890", style: TextStyle(fontSize: 16)),
                      ),
                      ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(top: 4), // Adjusted spacing
                          child: Icon(Icons.email, color: Colors.black, size: 24),
                        ),
                        title: Text("support@ecommerce.com", style: TextStyle(fontSize: 16)),
                      ),
                      ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(top: 4), // Adjusted spacing
                          child: Icon(Icons.location_on, color: Colors.black, size: 24),
                        ),
                        title: Text("123 Main Street, New York, USA", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
