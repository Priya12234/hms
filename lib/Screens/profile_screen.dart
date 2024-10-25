import 'package:flutter/material.dart';
import 'package:hms/Screens/drawer_screen.dart';
import 'package:hms/Screens/header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId =
        prefs.getString('userId'); // Get user ID from SharedPreferences

    if (userId != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data() as Map<String, dynamic>;
          });
        } else {
          print('User data not found');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User ID not found in SharedPreferences');
    }
  }

  void _changePassword() async {
    String? email = userData?['email'];
    if (email != null) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        _showDialog('Success', 'Password reset email sent to $email.');
      } catch (e) {
        _showDialog('Error', 'Failed to send reset email: $e');
      }
    } else {
      _showDialog('Error', 'Email not found.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
          firstName:
              userData?['firstName'] ?? 'User'), // Custom drawer with user name
      backgroundColor: const Color(0xFFE6F4EC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderWidget(
                  title: 'Your Profile'), // Use HeaderWidget here
              const SizedBox(height: 16),
              const SizedBox(height: 30),
              userData == null
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        buildInfoRow(
                            'Firstname.', userData?['firstName'] ?? 'N/A'),
                        buildDivider(),
                        buildInfoRow(
                            'Lastname.', userData?['lastName'] ?? 'N/A'),
                        buildDivider(),
                         buildInfoRow('Email.', userData?['email'] ?? 'N/A'),
                        buildDivider(),
                        buildInfoRow(
                            'Room No.', userData?['roomNumber'] ?? 'N/A'),
                        buildDivider(),
                        buildInfoRow('Building Name',
                            userData?['buildingName'] ?? 'N/A'),
                        buildDivider(),
                        buildInfoRow('Course', userData?['course'] ?? 'N/A'),
                        buildDivider(),
                        buildInfoRow('Contact', userData?['phone'] ?? 'N/A'),
                        buildDivider(),
                        ListTile(
                          leading: const Icon(Icons.lock, color: Colors.black),
                          title: const Text(
                            'Change Password',
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: _changePassword,
                        ),
                        buildDivider(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label :',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: Colors.teal,
      thickness: 1.0,
      height: 20,
    );
  }
}
