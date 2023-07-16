import 'dart:io';

import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/widgets/custom_button.dart';
import 'package:bpg_erp/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HangerScanScreen extends StatelessWidget {
  HangerScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        height: 65,
        width: 250,
        widget: const Text(
          'Send to buyer',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        navigation: () {},
      ),
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Card to text",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0096b5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 100,
                  width: 100,
                  widget: const Padding(
                    padding: EdgeInsets.only(bottom: 6.0, right: 4),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  navigation: () {
                    showCustomDialog(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Click here to upload image',
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                // for (int i = 0; i < homeController.imageList.length; i++)
                Obx(
                  () => Container(
                    decoration: homeController.isImageUploaded.value
                        ? BoxDecoration(
                            color: Colors.black12,
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Column(
                        children: [
                          if (homeController.isImageUploaded.value)
                            Text(
                              'Item' + (0 + 1).toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => homeController.isLoading.value
                                ? CircularProgressIndicator()
                                : Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          homeController.scannedText.value != ''
                                              ? const Text(
                                                  'Result',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )
                                              : const Text(
                                                  'No text to show',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                          if (homeController
                                                  .scannedText.value !=
                                              '')
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          if (homeController
                                                  .scannedText.value !=
                                              '')
                                            Text(
                                              homeController.scannedText.value,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          // Extracted Text
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width,
                            //height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Obx(
                                () => Column(
                                  children: [
                                    homeController.isImageUploaded.value
                                        ? const Text(
                                            'Uploaded image',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        : const Text(
                                            'No image uploaded yet',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                    if (homeController.isImageUploaded.value)
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    if (homeController.isImageUploaded.value)
                                      Image.file(
                                          File(homeController.imageFile!.path))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
