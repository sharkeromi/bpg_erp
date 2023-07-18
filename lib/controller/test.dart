// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:share_plus/share_plus.dart';

// class test {
//   test(){
//        var dearmarchentMessage = "Dear Merchandiser,\n Here is the buyer visiting card information : \n\n\n";
//                       var emailAddress ="tanjiluits70@gmail.com";
//                       var subject = "Buyer information ";
                    
                    
                    
//                       // share/ share.plus -> how to share with the files
//                       shareimage;
//                       // path diye pathaben...... share.share(file
                    
//                       final bool hasEmailApp = await canLaunch('mailto:$emailAddress');
                    
//                       if (hasEmailApp) {
//                         final Email email = Email(
//                           recipients: [emailAddress],
//                           subject: subject,
//                           body: dearmarchentMessage,
//                           // attachmentPaths: filePaths
//                         );
                      
//                         await FlutterEmailSender.send(email);
//                       }
//                       else {
//                         // Share text if email app is not available
//                         // final String textWithAttachments = '$body\n\nAttachments:\n${attachmentPaths.join('\n')}';
//                         // await Share.share(textWithAttachments);
//                       }
                    
                    
//                       for (var i = 0; i < files.length; i++) {
//                         print(files[i].path!);
//                         var xfile = XFile(files[i].path!,);
//                         files.add(xfile);
//                       }
//                       await Share.shareXFiles(files);
                    
                    
//                       if (emailAddress != null && subject != null) {
//                         final intent = AndroidIntent(
//                           action: 'android.intent.action.SENDTO',
//                           data: Uri.encodeFull(
//                               'mailto:$emailAddress?subject=$subject&body=${dearmarchentMessage + resultController.text}'),
                    
//                         );
//                         await intent.launch();
                    
                    
                    
//                         Share.shareFiles(filePaths, text: 'This Email was Created by TRS to send an Excel File!',);
                    
                    
                    
                    
//                         final AndroidIntent intent = AndroidIntent(
//                           action: 'android.intent.action.SEND_MULTIPLE',
//                           package: 'com.google.android.gm', // Use the email app's package name (Gmail: com.google.android.gm)
//                           type: 'message/rfc822', // MIME type for email
//                           arguments: {
//                             'android.intent.extra.EMAIL': [emailAddress],
//                             'android.intent.extra.STREAM': filePaths.map((path) => Uri.parse('file://$path')).toList(),
//                           },
//                         );
                    
//                         await intent.launch();
                    
//                       }
//                       else {
//                         Share.share(
//                             dearmarchentMessage + resultController.text,
//                             subject: "Buyer visiting card information",);
//                       }
//                       Share.share(
//                         dearmarchentMessage + resultController.text,
//                         subject: "Buyer visiting card information",
//                       );

//   }
// }