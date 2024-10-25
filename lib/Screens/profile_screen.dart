import 'package:flutter/material.dart';
import 'package:hms/Screens/drawer_screen.dart';
import 'package:hms/Screens/header_widget.dart'; // Import the header widget

class ProfilePage extends StatelessWidget {
  final String firstName;

  const ProfilePage({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(firstName: firstName), // Custom drawer with navigation
      backgroundColor: const Color(0xFFE6F4EC), // Light background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderWidget(title: 'Your Profile',), // Use HeaderWidget here
              const SizedBox(height: 16),
              const SizedBox(height: 30),
              buildInfoRow('Room No.', '101'),
              buildDivider(),
              buildInfoRow('Building Name', 'A'),
              buildDivider(),
              buildInfoRow('Branch', 'B.Tech'),
              buildDivider(),
              buildInfoRow('DOB', '23/8/2004'),
              buildDivider(),
              buildInfoRow('Contact', '8563298745'),
              buildDivider(),
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.black),
                title: const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Add your password change action here
                },
              ),
              buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label :',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: Colors.teal,
      thickness: 1.0,
      height: 20,
    );
  }
}
