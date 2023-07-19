import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteConfirmPopUp extends StatelessWidget {
  DeleteConfirmPopUp({super.key, required this.index});

  final int index;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                child: Text('Are you sure you want to delete?',
                    textAlign: TextAlign.center, style: kSPopUpMessage),
              ),
              kSizedBox10,
              CustomButton(
                  color: Colors.redAccent,
                  widget: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 35,
                  width: MediaQuery.of(context).size.width / 4,
                  navigation: () {
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
    );
  }
}
