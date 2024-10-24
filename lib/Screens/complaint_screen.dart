import 'package:flutter/material.dart';
import 'package:hms/Screens/complaintform_page.dart';
import 'package:hms/Screens/drawer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Management System',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ComplaintMenuPage(), // Set the initial page to ComplaintMenuPage
    );
  }
}

class ComplaintMenuPage extends StatelessWidget {
  const ComplaintMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationBar(
          firstName: "your firstname"), // Custom drawer with navigation

      body: Column(
        children: [
          HeaderWidget(
            title: 'Complaint',
            leftIcon: Icons.menu,
            rightIcon: Icons.person,
            onRightIconPressed: () {
              // Handle right icon press here (e.g., navigate to a profile page)
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: ComplaintItem(
                            iconPath: 'assets/images/food.png',
                            title: 'FOOD',
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 2,
                          color: const Color(0xFF3D6257),
                        ),
                        const Expanded(
                          child: ComplaintItem(
                            iconPath: 'assets/images/laundry.png',
                            title: 'Laundry',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: const Color(0xFF3D6257),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: ComplaintItem(
                            iconPath: 'assets/images/wifi.png',
                            title: 'Wifi',
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 2,
                          color: const Color(0xFF3D6257),
                        ),
                        const Expanded(
                          child: ComplaintItem(
                            iconPath: 'assets/images/electric.png',
                            title: 'Electric',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: const Color(0xFF3D6257),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: ComplaintItem(
                            iconPath: 'assets/images/clean.png',
                            title: 'Cleaning',
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 2,
                          color: const Color(0xFF3D6257),
                        ),
                        const Expanded(
                          child: ComplaintItem(
                            iconPath: 'assets/images/watertap.png',
                            title: 'Water',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComplaintItem extends StatelessWidget {
  final String iconPath;
  final String title;

  const ComplaintItem({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ComplaintFormPage(),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D6257),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback onRightIconPressed;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.leftIcon,
    required this.rightIcon,
    required this.onRightIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF3D6257), // Header background color
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(leftIcon, color: Colors.white),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(rightIcon, color: Colors.white),
            onPressed: onRightIconPressed,
          ),
        ],
      ),
    );
  }
}
