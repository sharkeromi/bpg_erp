import 'dart:io';

import 'package:bpg_erp/controller/global_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/views_beta/widgets/custom_appbar.dart';
import 'package:bpg_erp/views_beta/widgets/custom_button.dart';
import 'package:bpg_erp/views_beta/widgets/custom_item_content.dart';
import 'package:bpg_erp/views_beta/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardScanScreen extends StatelessWidget {
  CardScanScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final GlobalController globalController = Get.find<GlobalController>();

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
          'Send to \nmerchandiser',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        navigation: () {
          globalController.saveDataSP(homeController.imageList);
        },
      ),
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: CustomAppBar(
          title: 'Visiting Card Scan',
          prefixWidget: const Text(
            'Reset',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          prefixWidgetAction: () {
            //Reset Data
            globalController.resetSharedPreference();
            homeController.resetData();
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
                      homeController.showCustomDialog(
                          context, homeController.imageList.length);
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
                              //homeController.isEditingModeList[index].value = false;
                              homeController.showCustomDialog(
                                  context, homeController.imageList.length);
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
                  if (homeController.isEmptyLoading.value)
                    const SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  for (int i = homeController.imageList.length - 1; i >= 0; i--)
                    CustomItemContent(
                      itemType: "Card ",
                      index: i,
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
