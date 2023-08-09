import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    required this.title,
    this.prefixWidget,
    required this.prefixWidgetAction,
  });

  final HomeController homeController = Get.find<HomeController>();

  final String title;
  final Widget? prefixWidget;
  final VoidCallback prefixWidgetAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Get.back();
            // homeController.resetData();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: kCDefaultColor2,
      title: Text(
        title,
        style: const TextStyle(
          color: kCWhite,
        ),
      ),
      actions: [
        TextButton(
          style: kTextButtonStyleDefault,
          onPressed: prefixWidgetAction,
          child: Padding(padding: const EdgeInsets.only(right: 16.0), child: prefixWidget ?? const SizedBox()),
        ),
      ],
    );
  }
}
