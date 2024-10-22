import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Exit Pass Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('exit_pass_requests') // Ensure collection name matches
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No exit pass requests found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              var documentId = data.id; // Fetch document ID

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Room No: ${data['room_no']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${data['email']}'),
                      Text('Exit Date: ${data['exit_date']}'),
                      Text('Exit Time: ${data['exit_time']}'),
                      Text('Return Date: ${data['return_date']}'),
                      Text('Return Time: ${data['return_time']}'),
                      Text('Purpose: ${data['purpose']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          confirmRequest(documentId, data['email']);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          cancelRequest(documentId, data['email']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to confirm the request and send an email
  void confirmRequest(String documentId, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection('exit_pass_requests') // Ensure correct collection name
          .doc(documentId)
          .update({'status': 'Confirmed'});

      await sendEmail(email, 'Your exit pass request is confirmed');
    } catch (e) {
      print('Error confirming request: $e');
    }
  }

  // Function to cancel the request and send an email
  void cancelRequest(String documentId, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection('exit_pass_requests') // Ensure correct collection name
          .doc(documentId)
          .update({'status': 'Cancelled'});

      await sendEmail(email, 'Your exit pass request has been cancelled');
    } catch (e) {
      print('Error cancelling request: $e');
    }
  }

  // Function to send email using the mailer package
  Future<void> sendEmail(String recipient, String message) async {
    String username = 'idavda079@rku.ac.in'; // Your email
    String password = 'davdaisha2005'; // Your password

    final smtpServer = gmail(username, password); // Using Gmail's SMTP
    final emailMessage = Message()
      ..from =
          Address(username, 'Hostel Management') // Display name of the sender
      ..recipients.add(recipient) // Recipient email
      ..subject = 'Exit Pass Request Update' // Email subject
      ..text = message; // Email body

    try {
      await send(emailMessage, smtpServer);
      print('Email sent to $recipient');
    } catch (e) {
      print('Error sending email: $e');
      // You can also display a SnackBar or some UI feedback to the user here
    }
  }
}
