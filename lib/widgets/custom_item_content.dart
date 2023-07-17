import 'dart:io';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/widgets/custom_popup.dart';
import 'package:bpg_erp/widgets/custom_textfield1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItemContent extends StatelessWidget {
  final String itemType;

  CustomItemContent({super.key, required this.itemType});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: homeController.isImageUploaded.value
            ? const BoxDecoration(
                color: Colors.black12,
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            children: [
              if (homeController.isImageUploaded.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        itemType + (0 + 1).toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => homeController.isLoading.value
                    ? CircularProgressIndicator()
                    : Stack(
                        children: [
                          Container(
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
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : const Text(
                                          'No text to show',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                  if (homeController.scannedText.value != '')
                                    const Divider(
                                      indent: 100,
                                      endIndent: 100,
                                      color: Colors.black,
                                      thickness: 0.6,
                                    ),
                                  if (homeController.scannedText.value != '' &&
                                      homeController.isEditingMode.value)
                                    CustomTextField1(
                                        controller: homeController.textEditor),
                                  if (homeController.scannedText.value != '' &&
                                      !homeController.isEditingMode.value)
                                    Text(
                                      homeController.scannedText.value,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          homeController.scannedText.value != ''
                              ? Positioned(
                                  top: 3,
                                  right: 3,
                                  child: Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        homeController.toggleEditingMode();
                                      },
                                      icon: homeController.isEditingMode.value
                                          ? const Icon(
                                              Icons.check_circle_rounded)
                                          : const Icon(Icons.edit_square),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
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
                          Image.file(File(homeController.imageFile!.path))
                      ],
                    ),
                  ),
                ),
              ),
              homeController.isImageUploaded.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 12),
                      child: InkWell(
                        onTap: () {
                          showDeleteDialog(context);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.red,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
