import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String toEmail, String subject, String body) async {
  String username = 'idavda079@gmail.com'; // Your admin email
  String password = 'davdaisha2005'; // Create an app password in Gmail

  // Create the SMTP server for Gmail
  final smtpServer = gmail(username, password);

  // Create the message
  final message = Message()
    ..from = Address(username, 'Admin')
    ..recipients.add(toEmail) // Recipient email
    ..subject = subject
    ..text = body;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  } on MailerException catch (e) {
    print('Message not sent. \n${e.toString()}');
  }
}
