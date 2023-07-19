import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/controller/sp_controller.dart';
import 'package:bpg_erp/utils/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class GlobalController extends GetxController {
  final SharedPreference sharedPreference = SharedPreference();

  //* SharedPreference Helper Fuctions

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

  //* Share Image & Text through Email

  shareImageAndText(type) async {
    HomeController homeController = Get.find<HomeController>();
    List<XFile> serverList = [];
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      final String imagePath = homeController.imageList[i]['image'];
      serverList.add(XFile(imagePath));
    }
    var cardInfo = stringAdder();
    if (type == 'card') {
      final String text = cardEmailBody + '\n' + cardInfo;
      await Share.shareXFiles(serverList, text: text, subject: kCardEmailSubject);
    } else {
      final String text = buyerEmailBody + '\n' + cardInfo;
      await Share.shareXFiles(serverList, text: text, subject: kBuyerEmailSubject);
    }
  }

  stringAdder() {
    String text = '';
    HomeController homeController = Get.find<HomeController>();
    int j = 0;
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      text += ("------ Result ${j + 1} ------\n\n" + homeController.imageList[i]['text'] + '\n\n');
      j++;
    }
    return text;
  }
}
