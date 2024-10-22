import 'package:flutter/material.dart';
import 'package:hms/Screens/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashService _splashService = SplashService();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      await _splashService.init(context);
      // No need for manual navigation here, it's handled by SplashService
    } catch (e) {
      // If initialization fails, handle it here, possibly retry or show an error message
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Initialization Error'),
          content: Text('Failed to initialize the application properly: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                initializeApp(); // Retry initialization
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adding a logo or image
            FlutterLogo(size: 100),
            SizedBox(height: 24),
            // Progress indicator with a label below
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text('Loading...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
