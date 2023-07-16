import 'package:bpg_erp/controller/home_controller.dart';
import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/views_beta/card_scan_screen.dart';
import 'package:bpg_erp/views_beta/hanger_scan_screen.dart';
import 'package:bpg_erp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0096b5),
        title: const Text(
          'Dashboard Activity',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/sky.png",
            fit: BoxFit.cover,
          ),
          Image.asset("assets/images/leaves.png"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: CustomButton(
                  height: 180,
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.document_scanner_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Visiting Card Scan",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  navigation: () {
                    Get.find<HomeController>().resetData();
                    Get.to(() => CardScanScreen());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: CustomButton(
                  height: 180,
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.dry_cleaning_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hangar Scan",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  navigation: () {
                    Get.find<HomeController>().resetData();
                    Get.to(() => HangerScanScreen());
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
