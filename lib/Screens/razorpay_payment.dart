import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment {
  late Razorpay _razorpay;
  String? userEmail;

  RazorpayPayment(this.userEmail) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  }

  void dispose() {
    _razorpay.clear();
  }

  void openCheckout(BuildContext context, String documentId) async {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY', // Replace with your Razorpay Key
      'amount': 50000, // Amount in paise (50000 paise = ₹500)
      'name': 'Hostel Fee',
      'description': 'Payment for hostel fees',
      'prefill': {
        'email': userEmail,
        'contact': 'YOUR_CONTACT_NUMBER', // Optional: replace with user's contact number
      },
      'external': {
        'wallets': ['paypal'] // Optional
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // Display an error dialog to the user
      _showErrorDialog(context, 'Error', 'Failed to open checkout: ${e.toString()}');
      print(e.toString());
    }
  }

  // Method to show error dialog
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment here
    print('Payment Success: ${response.paymentId}');
    // You can also update the payment status in Firestore here
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure here
    print('Payment Error: ${response.message}');
  }
}
