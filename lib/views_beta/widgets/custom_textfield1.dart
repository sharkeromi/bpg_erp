import 'package:bpg_erp/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField1 extends StatelessWidget {
  final TextEditingController controller;
  final HomeController homeController = Get.find<HomeController>();
  CustomTextField1({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 20),
      onSubmitted: (value) {
        homeController.scannedText.value = value;
      },
      focusNode: homeController.textFocusNode,
      textInputAction: TextInputAction.done,
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 6, 10, 12),
        border: InputBorder.none,
        fillColor: Colors.black,
      ),
    );
  }
}
