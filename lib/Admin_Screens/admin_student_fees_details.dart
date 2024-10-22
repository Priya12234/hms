import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore

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
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const AdminFeesDetails());
}

class AdminFeesDetails extends StatelessWidget {
  const AdminFeesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fees Details',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AdminFeesDetailsPage(),
    );
  }
}

class AdminFeesDetailsPage extends StatefulWidget {
  const AdminFeesDetailsPage({super.key});

  @override
  _FeesDetailsPageState createState() => _FeesDetailsPageState();
}

class _FeesDetailsPageState extends State<AdminFeesDetailsPage> {
  String? selectedBuilding;
  String? selectedType;
  String? selectedFees;
  String? selectedStatus;
  DateTime? selectedDate;

  // Options for the dropdowns
  final List<String> buildingOptions = ['A', 'B', 'C'];
  final List<String> typeOptions = ['4 Sharing', '6 Sharing'];
  final List<String> feesOptions = ['79,000', '72,000'];
  final List<String> statusOptions = ['Paid', 'Unpaid'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _uploadData() async {
    if (selectedBuilding != null &&
        selectedType != null &&
        selectedFees != null &&
        selectedStatus != null &&
        selectedDate != null) {
      try {
        // Create a map of data to store in Firestore
        Map<String, dynamic> data = {
          'building': selectedBuilding,
          'type': selectedType,
          'fees': selectedFees,
          'status': selectedStatus,
          'date': selectedDate!.toIso8601String(), // Store date as string
        };

        print("Uploading data: $data"); // Debug print

        // Add data to Firestore
        await FirebaseFirestore.instance
            .collection('admin_fees_details')
            .add(data);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data uploaded successfully!')));
      } catch (error) {
        print("Error uploading data: $error"); // Debug print
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload data: $error')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4EC),
      appBar: CustomAppBar(
        title: 'Fees Details',
        onProfilePressed: () {
          // Handle profile button press
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Building',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedBuilding,
                hint: const Text('Select Building'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBuilding = newValue;
                  });
                },
                items: buildingOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedType,
                hint: const Text('Select Type'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue;
                  });
                },
                items:
                    typeOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fees',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedFees,
                hint: const Text('Select Fees'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFees = newValue;
                  });
                },
                items:
                    feesOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                hint: const Text('Select Status'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
                items:
                    statusOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    selectedDate == null
                        ? 'No date selected!'
                        : '${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                // Wrap ElevatedButton in Center widget
                child: ElevatedButton(
                  onPressed: _uploadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33665A),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    textStyle:
                        const TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
                  ),
                  child: const Text(
                    'Submit',
                    selectionColor: Color(0xffffffffff),
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
