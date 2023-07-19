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
      await Share.shareXFiles(serverList,
          text: text, subject: kCardEmailSubject);
    } else {
      final String text = buyerEmailBody + '\n' + cardInfo;
      await Share.shareXFiles(serverList,
          text: text, subject: kBuyerEmailSubject);
    }
  }

  stringAdder() {
    String text = '';
    HomeController homeController = Get.find<HomeController>();
    int j = 0;
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      text += ("------ Result ${j + 1} ------\n\n" +
          homeController.imageList[i]['text'] +
          '\n\n');
      j++;
    }
    return text;
  }

  stringManipulation(value) {
    var split1 = value.split('#');
    var temp = '';
    String con = '';
    for (int i = 0; i < split1.length - 1; i++) {
      if ((!split1[i].toString().contains('Reference') &&
              !split1[i].toString().contains('Referençe')) &&
          i == 1) {
        temp += (split1[i] + 'Reference #');
      } else {
        temp += (split1[i] + ' #');
      }
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('Reference');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += (split1[i] + '\nReference');
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('Referençe');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += split1[i] + '\nReferençe';
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('Fabrication');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += split1[i] + '\nFabrication';
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('Composition');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += split1[i] + '\nComposition';
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('GSM');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += split1[i] + '\nGSM';
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('DIA');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += split1[i] + '\nDIA';
    }
    temp += split1[split1.length - 1];
    con = temp;

    split1 = con.split('Technical Info');
    temp = '';
    for (int i = 0; i < split1.length - 1; i++) {
      temp += split1[i] + '\nTechnical Info ';
    }

    if (split1[split1.length - 1].toString().contains('DIA')) {
      var newSplit = split1[split1.length - 1].toString().split('DIA');
      var smallSplit = newSplit[1].toString().split('\n');
      var added = "DIA" + smallSplit[0];
      var newCon = temp.split('Technical Info');
      temp = newCon[0] + added + "\nTechnical Info" + newCon[1];
      var tempSplit = split1[split1.length - 1].toString().split(added);
      temp += (tempSplit[0] + tempSplit[1].substring(1));
    } else {
      temp += split1[split1.length - 1];
    }
    con = temp;
    return con;
  }
}
