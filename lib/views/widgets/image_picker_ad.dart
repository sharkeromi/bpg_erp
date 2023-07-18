import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/utils/const/value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerAD extends StatelessWidget {
  final int index;
  final HomeController homeController;

  const ImagePickerAD({super.key, required this.index, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Select Image Source',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: blackColor,
                    size: closeIconSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 80,
                height: 100,
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    await homeController.getImage(ImageSource.camera, index);
                  },
                  style: kTextButtonStyle,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: iconSize,
                      ),
                      Text(
                        'Camera',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 80,
                height: 100,
                child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () async {
                    Get.back();
                    await homeController.getImage(ImageSource.gallery, index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.image_rounded,
                        size: iconSize,
                      ),
                      Text(
                        'Gallery',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
