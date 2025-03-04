import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: user == null
            ? Text("No user logged in")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name: ${user.displayName ?? 'N/A'}"),
                  Text("Email: ${user.email}"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
      ),
    );
  }
}
