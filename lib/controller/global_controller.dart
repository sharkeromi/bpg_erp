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

  void shareImageAndTextCard(index) async {
    final String imagePath = homeController.imageList[index]['image'];
    final String text = homeController.imageList[index]['text'];
    await Share.shareXFiles([XFile(imagePath)],
        text: text, subject: kCardEmailSubject);
    // Share.share(text)
  }

  void shareImageAndTextHanger(index) async {
    final String imagePath = homeController.imageList[index]['image'];
    final String body = '';
    var cardInfo = stringAdder();
    final String text = buyerEmailBody + cardInfo;
    await Share.shareXFiles([XFile(imagePath)],
        text: text, subject: kBuyerEmailSubject);
    // Share.share(text)
  }

  stringAdder() {
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      text.value = homeController.imageList[i]['text'] + dottedLines;
    }
    return text.value;
  }


  void sendEmailWithRecipient(String subject, String body) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: recipientEmail,
    query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
  );

  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    throw 'Could not launch email client.';
  }
}

}
