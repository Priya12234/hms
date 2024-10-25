import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Store user data in Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
          'phone': _phoneController.text.trim(),
          'buildingName': _buildingNameController.text.trim(),
          'roomNumber': _roomNameController.text.trim(),
          'course': _courseController.text.trim(),
        });

        // Show success SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Successful!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(), // Navigate to LoginScreen
        ));
      } on FirebaseAuthException catch (e) {
        String message = "An error occurred, please try again.";
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'An account already exists for that email.';
        }

        // Show error SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE6F4EC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBackground(screenHeight),
            _buildForm(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(double screenHeight) {
    return Container(
      height: screenHeight * 0.3,
      decoration: const BoxDecoration(
        color: Color(0xFF33665A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(200),
          bottomRight: Radius.circular(200),
        ),
      ),
      child: const Center(
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildForm(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
                _firstNameController, 'First Name', Icons.person_outline),
            _buildTextField(
                _lastNameController, 'Last Name', Icons.person_outline),
            _buildTextField(_emailController, 'Email', Icons.email_outlined),
            _buildTextField(_phoneController, 'Phone', Icons.phone),
            _buildPasswordTextField(),
            _buildTextField(
                _buildingNameController, 'Building Name', Icons.location_city),
            _buildTextField(_roomNameController, 'Room Name', Icons.room),
            _buildTextField(_courseController, 'Course', Icons.book_outlined),
            const SizedBox(height: 30),
            _signUpButton(screenWidth),
            _loginPrompt(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: _togglePasswordVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton(double screenWidth) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF33665A),
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.25, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: _signUp,
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _loginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? '),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
