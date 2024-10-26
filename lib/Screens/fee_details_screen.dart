import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hms/Screens/header_widget.dart'; // Import your HeaderWidget
import 'package:shared_preferences/shared_preferences.dart';
import 'razorpay_payment.dart'; // Import the RazorpayPayment class

class FeeDetails extends StatefulWidget {
  const FeeDetails({super.key});

  @override
  _FeeDetailsState createState() => _FeeDetailsState();
}

class _FeeDetailsState extends State<FeeDetails> {
  String? userEmail; // Variable to hold the user email
  late RazorpayPayment _razorpayPayment;

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Fetch the user email when the widget initializes
  }

  @override
  void dispose() {
    _razorpayPayment.dispose(); // Dispose Razorpay resources when done
    super.dispose();
  }

  // Function to get the user email based on their ID from Firestore
  Future<void> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getString('userId'); // Fetch the user ID from SharedPreferences

    if (userId != null) {
      // Fetch the user email from Firestore based on the user ID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Adjust to your user collection
          .doc(userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          userEmail =
              userDoc['email']; // Assuming the email field is named 'email'
          _razorpayPayment = RazorpayPayment(
              userEmail); // Initialize RazorpayPayment with user email
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(
              title: 'Fees Details'), // Add the HeaderWidget here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: userEmail != null
                    ? FirebaseFirestore.instance
                        .collection('admin_fees_details')
                        .where('email', isEqualTo: userEmail) // Filter by email
                        .snapshots()
                    : Stream
                        .empty(), // Return an empty stream if userEmail is not set
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  final documents = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: Column(
                      children: documents.map<Widget>((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final String status = data['status'];
                        final bool isPaid = status == 'paid';

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${data['email']}',
                                    style: const TextStyle(fontSize: 18)),
                                Text('Building: ${data['building']}',
                                    style: const TextStyle(fontSize: 16)),
                                Text('Type: ${data['type']}',
                                    style: const TextStyle(fontSize: 16)),
                                Text('Fees: ₹${data['fees'].toString()}',
                                    style: const TextStyle(fontSize: 16)),
                                Text('Status: ${isPaid ? 'Paid' : 'Unpaid'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isPaid ? Colors.green : Colors.red,
                                    )),
                                Text('Date: ${data['date']}',
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: isPaid
                                      ? null
                                      : () => _razorpayPayment.openCheckout(
                                          context,
                                          doc.id), // Pass the context here
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isPaid
                                        ? Colors.grey
                                        : Colors
                                            .blue, // Change color based on payment status
                                  ),
                                  child: Text(isPaid ? 'Paid' : 'Pay Now',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
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
