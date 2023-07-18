import 'package:bpg_erp/utils/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  final Widget prefixWidget;

  final VoidCallback prefixWidgetAction;

  const CustomAppBar({super.key, required this.title, required this.prefixWidget, required this.prefixWidgetAction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: kCDefaultColor2,
      title: Text(
        title,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          onPressed: prefixWidgetAction,
          child: Padding(padding: const EdgeInsets.only(right: 16.0), child: prefixWidget),
        ),
      ],
    );
  }
}
