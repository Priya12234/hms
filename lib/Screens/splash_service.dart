import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  // Method to initialize Firebase and load preferences
  Future<void> init(BuildContext context) async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Load shared preferences
      final prefs = await SharedPreferences.getInstance();

      // Check if user is logged in and direct accordingly
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      // Simulate some additional loading time
      await Future.delayed(const Duration(seconds: 3));

      // Decide the initial route based on the login status
      if (isLoggedIn) {
        // Navigate to the home screen if already logged in
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Navigate to the login screen if not logged in
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      // Handle errors during initialization
      debugPrint('Initialization failed: $e');
      // Show error and retry mechanism
      _showErrorDialog(context, "Initialization Error",
          "Failed to initialize the application properly. Please try again.");
    }
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                init(context); // Retry initialization
              },
            ),
          ],
        );
      },
    );
  }
}
