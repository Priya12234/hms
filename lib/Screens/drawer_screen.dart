import 'package:flutter/material.dart';
import 'package:hms/Admin_Screens/admin_exitpss_request.dart';
import 'package:hms/Admin_Screens/admin_home_screen.dart';
import 'package:hms/Admin_Screens/admin_student_fees_details.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required String firstName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF3D6257), // Dark green background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3D6257), // Match background color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home,
                      color: Color(0xFF3D6257),
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text('Dashboard',
                  style: TextStyle(color: Colors.white)),
              selectedTileColor: Colors.grey.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AdminHomePage(), // Use the variable here
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.white),
              title: const Text('Student details',
                  style: TextStyle(color: Colors.white)),
              selectedTileColor: Colors.grey.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on, color: Colors.white),
              title: const Text('Fee Details',
                  style: TextStyle(color: Colors.white)),
              selectedTileColor: Colors.grey.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminFeesDetails()),
                );
              },
            ),

            const Spacer(), // Pushes the logout button to the bottom
          ],
        ),
      ),
    );
  }
}
