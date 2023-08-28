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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            Get.find<GlobalController>().showSnackBar("Success", "Successfully logged out", cAcceptColor);
          },
        ),
      ),
      body: Column(
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
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
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
            navigation: () {
              Get.find<HomeController>().resetData();
              Get.find<GlobalController>().resetQRData();
              Get.find<HomeController>().origin.value = 'card';
              Get.to(() => CardScanScreen());
            },
          ),
        ],
      ),
    );
  }
}
