import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package
import 'package:hms/Screens/header_widget.dart';

class ExitPassPage extends StatefulWidget {
  const ExitPassPage({super.key});

  @override
  _ExitPassPageState createState() => _ExitPassPageState();
}

class _ExitPassPageState extends State<ExitPassPage> {
  DateTime? _selectedExitDate;
  DateTime? _selectedReturnDate;
  String _selectedExitTime = '';
  String _selectedReturnTime = '';
  String _selectedExitAmPm = 'AM';
  String _selectedReturnAmPm = 'AM';

  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(); // Email Controller

  Future<void> _selectDate(BuildContext context,
      {required bool isExitDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isExitDate) {
          _selectedExitDate = picked;
        } else {
          _selectedReturnDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context,
      {required bool isExitTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isExitTime) {
          _selectedExitTime = picked.format(context);
          _selectedExitAmPm = picked.period == DayPeriod.am ? 'AM' : 'PM';
        } else {
          _selectedReturnTime = picked.format(context);
          _selectedReturnAmPm = picked.period == DayPeriod.am ? 'AM' : 'PM';
        }
      });
    }
  }

  // Function to add data to Firestore
  Future<void> _submitExitPassRequest() async {
    if (_roomNumberController.text.isEmpty ||
        _purposeController.text.isEmpty ||
        _emailController.text.isEmpty || // Check if email is empty
        _selectedExitDate == null ||
        _selectedExitTime.isEmpty ||
        _selectedReturnDate == null ||
        _selectedReturnTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Optional: Basic email validation
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('exit_pass_requests').add({
        'room_no': _roomNumberController.text,
        'email': _emailController.text, // Add email to Firestore
        'exit_date': _selectedExitDate!.toLocal().toString().split(' ')[0],
        'exit_time': '$_selectedExitTime $_selectedExitAmPm',
        'return_date': _selectedReturnDate!.toLocal().toString().split(' ')[0],
        'return_time': '$_selectedReturnTime $_selectedReturnAmPm',
        'purpose': _purposeController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Exit pass request submitted successfully')),
      );

      // Clear the fields after submission
      setState(() {
        _roomNumberController.clear();
        _emailController.clear(); // Clear email field
        _purposeController.clear();
        _selectedExitDate = null;
        _selectedExitTime = '';
        _selectedReturnDate = null;
        _selectedReturnTime = '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4EC), // Light green background
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const HeaderWidget(title: 'Exit pass request'),
          const SizedBox(height: 10.0,),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(
                  0xFF3D6257), // Dark green color for the section header
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Fill Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _roomNumberController,
            label: 'Room number',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _emailController, // Email TextField
            label: 'Email Address',
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectDate(context, isExitDate: true),
            child: AbsorbPointer(
              child: CustomTextField(
                label: _selectedExitDate != null
                    ? "Exit Date: ${_selectedExitDate!.toLocal()}".split(' ')[0]
                    : 'Select Exit Date',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context, isExitTime: true),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      label: _selectedExitTime.isNotEmpty
                          ? "Exit Time: $_selectedExitTime"
                          : 'Select Exit Time',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _selectedExitAmPm,
                items: ['AM', 'PM'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedExitAmPm = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectDate(context, isExitDate: false),
            child: AbsorbPointer(
              child: CustomTextField(
                label: _selectedReturnDate != null
                    ? "Return Date: ${_selectedReturnDate!.toLocal()}"
                        .split(' ')[0]
                    : 'Select Return Date',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context, isExitTime: false),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      label: _selectedReturnTime.isNotEmpty
                          ? "Return Time: $_selectedReturnTime"
                          : 'Select Return Time',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _selectedReturnAmPm,
                items: ['AM', 'PM'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedReturnAmPm = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _purposeController,
            label: 'Purpose',
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _submitExitPassRequest, // Call submit function directly
            child: const Text('Submit'),
          ),
        ]),
      ),
    );
  }
}

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
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: onProfilePressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
