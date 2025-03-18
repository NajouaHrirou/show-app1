import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage("https://i.pravatar.cc/300")),
            SizedBox(height: 20),
            Text("John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("johndoe@email.com", style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
