import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/controller/sp_controller.dart';
import 'package:bpg_erp/utils/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalController extends GetxController {
  final SharedPreference sharedPreference = SharedPreference();
  HomeController homeController = Get.find<HomeController>();
  RxString text = RxString('');

  saveDataSP(value) async {
    if (value == null) {
      showSnackBar("Warning!", "Data send successfully.", Colors.green);
    } else {
      await sharedPreference.saveImageData(value);
      showSnackBar("Success!", "Data send successfully.", Colors.green);
    }
  }

  showSnackBar(String title, String message, Color color) {
    return Get.snackbar(
      title,
      message,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: color,
      colorText: Colors.white,
      maxWidth: 400,
      snackPosition: SnackPosition.TOP,
    );
  }

  resetSharedPreference() async {
    await sharedPreference.removeCache();
  }

   shareImageAndText( type) async {
    var serverList;
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      final String imagePath = homeController.imageList[i]['image'];
      serverList.add(XFile(imagePath));
    }
    var cardInfo = stringAdder();
    if (type == 'card') {
      final String text = cardEmailBody + cardInfo;
      await Share.shareXFiles(serverList,
          text: text, subject: kCardEmailSubject);
    } else {
      final String text = buyerEmailBody + cardInfo;
      await Share.shareXFiles(serverList,
          text: text, subject: kBuyerEmailSubject);
    }
  }

  shareImageAndTextHanger(index) async {
    final String imagePath = homeController.imageList[index]['image'];
    var cardInfo = stringAdder();
    final String text = buyerEmailBody + cardInfo;
    await Share.shareXFiles([XFile(imagePath)],
        text: text, subject: kBuyerEmailSubject);
  }

  stringAdder() {
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      text.value = homeController.imageList[i]['text'] + dottedLines;
    }
    return text.value;
  }

//* send through url launcher
//   void sendEmailWithRecipient(String subject, String body) async {
//   final Uri params = Uri(
//     scheme: 'mailto',
//     path: recipientEmail,
//     query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
//   );

//   if (await canLaunchUrl(params)) {
//     await launchUrl(params);
//   } else {
//     throw 'Could not launch email client.';
//   }
// }
}
