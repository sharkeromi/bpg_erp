// class mailer {
//   void sendEmailWithAttachment() async {
//   // Set your email credentials
//   final String username = 'your_email@gmail.com'; // Your email address
//   final String password = 'your_email_password'; // Your email password

//   // Set up the SMTP server
//   final smtpServer = gmail(username, password);

//   // Compose the email message
//   final message = Message()
//     ..from = Address(username)
//     ..recipients.add('recipient@example.com') // Recipient email address
//     ..subject = 'Check out this attachment!' // Email subject
//     ..text = 'Hello,\n\nI wanted to share this amazing file with you. Hope you find it interesting.\n\nBest regards,\nYour Name'; // Email body

//   // Pick the file from the device
//   File? attachmentFile = await pickFile(); // Implement the pickFile() function as shown in the previous examples

//   if (attachmentFile == null) {
//     // Handle if no file is selected
//     return;
//   }

//   // Attach the file to the email
//   final attachment = FileAttachment(attachmentFile)
//     ..filename = attachmentFile.path.split('/').last; // Set the filename for the attachment

//   message.addAttachment(attachment);

//   // Send the email
//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: ${sendReport.toString()}');
//   } on MailerException catch (e) {
//     print('Sending failed: ${e.message}');
//   }
// }

// }