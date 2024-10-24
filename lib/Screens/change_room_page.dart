import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/Screens/drawer_screen.dart';

// HeaderWidget Class Definition
class HeaderWidget extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback onRightIconPressed;
  final VoidCallback onLeftIconPressed;

  const HeaderWidget({
    super.key,
    required this.title,
    this.leftIcon = Icons.menu,
    this.rightIcon = Icons.person,
    required this.onRightIconPressed,
    required this.onLeftIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 16,
        right: 16,
      ), // Padding for status bar and content
      decoration: const BoxDecoration(
        color: Color(0xFF33665A), // Background color
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
              IconButton(
                icon: Icon(
                  leftIcon,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: onLeftIconPressed,
              ),
              IconButton(
                icon: Icon(
                  rightIcon,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: onRightIconPressed,
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
}

// ChangeRoomPage Class Definition
class ChangeRoomPage extends StatefulWidget {
  const ChangeRoomPage({super.key});

  @override
  _ChangeRoomPageState createState() => _ChangeRoomPageState();
}

class _ChangeRoomPageState extends State<ChangeRoomPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // GlobalKey for Scaffold
  final TextEditingController currentRoomController = TextEditingController();
  final TextEditingController currentBuildingController =
      TextEditingController();
  final TextEditingController newRoomController = TextEditingController();
  final TextEditingController newBuildingController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitRoomChangeRequest() async {
    if (currentRoomController.text.isEmpty ||
        currentBuildingController.text.isEmpty ||
        newRoomController.text.isEmpty ||
        newBuildingController.text.isEmpty ||
        reasonController.text.isEmpty) {
      // Show an error if fields are missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    try {
      // Add room change request data to Firestore with the correct collection name
      await _firestore.collection('room_change_request').add({
        'currentRoom': currentRoomController.text,
        'currentBuilding': currentBuildingController.text,
        'newRoom': newRoomController.text,
        'newBuilding': newBuildingController.text,
        'reason': reasonController.text,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      });

      // Clear the form after submission
      currentRoomController.clear();
      currentBuildingController.clear();
      newRoomController.clear();
      newBuildingController.clear();
      reasonController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Room change request submitted')),
      );
    } catch (e) {
      // Show error message if submission fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey
      drawer: const CustomNavigationBar(
          firstName: "your firstname"), // Custom drawer with navigation

      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(150), // Adjust the height of the header
        child: HeaderWidget(
          title: 'Change Room',
          leftIcon: Icons.menu,
          rightIcon: Icons.person,
          onLeftIconPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
          onRightIconPressed: () {
            // Handle profile icon press
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Building name\nand Room no.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: currentRoomController,
                      decoration: InputDecoration(
                        labelText: 'Room No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: currentBuildingController,
                      decoration: InputDecoration(
                        labelText: 'Building',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Shift to Building name\nand Room no.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: newRoomController,
                      decoration: InputDecoration(
                        labelText: 'Room No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: newBuildingController,
                      decoration: InputDecoration(
                        labelText: 'Building',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Reason',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: reasonController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter the reason for changing the room',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 50), // Increase space above button
              Center(
                child: ElevatedButton(
                  onPressed: submitRoomChangeRequest, // Submit the request
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF33665A), // Set the button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12), // Adjust padding
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white), // Set your desired color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeRoomPage(),
  ));
}
