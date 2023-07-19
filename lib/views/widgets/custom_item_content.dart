import 'dart:io';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/custom_textfield1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItemContent extends StatelessWidget {
  CustomItemContent({
    super.key,
    required this.itemType,
    required this.index,
  });

  final String itemType;
  final int index;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      itemType + (index + 1).toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              kSizedBox10,
              Stack(
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
                            Column(
                              children: [
                                homeController.scannedTextList[index].value !=
                                        ''
                                    ? Text(
                                        'Result',
                                        style: extractedTextStyle.copyWith(
                                            fontWeight: FontWeight.w700),
                                      )
                                    : const Text(
                                        'No text to show',
                                        style: extractedTextStyle,
                                      ),
                                if (homeController
                                        .scannedTextList[index].value !=
                                    '')
                                  const Divider(
                                    indent: 100,
                                    endIndent: 100,
                                    color: Colors.black,
                                    thickness: 0.6,
                                  ),
                              ],
                            ),
                            if (homeController.scannedTextList[index].value !=
                                '')
                              const SizedBox(height: 15),
                            if (homeController.scannedTextList[index].value !=
                                    '' &&
                                homeController.isEditingModeList[index].value)
                              CustomTextField1(
                                controller:
                                    homeController.textEditorList[index],
                                index: index,
                              ),
                            if (homeController.scannedTextList[index].value !=
                                    '' &&
                                !homeController.isEditingModeList[index].value)
                              Text(
                                homeController.imageList[index]['text'],
                                style: extractedTextStyle,
                                textAlign: TextAlign.left,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  homeController.scannedTextList[index].value != ''
                      ? Positioned(
                          top: 3,
                          right: 3,
                          child: Obx(
                            () => IconButton(
                              onPressed: () {
                                homeController.toggleEditingMode(index);
                              },
                              icon:
                                  homeController.isEditingModeList[index].value
                                      ? const Icon(Icons.check_circle_rounded)
                                      : const Icon(Icons.edit_square),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              kSizedBox10,
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    () => Column(
                      children: [
                        Text(
                          'Uploaded image',
                          style: extractedTextStyle.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                        kSizedBox10,
                        Image.file(
                          File(
                            homeController.imageList[index]['image'],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 12),
                child: InkWell(
                  onTap: () {
                    homeController.showDeleteDialog(context, index);
                  },
                  child: Text(
                    'Delete',
                    style: textStyle.copyWith(color: Colors.red, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
