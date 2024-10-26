import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hms/Admin_Screens/admin_home_screen.dart';
import 'package:hms/Screens/Login_screen.dart';
import 'package:hms/Screens/fee_details_screen.dart';
import 'package:hms/Screens/home_screen.dart';
import 'package:hms/Screens/profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error occurred during Firebase initialization: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
