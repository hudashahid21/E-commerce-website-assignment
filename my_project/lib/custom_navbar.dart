import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'signup.dart';

class CustomNavbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomNavbarState createState() => _CustomNavbarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomNavbarState extends State<CustomNavbar> {
  User? user = FirebaseAuth.instance.currentUser;
  String username = "";

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  void fetchUsername() async {
    if (user != null) {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

      setState(() {
        username = userData['username'] ?? ""; // ✅ Fetch username from Firestore
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text("LuxeSkin & Beauty", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/about'),
          child: Text("About Us", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/product'),
          child: Text("Products", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/contact'),
          child: Text("Contact Us", style: TextStyle(color: Colors.white)),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),

        // ✅ Show Profile Icon if Logged In
        user != null
            ? PopupMenuButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(username.isNotEmpty ? username[0].toUpperCase() : "U"),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Username: $username"), // ✅ Show username
                  ),
                  PopupMenuItem(
                    child: Text("Email: ${user!.email}"),
                  ),
                  PopupMenuItem(
                    child: Text("Logout"),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        user = null;
                        username = "";
                      });
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              )
            : TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text("Sign Up / Login", style: TextStyle(color: Colors.white)),
              ),
      ],
    );
  }
}
