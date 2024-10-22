import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/Screens/drawer_screen.dart';

class HomePage extends StatelessWidget {
  final String firstName;

  const HomePage({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(firstName: firstName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String firstName;

  const MyHomePage({super.key, required this.firstName});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Map<String, dynamic>? menuData;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    fetchMenuData();
  }

  Future<void> fetchMenuData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin_food_menu')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          menuData = snapshot.docs.first.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching menu data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationBar(firstName: widget.firstName), // Pass firstName
      body: Column(
        children: [
          Container(
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
                    'Welcome ${widget.firstName}!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Menu",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    menuData == null
                        ? const Center(child: CircularProgressIndicator()) // Show loading spinner
                        : menuData!.isEmpty
                            ? const Center(child: Text("No menu available.")) // No menu available message
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildMenuCard("Breakfast", [menuData!['breakfast']]),
                                  _buildMenuCard("Lunch", [menuData!['lunch']]),
                                ],
                              ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMenuCard("Snacks", [menuData!['snacks']]),
                        _buildMenuCard("Dinner", [menuData!['dinner']]),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Your Recent Complaints",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    _buildComplaintsCard(),
                    const SizedBox(height: 20),
                    _buildExitPassSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String mealType, List<String> items) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF33665A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$mealType:", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(item, style: const TextStyle(color: Colors.white)),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF33665A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Wifi is not working", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            Text("10/8/2024 | 2 pm", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildExitPassSection() {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 8),
            const Text('Go to home'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('7/8/2024/5:30pm'),
                      SizedBox(height: 20),
                      Text('TO', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('10/8/2024/6pm'),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Room no.', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: const Text('303'),
                      ),
                      const SizedBox(height: 20),
                      const Text('Parents permission', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Icon(Icons.check_circle, color: Colors.green, size: 32),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
