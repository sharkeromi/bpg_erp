import 'dart:developer';
import 'dart:io';

import 'package:bpg_erp/controller/common/api_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/controller/common/sp_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/strings.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/utils/const/url.dart';
import 'package:bpg_erp/utils/const/value.dart';
import 'package:bpg_erp/views/home_screen.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:bpg_erp/views/widgets/delete_confirm_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';

class GlobalController extends GetxController {
  final SharedPreference sharedPreference = SharedPreference();

  //* SharedPreference Helper Functions
  saveDataSP(value) async {
    if (value == null) {
      showSnackBar("Warning", "Data not saved.", Colors.amber[600]!);
    } else {
      log(value.toString());
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
    // List<XFile> serverList = [];
    //* Attachment List
    List<String> imageList = [];
    for (int i = homeController.imageList.length - 1; i >= 0; i--) {
      final String imagePath = homeController.imageList[i]['image'];
      // serverList.add(XFile(imagePath));
      imageList.add(imagePath);
    }
    var cardInfo = stringAdder(type);
    if (type == 'card') {
      final String text = '$cardEmailBody\n$cardInfo';
      // await Share.shareXFiles(serverList, text: text, subject: kCardEmailSubject);
      //* Send email function
      final Email email = Email(
        body: '$cardEmailBody\n$cardInfo',
        subject: kCardEmailSubject,
        recipients: [homeController.emailEditingController.text.trim()], //* For empty recipient set [''] // TO mail send
        cc: ['salam@blueplanetgroup.com','babu@bpkw.net','rahim@blueplanetgroup.com','sales@blueplanet-fabric.com','fabric-inquiry@bpcomposite.com'],
        attachmentPaths: imageList,
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      resetQRData();
      Get.offAll(() =>  HomeScreen());
      showSnackBar("Success", "Email sent", cAcceptColor); // email Sent Message
    } else {
      final String text = '$buyerEmailBody\n$cardInfo';
      await Share.share(text, subject: kBuyerEmailSubject);
      resetQRData();
      Get.offAll(() =>  HomeScreen());
    }
  }

  stringAdder(type) {
    HomeController homeController = Get.find<HomeController>();
    GlobalController globalController = Get.find<GlobalController>();
    // String text = 'Name : ${homeController.nameEditingController.text.trim()}\n Email : ${homeController.emailEditingController.text.trim()}\n\n';
    String text = "";
    int k = 0;
    if (type == 'card') {
      for (int i = globalController.dataList.length - 1; i >= 0; i--) {
        text += ("------ QR Result ${k + 1} ------\n\nBarcode : ${globalController.dataList[i]['BARCODE_NO']}\n---------------------------------------\n");
        text +=
            ("Hanger Information : \n\nHanger No : ${globalController.fetchedQRData[0]['hanger_no']}\nReference : ${globalController.fetchedQRData[0]['reference']}\nFabrication : ${globalController.fetchedQRData[0]['fabrication']}\nComposition : ${globalController.fetchedQRData[0]['composition']}\nColor : ${globalController.fetchedQRData[0]['color']}\nGSM : ${globalController.fetchedQRData[0]['gsm']}\nDIA : ${globalController.fetchedQRData[0]['dia']}\n Technical Info : ${globalController.fetchedQRData[0]['technical_info']}\n\n");
        k++;
      }
      for (int i = homeController.imageList.length - 1; i >= 0; i--) {
        text += ("------ Card Info ------\n\n${homeController.imageList[i]['text']}\n\n");
      }
    }
    if (type != 'card') {
      text = '';
      for (int i = globalController.dataList.length - 1; i >= 0; i--) {
        text += ("------ QR Result ${k + 1} ------\n\nBarcode : ${globalController.dataList[i]['BARCODE_NO']}\n---------------------------------------\n");
        text +=
            ("Hanger Information : \n\nHanger No : ${globalController.fetchedQRData[0]['hanger_no']}\nReference : ${globalController.fetchedQRData[0]['reference']}\nFabrication : ${globalController.fetchedQRData[0]['fabrication']}\nComposition : ${globalController.fetchedQRData[0]['composition']}\nColor : ${globalController.fetchedQRData[0]['color']}\nGSM : ${globalController.fetchedQRData[0]['gsm']}\nDIA : ${globalController.fetchedQRData[0]['dia']}\n Technical Info : ${globalController.fetchedQRData[0]['technical_info']}\n\n");
        k++;
      }
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

    //Color Splitting
    splitValue = modifiedValue.split('Color');
    temporaryString = '';
    for (int i = 0; i < splitValue.length - 1; i++) {
      temporaryString += '${splitValue[i]}\nColor';
    }
    temporaryString += splitValue[splitValue.length - 1];
    modifiedValue = temporaryString;

    // temporaryString = '';
    // splitValue = modifiedValue.split('GSM');
    // int indexOfColon = splitValue[1].indexOf(":");
    // List parts = [splitValue[1].substring(0, indexOfColon).trim(), splitValue[1].substring(indexOfColon + 1).trim()];
    // temporaryString = '${splitValue[0]} : ${parts[0]} \nGSM : ${parts[1]}';
    // // ll(temporaryString);
    // modifiedValue = temporaryString;
    // ll(modifiedValue);

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
      temporaryString = modifyExtractedText(splitValue, temporaryString);
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
    temporaryString = "${mainStringSplit[0]}$extractedValue\n\nTechnical Info${mainStringSplit[1]}";
    List<String> withoutDuplicate = splitValue[splitValue.length - 1].toString().split(extractedValue);
    //
    // List<String> temp1 = temporaryString.split('Color');
    // List<String> temp2 = temp1[1].split('GSM');
    // temporaryString = '${temp1[0]}\nColor${temp2[1]}';
    // ll(temporaryString);
    // List<String> temp3 = temporaryString.split('GSM');
    // temporaryString = "${temp3[0]}${temp3[1]}";
    return (temporaryString + (withoutDuplicate[0] + withoutDuplicate[1].substring(1)));
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final RxString qrResult = RxString("");
  QRViewController? gQrController;
  RxBool isScanning = RxBool(false);
  final RxList<RxString> qrTextList = RxList([''.obs]);
  final RxList<RxBool> isQREditingModeList = RxList([false.obs]);
  final RxList<TextEditingController> qrTextEditorList = RxList([TextEditingController()]);
  final RxList<FocusNode> qrTextFocusNodeList = RxList([FocusNode()]);
  final RxList dataList = RxList([]);
  final RxBool isEmptyLoading = RxBool(false);
  RxBool isSaveButtonEnabled = RxBool(true);
  RxBool isMerchandiserButtonEnabled = RxBool(false);
  RxBool isBuyerButtonEnabled = RxBool(false);

  resetQRData() {
    dataList.clear();
    qrTextList.clear();
    isSaveButtonEnabled.value = true;
    isMerchandiserButtonEnabled.value = false;
    isBuyerButtonEnabled.value = false;
    qrTextList.add(''.obs);
    fetchedQRData.clear();
  }

  void onQRViewCreated(QRViewController qrController) async {
    isEmptyLoading.value = true;
    gQrController = qrController;
    if (Platform.isAndroid) {
      await gQrController!.resumeCamera();
    }
    gQrController!.scannedDataStream.listen((scanData) async {
      qrResult.value = scanData.code.toString();
      await gQrController!.pauseCamera();
      isScanning.value = false;
      isEmptyLoading.value = false;
      bool isBarCodeExist = false;
      for (int i = 0; i < qrTextList.length; i++) {
        if (qrTextList[i].value == qrResult.value) {
          isBarCodeExist = true;
          break;
        }
      }
      if (isBarCodeExist) {
        showSnackBar("Warning", "Duplicate barcode scanned", cWarningColor);
        return;
      }
      bool status = await fetchQRData(qrResult.value);
      // bool status = true;
      if (status) {
        setQRText(qrResult.value, qrTextList.length - 1);
        log(qrResult.value.toString());
        // log(qrTextList.toString());
        isSaveButtonEnabled.value = true;
        isMerchandiserButtonEnabled.value = false;
        isBuyerButtonEnabled.value = false;
      }
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {}
  }

  setQRText(String text, index) {
    isEmptyLoading.value = true;
    HomeController homeController = Get.find<HomeController>();
    qrTextList[index].value = text;
    homeController.isEmptyLoading.value = false;
    dataList.add({
      'BARCODE_NO': qrTextList[index].value,
    });
    qrTextList.add(''.obs);
    qrTextEditorList.add(TextEditingController());
    qrTextFocusNodeList.add(FocusNode());
    isQREditingModeList.add(false.obs);
  }

  toggleEditingMode(index) {
    if (isQREditingModeList[index].value == true) {
      qrTextList[index].value = qrTextEditorList[index].text;
      dataList[index]['BARCODE_NO'] = qrTextEditorList[index].text;
    } else {
      qrTextEditorList[index].text = qrTextList[index].value;
      qrTextFocusNodeList[index].requestFocus();
    }
    isQREditingModeList[index].value = !isQREditingModeList[index].value;
  }

  deleteQRData(index) {
    dataList.removeAt(index);
    qrTextList.removeAt(index);
    isMerchandiserButtonEnabled.value = false;
    isBuyerButtonEnabled.value = false;
    // textEditorList.removeAt(index);
  }

  void showDeleteDialog(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DeleteConfirmPopUp(
            index: index,
            onDelete: () {
              deleteQRData(index);
              Get.back();
            },
          ),
        );
      },
    );
  }

  void showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Container(
                height: 180,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                      child: Text('Are you sure you want to reset all data?', textAlign: TextAlign.center, style: kTSPopUpMessage),
                    ),
                    kSizedBox10,
                    CustomButton(
                      color: kCRedAccent,
                      widget: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 4,
                      navigation: () {
                        resetQRData();
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.cancel)),
              )
            ],
          ),
        );
      },
    );
  }

  //* info:: show loading
  final isLoading = RxBool(false);

  void showLoading() {
    isLoading.value = true;
    Get.defaultDialog(
      radius: 2,
      backgroundColor: kCWhite,
      barrierDismissible: false,
      title: "",
      onWillPop: () async {
        return true;
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpinKitFadingCircle(
            color: kCDefaultColor1,
            size: 70.0,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              ksLoading.tr,
              style: const TextStyle(color: kCBlack, fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Api call for qr data fetch

  final RxList fetchedQRData = RxList([]);
  Future<dynamic> fetchQRData([qrCode = '']) async {
    try {
      final ApiController apiController = ApiController();
      //String suffixUrl = '';
      String suffixUrl = '$qrCode';
      var response = await apiController.commonGet(token: null, url: qrCodeDataFetch + suffixUrl, showLoading: true);
      // log("CARD SCAN RESULT: $response");
      if (response['status'] == true) {
        log(response['resultset'].toString());
        fetchedQRData.addAll(response['resultset']);
        log(fetchedQRData.length.toString());
        showSnackBar("Success", "Barcode scanned successfully", cAcceptColor);
        return true;
      } else {
        log(response.toString());
        showSnackBar("Error", "Barcode not found", cRedAccentColor);
        return false;
      }
    } catch (e) {
      ll(e.toString());
      return false;
    }
  }

  Future<void> saveAllData(allData) async {
    try {
      final ApiController apiController = ApiController();
      log("body :$allData");
      var response = await apiController.commonPostWithBodyDio(token: null, url: saveCardQRData, body: allData, showLoading: true);
      log(response.toString());
      if (response['status'] == true) {
        log(response['resultset'].toString());
        Get.find<HomeController>().isHangerPageButtonEnabled.value = true;
        isMerchandiserButtonEnabled.value = true;
        isBuyerButtonEnabled.value = false;
        isScanning.value = false;
        isSaveButtonEnabled.value = false;
        showSnackBar("Success", response['resultset'][0]['msg'].toString(), cAcceptColor);
      } else {
        log(response.toString());
        showSnackBar("Error", "Something went wrong", cRedAccentColor);
      }
    } catch (e) {
      ll(e.toString());
    }
  }
}
