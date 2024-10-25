import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title; // The title to display

  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF33665A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 30.0),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30.0),
                onPressed: () {
                  // Handle profile button press
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              title, // Display the title dynamically
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
}
