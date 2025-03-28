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

        // ✅ **StreamBuilder for Live Auth State**
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            User? user = snapshot.data;

            if (user == null) {
              return TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text("Sign Up / Login", style: TextStyle(color: Colors.white)),
              );
            }

            // ✅ **Firestore FutureBuilder for Username Fetch**
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('Users').doc(user.uid).get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return _buildProfileMenu(context, user, "User");
                }

                // ✅ **Username Fetch Properly**
                String username = snapshot.data!.get('username') ?? "User";
                return _buildProfileMenu(context, user, username);
              },
            );
          },
        ),
      ],
    );
  }

  // ✅ **Profile Dropdown Menu**
  Widget _buildProfileMenu(BuildContext context, User user, String username) {
    return PopupMenuButton<int>(
      icon: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(username.isNotEmpty ? username[0].toUpperCase() : "U"), // ✅ First letter of Username
      ),
      onSelected: (value) async {
        if (value == 1) {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: TextStyle(fontWeight: FontWeight.bold)), // ✅ Show username only
              Text(user.email ?? "", style: TextStyle(fontSize: 12, color: Colors.grey)), // ✅ Show email only
              Divider(),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text("Logout", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
