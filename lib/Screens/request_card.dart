import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String requestId;
  final String userEmail;
  final String reason;
  final String status;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const RequestCard({super.key, 
    required this.requestId,
    required this.userEmail,
    required this.reason,
    required this.status,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Request ID: $requestId',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('User Email: $userEmail'),
            Text('Reason: $reason'),
            Text('Status: $status'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green)),
                  child: Text('Confirm'),
                ),
                ElevatedButton(
                  onPressed: onCancel,
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red)),
                  child: Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
