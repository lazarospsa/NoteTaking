import 'package:flutter/material.dart';
import '../models/user.dart'; // Import your User model here
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountScreen extends StatelessWidget {
  final User? user; // Pass the user information to the AccountScreen

  AccountScreen({super.key, required this.user});

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              // Display a random icon as the user icon
              radius: 50,
              // Display a random icon as the user icon
              child: Icon(Icons.person),
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: ${user?.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Email: ${user?.email}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Perform logout action
                await storage.delete(key: 'auth'); // Clear authentication token
                Navigator.of(context)
                    .pushReplacementNamed('/login'); // Navigate to login screen
              },
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage in your main.dart or wherever you handle routing:
// MaterialApp(
//   routes: {
//     '/account': (context) => AccountScreen(user: yourUser),
//     // Add other routes...
//   },
//   // Add other MaterialApp configurations...
// );
