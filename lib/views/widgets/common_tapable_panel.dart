import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTapablePanel extends StatelessWidget {
  CommonTapablePanel({
    super.key, this.onTap, this.instruction,
  });

  final HomeController homeController = Get.find<HomeController>();
  final String? instruction;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap??() {
        homeController.showCustomDialog(
            context, homeController.imageList.length);
      },
      child: Column(
        children:  [
          kSizedBox20,
          const CustomButton(
            height: 100,
            width: 100,
            gradient: kGDefaultGradient,
            widget: Padding(
              padding: EdgeInsets.only(bottom: 6.0, right: 4),
              child: Icon(
                Icons.add_a_photo_rounded,
                color: kCWhite,
                size: 60,
              ),
            ),
            navigation: null,
          ),
          kSizedBox10,
          Text(
            instruction??'Click here to upload image',
            style: const TextStyle(fontSize: 16),
          ),
          kSizedBox10,
          const Divider(
            height: 1,
            color: kCBlack,
          ),
        ],
      ),
    );
  }
}
