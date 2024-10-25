import 'package:flutter/material.dart';
import 'package:hms/Screens/drawer_screen.dart';
import 'package:hms/Screens/home_screen.dart';

void main() {
  runApp(const ContactPageApp());
}

class ContactPageApp extends StatelessWidget {
  const ContactPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ContactPage(),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(firstName: '',), // Custom drawer with navigation

      backgroundColor: const Color(0xFFE6F4EC),
      appBar: CustomAppBar(
        title: "Contact Page",
        onProfilePressed: () {
          // Handle profile button press
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(firstName: '',)), // Example navigation
          );
        },
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/contact_support.png'), // Correct path to your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 28),
                        SizedBox(width: 10),
                        Text(
                          '+91 9635865475',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.email, size: 28), // Updated to email icon
                        SizedBox(width: 10),
                        Text(
                          'support@example.com', // Example email
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        'Thank you!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom AppBar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onProfilePressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 16,
        right: 16,
      ), // Padding for status bar and content
      decoration: const BoxDecoration(
        color: Color(0xFF33665A), // Background color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and profile button in the header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ), // Menu icon
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: onProfilePressed,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Title with "Exit Pass Form"
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
