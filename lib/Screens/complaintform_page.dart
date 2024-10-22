import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HeaderWidget Class Definition
class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback onRightIconPressed;

  const HeaderWidget({
    super.key,
    required this.title,
    this.leftIcon = Icons.menu,
    this.rightIcon = Icons.person,
    required this.onRightIconPressed,
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
          // Icon and profile button in the header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  leftIcon,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  Scaffold.of(context)
                      .openDrawer(); // Open drawer when menu icon is pressed
                },
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
          // Title with centered text
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

  // Implement preferredSize for PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(150);
}

// ComplaintFormPage Class Definition
class ComplaintFormPage extends StatefulWidget {
  const ComplaintFormPage({super.key});

  @override
  _ComplaintFormPageState createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController currentRoomController = TextEditingController();
  final TextEditingController currentBuildingController =
      TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // Variable for selected complaint type
  String selectedComplaintType = 'Wi-Fi';

  // List of complaint types
  List<String> complaintTypes = [
    'Wi-Fi',
    'Laundry',
    'Water',
    'Food',
    'Cleaning',
    'Electric'
  ];

  // Method to submit complaint data to Firestore
  Future<void> submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      // Save to Firestore
      await FirebaseFirestore.instance.collection('complaint_request').add({
        'room': currentRoomController.text,
        'building': currentBuildingController.text,
        'complaintType': selectedComplaintType,
        'reason': reasonController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Show success message and reset form
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully!')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle navigation
              },
            ),
          ],
        ),
      ),
      appBar: HeaderWidget(
        title: 'Complaints',
        leftIcon: Icons.menu,
        rightIcon: Icons.person,
        onRightIconPressed: () {
          // Handle right icon press, e.g., navigate to profile page
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Form key for validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Building name\nand Room no.',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the room number';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the building name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Complaint Type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Dropdown for complaint type
                DropdownButtonFormField<String>(
                  value: selectedComplaintType,
                  items: complaintTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedComplaintType = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
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
                    hintText: 'Complaint',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the reason for the complaint';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50), // Increase space above button
                Center(
                  child: ElevatedButton(
                    onPressed: submitComplaint,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF33665A), // Set the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ), // Adjust padding as needed
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ComplaintFormPage(),
  ));
}
