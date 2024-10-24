import 'package:flutter/material.dart';
import 'package:hms/Screens/drawer_screen.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationBar(
          firstName: "your firstname"), // Custom drawer with navigation

      backgroundColor: const Color(0xFFE6F4EC), // Light background color
      appBar: AppBar(
        toolbarHeight: 120, // Adjust the height for the curve
        backgroundColor:
            const Color(0xFF3D6257), // Dark green color for the header
        automaticallyImplyLeading: false, // Removes default back button
        flexibleSpace: ClipPath(
          clipper: CustomAppBarClipper(),
          child: Container(
            color: const Color(0xFF3D6257),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        // Add your back button action here
                      },
                    ),
                    title: const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/profile_image.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
