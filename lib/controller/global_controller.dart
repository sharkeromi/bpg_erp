import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/controller/sp_controller.dart';
import 'package:bpg_erp/utils/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class GlobalController extends GetxController {
  final SharedPreference sharedPreference = SharedPreference();

  //* SharedPreference Helper Functions
  saveDataSP(value) async {
    if (value == null) {
      showSnackBar("Warning", "Data not saved.", Colors.amber[600]!);
    } else {
      await sharedPreference.saveImageData(value);
      showSnackBar("Success", "Data saved successfully.", Colors.green);
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
      final String text = '$cardEmailBody\n$cardInfo';
      await Share.shareXFiles(serverList, text: text, subject: kCardEmailSubject);
    } else {
      final String text = '$buyerEmailBody\n$cardInfo';
      await Share.shareXFiles(serverList, text: text, subject: kBuyerEmailSubject);
    }
  }

  stringAdder() {
    String text = '';
    HomeController homeController = Get.find<HomeController>();
    int j = 0;
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      text += ("------ Result ${j + 1} ------\n\n${homeController.imageList[i]['text']}\n\n");
      j++;
    }
    return text;
  }

  stringManipulation(value) {
    // # splitting
    List<String> splitValue = value.split('#');
    String temporaryString = '';
    String modifiedValue = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      if ((!splitValue[i].toString().contains('Reference') && !splitValue[i].toString().contains('Referençe')) && i == 1) {
        temporaryString += ('${splitValue[i]}Reference #');
      } else {
        temporaryString += ('${splitValue[i]} #');
      }
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // Reference Splitting
    splitValue = modifiedValue.split('Reference');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += ('${splitValue[i]}\nReference');
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // Referençe splitting
    splitValue = modifiedValue.split('Referençe');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nReferençe';
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // Fabrication splitting
    splitValue = modifiedValue.split('Fabrication');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nFabrication';
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // Composition splitting
    splitValue = modifiedValue.split('Composition');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nComposition';
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // GSM splitting
    splitValue = modifiedValue.split('GSM');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nGSM';
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // DIA splitting
    splitValue = modifiedValue.split('DIA');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nDIA';
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // Technical Info splitting
    splitValue = modifiedValue.split('Technical Info');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nTechnical Info ';
    }

    if (splitValue[splitValue.length - 1].toString().contains('DIA')) {
      temporaryString += modifyExtractedText(splitValue, temporaryString);
    } else {
      temporaryString += splitValue[splitValue.length - 1];
    }
    modifiedValue = temporaryString;
    return modifiedValue;
  }

  modifyExtractedText(splitValue, temporaryString) {
    List<String> splitWithDIA = splitValue[splitValue.length - 1].toString().split('DIA');
    List<String> splitWithNewLine = splitWithDIA[1].toString().split('\n');
    String extractedValue = "DIA${splitWithNewLine[0]}";
    List<String> mainStringSplit = temporaryString.split('Technical Info');
    temporaryString = "${mainStringSplit[0]}$extractedValue\nTechnical Info${mainStringSplit[1]}";
    List<String> withoutDuplicate = splitValue[splitValue.length - 1].toString().split(extractedValue);
    return (withoutDuplicate[0] + withoutDuplicate[1].substring(1));
  }
}
