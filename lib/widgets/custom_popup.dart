import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void showCustomDialog(BuildContext context) {
  HomeController homeController = Get.find<HomeController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Image Source',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt_rounded),
                    onPressed: () async {
                      //show loading
                      Navigator.of(context).pop();
                      Get.find<HomeController>().isLoading.value = true;
                      await homeController.getImage(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Get.find<HomeController>().isLoading.value = true;
                      await homeController.getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showDeleteDialog(BuildContext context) {
  HomeController homeController = Get.find<HomeController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Container(
              height: 190,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                    child: Text(
                      'Are you sure you want to delete?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                      color: Colors.redAccent,
                      widget: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                      height: 40,
                      width: 85,
                      navigation: () {
                        homeController.resetData();
                        Get.back();
                      }),
                ],
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.cancel)),
            )
          ],
        ),
      );
    },
  );
}
