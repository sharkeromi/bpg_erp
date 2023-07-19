import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField1 extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  final HomeController homeController = Get.find<HomeController>();
  CustomTextField1({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: extractedTextStyle,
      onSubmitted: (value) {
        homeController.scannedTextList[index].value = value;
      },
      focusNode: homeController.textFocusNodeList[index],
      textInputAction: TextInputAction.newline,
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 10,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 6, 10, 12),
        border: InputBorder.none,
        fillColor: blackColor,
      ),
    );
  }
}
