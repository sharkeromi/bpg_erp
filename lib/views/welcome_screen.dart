import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

//import 'package:uri_to_file/uri_to_file.dart';
import 'package:vocsy_esys_flutter_share/vocsy_esys_flutter_share.dart';
import 'package:share/share.dart' as SharePlus;
import 'package:path/path.dart' as Path;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController resultController = TextEditingController();

  //image Sahre
  shareimage() async {
    // XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery);
    if (files.length <= 0) return;
    Share.shareXFiles(files, text: extractedText);
  }

  shareimage1() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    Share.shareXFiles([image], text: extractedText);
  }

  //getx

  String extractedText = '';
  List<String> filePaths = <String>[];
  final files = <XFile>[];
  final FlutterTesseractOcr flutterTesseractOcr = FlutterTesseractOcr();

  Future<void> extractTextFromImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();


    try {
      final XFile? image = await _picker.pickImage(
          source: imageSource, imageQuality: 30); // from camera/gallery
      files.add(image!);
      File? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 20,
          maxWidth: 1000,
          maxHeight: 1000,
          /* aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio3x2
          ],*/
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrange,
              toolbarTitle: "Crop the image",
              statusBarColor: Colors.deepOrange.shade900,
              backgroundColor: Colors.white));

      if (image != null) {
        _saveNetworkImage(image.path);
        print("image path is ${cropped!.path}");
        //args support android / Web , i don't have a mac
        var text = await FlutterTesseractOcr.extractText(
          '${cropped.path}',
          language: 'eng',
          args: {
            'psm': '11', // Page segmentation mode
            'oem': '3 ',
            "preserve_interword_spaces": "1",
          },
        );
        setState(() {
          extractedText = text;
          print("extracted text is ${extractedText}");
          resultController.text = extractedText;
        });
      }
    } catch (e) {
      print('Error during text extraction: $e');
    }
  }

  void _saveNetworkImage(String imagepath) async {
    String path = imagepath;
    filePaths.add(imagepath);
    GallerySaver.saveImage(path).then((bool? success) {
      setState(() {
        print('Image is saved');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Activity"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        toolbarOpacity: 1,
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10),
        child: ListView(
          children: <Widget>[
        Center(
        child: Text(
          "Card To Text",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      InkWell(
          onTap: () async {
            print("camera button clicked");
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    // title: Text(scammedList[_current].title),
                    content: Container(
                      color: Colors.tealAccent,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 60,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Wrap(
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    await extractTextFromImage(
                                        ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.camera_alt),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("From Camera")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await extractTextFromImage(
                                        ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons
                                          .phone_android_outlined),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("From Gallery")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
            // await extractTextFromImage();
          },
          child: Icon(Icons.camera)),
      SizedBox(height: 10),
      Text(
        "Result",
        style: TextStyle(fontSize: 25),
      ),
      TextFormField(
        controller: resultController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Click Cemera Button to add  image'
        ),

        maxLines: null,
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 40,
            width: 150,
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    //   var dearmarchentMessage = "Dear Merchandiser,\n Here is the buyer visiting card information : \n\n\n";
                    //   var emailAddress ="tanjiluits70@gmail.com";
                    //   var subject = "Buyer information ";
                    //
                    //
                    //
                    //   // share/ share.plus -> how to share with the files
                    //   shareimage;
                    //   // path diye pathaben...... share.share(file
                    //
                    //   final bool hasEmailApp = await canLaunch('mailto:$emailAddress');
                    //
                    //   // if (hasEmailApp) {
                    //   //   final Email email = Email(
                    //   //     recipients: [emailAddress],
                    //   //     subject: subject,
                    //   //     body: dearmarchentMessage,
                    //   //     // attachmentPaths: filePaths
                    //   //   );
                    //   //
                    //   //   await FlutterEmailSender.send(email);
                    //   // }
                    //   // else {
                    //   //   // Share text if email app is not available
                    //   //   // final String textWithAttachments = '$body\n\nAttachments:\n${attachmentPaths.join('\n')}';
                    //   //   // await Share.share(textWithAttachments);
                    //   // }
                    //
                    //
                    //   // for (var i = 0; i < files.length; i++) {
                    //   //   print(files[i].path!);
                    //   //   var xfile = XFile(files[i].path!,);
                    //   //   files.add(xfile);
                    //   // }
                    //   // await Share.shareXFiles(files);
                    //
                    //
                    //   if (emailAddress != null && subject != null) {
                    //     final intent = AndroidIntent(
                    //       action: 'android.intent.action.SENDTO',
                    //       data: Uri.encodeFull(
                    //           'mailto:$emailAddress?subject=$subject&body=${dearmarchentMessage + resultController.text}'),
                    //
                    //     );
                    //     await intent.launch();
                    //
                    //
                    //
                    //     // Share.shareFiles(filePaths, text: 'This Email was Created by TRS to send an Excel File!',);
                    //
                    //
                    //
                    //
                    //     // final AndroidIntent intent = AndroidIntent(
                    //     //   action: 'android.intent.action.SEND_MULTIPLE',
                    //     //   package: 'com.google.android.gm', // Use the email app's package name (Gmail: com.google.android.gm)
                    //     //   type: 'message/rfc822', // MIME type for email
                    //     //   arguments: {
                    //     //     'android.intent.extra.EMAIL': [emailAddress],
                    //     //     'android.intent.extra.STREAM': filePaths.map((path) => Uri.parse('file://$path')).toList(),
                    //     //   },
                    //     // );
                    //
                    //     // await intent.launch();
                    //
                    //   }
                    //   else {
                    //     Share.share(
                    //         dearmarchentMessage + resultController.text,
                    //         subject: "Buyer visiting card information",);
                    //   }
                    //   Share.share(
                    //     dearmarchentMessage + resultController.text,
                    //     subject: "Buyer visiting card information",
                    //   );

                    shareimage();
                  } catch (e) {
                    print('error: $e');
                  }
                },
                child: Text("Send to Merchandiser")),
          ),
          Container(
            height: 40,
            width: 150,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),   // onno j kno screen...
                  );
                }, child: Text("Hanger scan")))
            ],
          )
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }
}
