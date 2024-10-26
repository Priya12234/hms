import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/Admin_Screens/admin_custom_app_bar.dart';
import 'package:hms/Admin_Screens/admin_custom_drawer.dart';



class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _breakfastController = TextEditingController();
  final _lunchController = TextEditingController();
  final _snacksController = TextEditingController();
  final _dinnerController = TextEditingController();

  Future<void> uploadMenu() async {
    await FirebaseFirestore.instance.collection('admin_food_menu').add({
      'breakfast': _breakfastController.text,
      'lunch': _lunchController.text,
      'snacks': _snacksController.text,
      'dinner': _dinnerController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _breakfastController.clear();
    _lunchController.clear();
    _snacksController.clear();
    _dinnerController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menu uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4EC),
      appBar: AdminCustomAppBar(
        title: 'Welcome Admin!',
        onProfilePressed: () {
          // Profile action
        },
      ),
      drawer: const AdminCustomDrawer(),
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
                  onPressed: uploadMenu,
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
                  controller: controller,
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
}
