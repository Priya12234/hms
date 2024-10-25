import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/Screens/header_widget.dart'; // Import your HeaderWidget

class FeeDetails extends StatefulWidget {
  const FeeDetails({super.key});

  @override
  _FeeDetailsState createState() => _FeeDetailsState();
}

class _FeeDetailsState extends State<FeeDetails> {
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('admin_fees_details')
                  .snapshots(),
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
        ],
      ),
    );
  }
}
