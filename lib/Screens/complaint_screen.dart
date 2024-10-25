import 'package:flutter/material.dart';
import 'package:hms/Screens/complaintform_page.dart';
import 'package:hms/Screens/drawer_screen.dart';
import 'package:hms/Screens/header_widget.dart';// Import the HeaderWidget

class ComplaintMenuPage extends StatelessWidget {
  const ComplaintMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(firstName: ""), // Custom drawer with navigation

      body: Column(
        children: [
           const HeaderWidget(title: 'Complaint Menu'),
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
