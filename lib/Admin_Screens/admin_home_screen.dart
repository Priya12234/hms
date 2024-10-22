import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

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
      ),
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
              const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ),
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const AdminHomePage());
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Home',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AdminHome(),
    );
  }
}

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // Controllers for the text fields
  final _breakfastController = TextEditingController();
  final _lunchController = TextEditingController();
  final _snacksController = TextEditingController();
  final _dinnerController = TextEditingController();

  // Function to upload menu data to Firestore
  Future<void> uploadMenu() async {
    await FirebaseFirestore.instance.collection('admin_food_menu').add({
      'breakfast': _breakfastController.text,
      'lunch': _lunchController.text,
      'snacks': _snacksController.text,
      'dinner': _dinnerController.text,
      'timestamp': FieldValue.serverTimestamp(), // Add timestamp if needed
    });

    // Clear the text fields after uploading
    _breakfastController.clear();
    _lunchController.clear();
    _snacksController.clear();
    _dinnerController.clear();

    // Show a snackbar or some message to confirm upload
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menu uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4EC),
      appBar: CustomAppBar(
        title: 'Welcome!',
        onProfilePressed: () {
          // Add your profile action here
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Menu",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: buildMenuCard('Breakfast', _breakfastController),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildMenuCard('Lunch', _lunchController),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: buildMenuCard('Snacks', _snacksController),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildMenuCard('Dinner', _dinnerController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: uploadMenu, // Call uploadMenu on button press
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3D6257),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'UPLOAD',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuCard(String mealType, TextEditingController controller) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF3D6257),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$mealType:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextField(
                  controller: controller, // Use the appropriate controller
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter $mealType menu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildComplaintCard(String complaint, String dateTime) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF3D6257),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              complaint,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dateTime,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
