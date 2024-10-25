import 'package:flutter/material.dart';
import 'package:hms/Admin_Screens/admin_home_screen.dart';
import 'package:hms/Admin_Screens/admin_student_details.dart';

class AdminCustomDrawer extends StatelessWidget {
  const AdminCustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF33665A),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome Admin!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigate to Home screen
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminHome()), // Navigate directly to AdminHome
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.table_rows),
            title: const Text('Students Details'),
            onTap: () {
              // Navigate to Settings screen
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminStudentDetails()), // Navigate directly to SettingsScreen
              );
            },
          ),
          // Add more drawer items with direct navigation as needed
        ],
      ),
    );
  }
}
