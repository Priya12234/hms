import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const FeeDetailsApp());
}

class FeeDetailsApp extends StatelessWidget {
  const FeeDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fees Details',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FeeDetails(),
    );
  }
}

class FeeDetails extends StatefulWidget {
  const FeeDetails({super.key});

  @override
  _FeeDetailsState createState() => _FeeDetailsState();
}

class _FeeDetailsState extends State<FeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fees Details'),
        backgroundColor: const Color(0xFF33665A),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
              scrollDirection: Axis.horizontal, // Horizontal scrolling enabled
              child: DataTable(
                border: TableBorder.all(
                    width: 1, color: Colors.grey), // Adding border to the table
                columns: const [
                  DataColumn(label: Text('Building')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Fees')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Date')),
                ],
                rows: documents.map<DataRow>((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final statusColor =
                      data['status'] == 'paid' ? Colors.green : Colors.red;

                  return DataRow(
                    cells: [
                      DataCell(Text(data['building'])),
                      DataCell(Text(data['type'])),
                      DataCell(Text(data['fees'])),
                      DataCell(
                        Text(
                          data['status'],
                          style: TextStyle(color: statusColor),
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
    );
  }
}
