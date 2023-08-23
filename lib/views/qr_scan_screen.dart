import 'package:bpg_erp/controller/common/global_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/common_tapable_panel.dart';
import 'package:bpg_erp/views/widgets/custom_appbar.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatelessWidget {
  QRScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: kCBackgroundColor,
        floatingActionButton: homeController.imageList.isEmpty
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5),
                      child: CustomButton(
                        height: 45,
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        gradient: globalController.isMerchandiserButtonEnabled.value ? kGDefaultGradient : kGGreyGradient,
                        widget: Text(
                          'Send to merchandiser',
                          textAlign: TextAlign.center,
                          style: kTSDefaultStyle.copyWith(fontSize: 16),
                        ),
                        navigation: globalController.isMerchandiserButtonEnabled.value
                            ? () async {
                                globalController.shareImageAndText('card');
                              }
                            : null,
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 10),
                      child: CustomButton(
                        height: 45,
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        gradient: globalController.isBuyerButtonEnabled.value ? kGDefaultGradient : kGGreyGradient,
                        widget: Text(
                          'Send to Buyer',
                          textAlign: TextAlign.center,
                          style: kTSDefaultStyle.copyWith(fontSize: 16),
                        ),
                        navigation: globalController.isBuyerButtonEnabled.value
                            ? () {
                                globalController.shareImageAndText('hanger');
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: Obx(
            () => CustomAppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              title: 'QR Scan',
              prefixWidget: homeController.imageList.isEmpty
                  ? null
                  : const Text(
                      'Save',
                      style: kTSPopUpHeader,
                    ),
              prefixWidgetAction: () async {
                if (globalController.dataList.isNotEmpty) {
                  Map<String, dynamic> tempMap = {
                    'vcs': [
                      {
                        'email': homeController.emailEditingController.text.trim(),
                        'NAME': homeController.nameEditingController.text.trim(),
                        'CARD_INFO': homeController.imageList,
                      }
                    ],
                    'hanger': globalController.dataList,
                  };
                  await globalController.saveAllData(tempMap);
                  // await globalController.saveDataSP(tempMap);
                  homeController.isHangerPageButtonEnabled.value = true;
                  globalController.isMerchandiserButtonEnabled.value = true;
                  globalController.isBuyerButtonEnabled.value = true;
                  globalController.isScanning.value = false;
                  // await globalController.resetSharedPreference();
                } else {
                  globalController.showSnackBar("Warning!", "No data to save.\nPlease scan any barcode to save.", Colors.amber[400]!);
                }
              },
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Obx(
                () => Column(
                  children: [
                    if (globalController.isScanning.value)
                      SizedBox(
                        height: 280,
                        child: QRView(
                          key: globalController.qrKey,
                          onQRViewCreated: globalController.onQRViewCreated,
                          overlay: QrScannerOverlayShape(
                            borderColor: kCBackgroundColor,
                            borderRadius: 10,
                            borderLength: 30,
                            borderWidth: 10,
                            cutOutSize: 200,
                          ),
                          onPermissionSet: (ctrl, p) => globalController.onPermissionSet(context, ctrl, p),
                        ),
                      ),
                    if (!globalController.isScanning.value)
                      CommonTapablePanel(
                        instruction: "Click here to scan barcode",
                        onTap: () {
                          globalController.isScanning.value = true;
                        },
                      ),
                    kSizedBox10,
                    if (globalController.isScanning.value) kSizedBox10,
                    if (globalController.isScanning.value)
                      CustomButton(
                        color: kCRed,
                        widget: Text(
                          "Cancel",
                          style: kTSDefault1.copyWith(color: kCWhite),
                        ),
                        height: 35,
                        navigation: () {
                          globalController.isScanning.value = false;
                        },
                        width: 120,
                      ),
                    if (globalController.isScanning.value)
                      SizedBox(
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Waiting for image to scan  ',
                                style: kTSDefault1,
                              ),
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    if (globalController.isScanning.value) kSizedBox10,
                    if (globalController.isScanning.value)
                      const Divider(
                        height: 1,
                        color: kCBlack,
                      ),
                    if (globalController.isScanning.value) kSizedBox10,
                    if (globalController.dataList.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: kTextButtonStyleDefault,
                            onPressed: () {
                              globalController.showResetDialog(context);
                              // globalController.resetQRData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                'Reset',
                                style: kTSPopUpHeader.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    kSizedBox10,
                    if (globalController.dataList.isEmpty)
                      const SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "No barcode scanned yet",
                            style: kTSDefault1,
                          ),
                        ),
                      ),
                    for (int i = globalController.dataList.length - 1; i >= 0; i--)
                      QRScanContent(
                        itemType: "QR Data",
                        index: i,
                      ),
                    kSizedBox80
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QRScanContent extends StatelessWidget {
  QRScanContent({
    super.key,
    required this.itemType,
    required this.index,
  });

  final String itemType;
  final int index;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: Stack(
        children: [
          Obx(
            () => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$itemType ${index + 1}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Barcode : ${globalController.dataList[index]['BARCODE_NO']}",
                      style: kTSExtractedText.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Hanger No : ${globalController.fetchedQRData[0]['Hanger No']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Reference : ${globalController.fetchedQRData[0]['Reference']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Fabrication : ${globalController.fetchedQRData[0]['Fabrication']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Composition : ${globalController.fetchedQRData[0]['Composition']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "GSM : ${globalController.fetchedQRData[0]['GSM']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "DIA : ${globalController.fetchedQRData[0]['DIA']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Technical Info : ${globalController.fetchedQRData[0]['Technical Info']}",
                                    style: kTSExtractedText.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //const SizedBox(),
          Positioned(
            top: 20,
            right: 10,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                size: 35,
                color: Colors.red,
              ),
              onPressed: () {
                globalController.showDeleteDialog(context, index);
              },
            ),
          )
        ],
      ),
    );
  }
}
