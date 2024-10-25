import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/Screens/header_widget.dart'; // Import your HeaderWidget
import 'package:shared_preferences/shared_preferences.dart';

class FeeDetails extends StatefulWidget {
  const FeeDetails({super.key});

  @override
  _FeeDetailsState createState() => _FeeDetailsState();
}

class _FeeDetailsState extends State<FeeDetails> {
  String? userEmail; // Variable to hold the user email

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Fetch the user email when the widget initializes
  }

  // Function to get the user email based on their ID from Firestore
  Future<void> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId'); // Fetch the user ID from SharedPreferences

    if (userId != null) {
      // Fetch the user email from Firestore based on the user ID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Adjust to your user collection
          .doc(userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          userEmail = userDoc['email']; // Assuming the email field is named 'email'
        });
      }
    }
  }

  // Function to handle status update (paid/unpaid) in Firestore
  Future<void> updateStatus(String documentId, String status) async {
    await FirebaseFirestore.instance
        .collection('admin_fees_details')
        .doc(documentId)
        .update({'status': status});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(title: 'Fees Details'), // Add the HeaderWidget here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: userEmail != null
                    ? FirebaseFirestore.instance
                        .collection('admin_fees_details')
                        .where('email', isEqualTo: userEmail) // Filter by email
                        .snapshots()
                    : Stream.empty(), // Return an empty stream if userEmail is not set
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
            
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }
            
                  final documents = snapshot.data!.docs;
            
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(
                          width: 1,
                          color: Colors.grey,
                        ), // Adding border to the table
                        columns: const [
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Building')),
                          DataColumn(label: Text('Type')),
                          DataColumn(label: Text('Fees')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Date')),
                        ],
                        rows: documents.map<DataRow>((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final documentId = doc.id; // Get document ID for updating
            
                          final String status = data['status'];
                          final bool isPaid = status == 'paid';
                          final Color statusColor = isPaid ? Colors.green : Colors.red;
                          final String statusLabel = isPaid ? 'Paid' : 'Unpaid';
            
                          return DataRow(
                            cells: [
                              DataCell(Text(data['email'])),
                              DataCell(Text(data['building'])),
                              DataCell(Text(data['type'])),
                              DataCell(Text(data['fees'].toString())), // Ensure fees are displayed correctly
                              DataCell(
                                ElevatedButton(
                                  onPressed: isPaid
                                      ? null // Disable the button if already paid
                                      : () {
                                          updateStatus(documentId, 'paid');
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: statusColor, // Set green for paid, red for unpaid
                                    minimumSize: const Size(80, 40), // Button size
                                  ),
                                  child: Text(
                                    statusLabel,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              DataCell(Text(data['date'])),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
