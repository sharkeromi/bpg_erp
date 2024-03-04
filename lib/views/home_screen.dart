import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/controller/common/global_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/utils/const/url.dart';
import 'package:bpg_erp/views/card_scan_screen.dart';
import 'package:bpg_erp/views/login_screen.dart';
import 'package:bpg_erp/views/widgets/custom_appbar.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: CustomAppBar(
          leading: null,
          title: 'DashBoard Activity',
          prefixWidget: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
          ),
          prefixWidgetAction: () {
            Get.offAll(() => LogInScreen());
            Get.find<AuthController>().resetAuthFieldValues();
            Get.find<GlobalController>().showSnackBar("Success", "Successfully logged out", cAcceptColor);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              homePageSky,
              fit: BoxFit.cover,
            ),
            Image.asset(homePageLeaves),
            kSizedBox20,
            CustomButton(
              height: 180,
              gradient: kGDefaultGradient,
              width: (MediaQuery.of(context).size.width / 2) - 24,
              widget: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.document_scanner_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                  kSizedBox10,
                  Text(
                    "Card & \nHanger Scan",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              navigation: () async{
                Get.find<HomeController>().resetData();
                Get.find<GlobalController>().resetQRData();
                Get.find<HomeController>().origin.value = 'card';
                Get.to(() => CardScanScreen());
                //* Open camera function
                await homeController.getImage(ImageSource.camera, homeController.imageList.length);
                //* Open pop up for camera and gallery
                // homeController.showCustomDialog( context, homeController.imageList.length);
              },
            ),
            kSizedBox20,
          ],
        ),
      ),
    );
  }
}
