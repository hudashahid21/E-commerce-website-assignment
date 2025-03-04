import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: user != null
            ? [
                PopupMenuButton(
                  icon: CircleAvatar(
                    child: Text(user!.email![0].toUpperCase()), // First letter of email
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(child: Text("Username: ${user!.email}")),
                    PopupMenuItem(
                      child: ListTile(
                        title: Text("Logout"),
                        onTap: _logout,
                      ),
                    ),
                  ],
                ),
              ]
            : [],
      ),
      body: Center(
        child: Text("Welcome to Home Page"),
      ),
    );
  }
}
