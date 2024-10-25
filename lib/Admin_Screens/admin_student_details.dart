import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminStudentDetails extends StatefulWidget {
  const AdminStudentDetails({super.key});

  @override
  _AdminStudentDetailsState createState() => _AdminStudentDetailsState();
}

class _AdminStudentDetailsState extends State<AdminStudentDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: const Color(0xFF33665A),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(), // Fetch users data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          // Fetch the users from the Firestore collection
          final users = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: DataTable(
              columns: const [
                DataColumn(label: Text('First Name')),
                DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Building Name')),
                DataColumn(label: Text('Room Name')),
                DataColumn(label: Text('Course')),
              ],
              rows: users.map((user) {
                var userData = user.data() as Map<String, dynamic>;
                return DataRow(
                  cells: [
                    DataCell(Text(userData['firstName'] ?? '')),
                    DataCell(Text(userData['lastName'] ?? '')),
                    DataCell(Text(userData['email'] ?? '')),
                    DataCell(Text(userData['phone'] ?? '')),
                    DataCell(Text(userData['buildingName'] ?? '')),
                    DataCell(Text(userData['roomName'] ?? '')),
                    DataCell(Text(userData['course'] ?? '')),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
