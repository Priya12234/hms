import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment {
  late Razorpay _razorpay;
  String? userEmail;

  RazorpayPayment(this.userEmail) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void openCheckout(BuildContext context, String documentId) async {
    var options = {
      'key': 'rzp_test_REo0zhqvsLnl6Y', // Replace with your Razorpay Key
      'amount': 50000, // Amount in paise (50000 paise = ₹500)
      'name': 'Hostel Fee',
      'description': 'Payment for hostel fees',
      'prefill': {
        'email': userEmail ?? 'test@example.com',
        'contact': 'YOUR_CONTACT_NUMBER', // Replace with user’s contact if available
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      _showErrorDialog(context, 'Error', 'Failed to open checkout: ${e.toString()}');
      print(e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    // Update payment status in Firestore here if needed
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
  }

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
}
