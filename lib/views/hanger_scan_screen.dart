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
                          height: 65,
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          gradient: homeController.isSaveButtonEnabled.value ? kGDefaultGradient : kGGreyGradient,
                          widget: const Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: kTSDefaultStyle,
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
                        height: 65,
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        gradient: homeController.isHangerPageButtonEnabled.value ? kGDefaultGradient : kGGreyGradient,
                        widget: const Text(
                          'Send to Buyer',
                          textAlign: TextAlign.center,
                          style: kTSDefaultStyle,
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
                      'Reset',
                      style: kTSPopUpHeader,
                    ),
              prefixWidgetAction: () async {
                homeController.showResetConfirmDialog(context);
                await globalController.resetSharedPreference();
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
                    CommonTapablePanel(),
                    kSizedBox10,
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: kTextFieldDecoration.copyWith(color: kCWhite, borderRadius: BorderRadius.circular(15)),
                      child: CustomTextField(
                        hintText: 'Name',
                        onChanged: (v) {
                          homeController.nameEmailValidation();
                        },
                        hintTextStyle: kTSTextField2,
                        controller: homeController.nameEditingController,
                      ),
                    ),
                    kSizedBox10,
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: kTextFieldDecoration.copyWith(color: kCWhite, borderRadius: BorderRadius.circular(15)),
                      child: CustomTextField(
                        hintText: 'Email',
                        onChanged: (v) {
                          homeController.nameEmailValidation();
                        },
                        hintTextStyle: kTSTextField2,
                        textInputAction: TextInputAction.done,
                        controller: homeController.emailEditingController,
                      ),
                    ),
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
