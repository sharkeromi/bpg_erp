import 'dart:io';

import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/views_beta/widgets/custom_appbar.dart';
import 'package:bpg_erp/views_beta/widgets/custom_button.dart';
import 'package:bpg_erp/views_beta/widgets/custom_item_content.dart';
import 'package:bpg_erp/views_beta/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HangerScanScreen extends StatelessWidget {
  HangerScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        height: 65,
        width: 250,
        gradient: const LinearGradient(colors: [
          Color(0xFF60CCD9),
          Color(0xFF0096b5),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        widget: const Text(
          'Send to buyer',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        navigation: () {
          Get.snackbar(
            "Success",
            "Data send",
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.green,
            colorText: Colors.white,
            maxWidth: 400,
            snackPosition: SnackPosition.TOP,
          );
        },
      ),
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: CustomAppBar(
          title: 'Hanger Scan',
          prefixWidget: const Text(
            'Reset',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          prefixWidgetAction: () {
            homeController.resetData();
            //Reset data
          },
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Obx(
              () => Column(
                children: [
                  InkWell(
                    onTap: () {
                      homeController.showCustomDialog(context);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            height: 100,
                            width: 100,
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF60CCD9),
                                  Color(0xFF0096b5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            widget: const Padding(
                              padding: EdgeInsets.only(bottom: 6.0, right: 4),
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            navigation: () {
                              homeController.showCustomDialog(context);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Click here to upload image',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // for (int i = 0; i < homeController.imageList.length; i++)
                  CustomItemContent(
                    itemType: "Hanger ",
                    index: 0,
                  ),

                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
