import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDeleteDialog(BuildContext context, index) {
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
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
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
                      width: MediaQuery.of(context).size.width / 3,
                      navigation: () {
                        //homeController.resetData();
                        homeController.deleteData(index);
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
