import 'package:bpg_erp/controller/global_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/common_tapable_panel.dart';
import 'package:bpg_erp/views/widgets/custom_appbar.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:bpg_erp/views/widgets/custom_item_content.dart';
import 'package:bpg_erp/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HangerScanScreen extends StatelessWidget {
  HangerScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: kCBackgroundColor,
        resizeToAvoidBottomInset: false,
        floatingActionButton: homeController.imageList.isEmpty
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 5),
                        child: CustomButton(
                          height: 45,
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          gradient: homeController.isSaveButtonEnabled.value ? kGDefaultGradient : kGGreyGradient,
                          widget: Text(
                            'Send to merchandiser',
                            textAlign: TextAlign.center,
                            style: kTSDefaultStyle.copyWith(fontSize: 16),
                          ),
                          navigation: homeController.isSaveButtonEnabled.value
                              ? () async {
                                  var tempMap = {
                                    'email': homeController.emailEditingController.text.trim(),
                                    'name': homeController.nameEditingController.text.trim(),
                                    'imageData': homeController.imageList
                                  };
                                  await globalController.saveDataSP(tempMap);
                                  homeController.isHangerPageButtonEnabled.value = true;
                                }
                              : null,
                        ),
                      )),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 10),
                      child: CustomButton(
                        height: 45,
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        gradient: homeController.isHangerPageButtonEnabled.value ? kGDefaultGradient : kGGreyGradient,
                        widget: Text(
                          'Send to Buyer',
                          textAlign: TextAlign.center,
                          style: kTSDefaultStyle.copyWith(fontSize: 16),
                        ),
                        navigation: homeController.isHangerPageButtonEnabled.value
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
              title: 'Hanger Scan',
              prefixWidget: homeController.imageList.isEmpty
                  ? null
                  : const Text(
                      'Save',
                      style: kTSPopUpHeader,
                    ),
              prefixWidgetAction: () async {
                var tempMap = {
                  'email': homeController.emailEditingController.text.trim(),
                  'name': homeController.nameEditingController.text.trim(),
                  'imageData': homeController.imageList
                };
                await globalController.saveDataSP(tempMap);
                homeController.isHangerPageButtonEnabled.value = true;
                // homeController.showResetConfirmDialog(context);
                // await globalController.resetSharedPreference();
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
                      Container(
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
                        onTap: () {
                          globalController.isScanning.value = true;
                        },
                      ),
                    kSizedBox10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: kTextButtonStyleDefault,
                          onPressed: () async {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              'Reset',
                              style: kTSPopUpHeader.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   height: 40,
                    //   width: MediaQuery.of(context).size.width - 50,
                    //   decoration: kTextFieldDecoration.copyWith(color: kCWhite, borderRadius: BorderRadius.circular(15)),
                    //   child: CustomTextField(
                    //     hintText: 'Name',
                    //     onChanged: (v) {
                    //       homeController.nameEmailValidation();
                    //     },
                    //     hintTextStyle: kTSTextField2,
                    //     controller: homeController.nameEditingController,
                    //   ),
                    // ),
                    // kSizedBox10,
                    // Container(
                    //   height: 40,
                    //   width: MediaQuery.of(context).size.width - 50,
                    //   decoration: kTextFieldDecoration.copyWith(color: kCWhite, borderRadius: BorderRadius.circular(15)),
                    //   child: CustomTextField(
                    //     hintText: 'Email',
                    //     onChanged: (v) {
                    //       homeController.nameEmailValidation();
                    //     },
                    //     hintTextStyle: kTSTextField2,
                    //     textInputAction: TextInputAction.done,
                    //     controller: homeController.emailEditingController,
                    //   ),
                    // ),
                    kSizedBox10,
                    if (homeController.isEmptyLoading.value)
                      const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (homeController.imageList.isEmpty)
                      const SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "No image uploaded yet",
                            style: kTSDefault1,
                          ),
                        ),
                      ),
                    for (int i = homeController.imageList.length - 1; i >= 0; i--)
                      CustomItemContent(
                        itemType: "Hanger ",
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
