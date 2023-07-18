import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/views_beta/home_screen.dart';
import 'package:bpg_erp/views_beta/widgets/custom_button.dart';
import 'package:bpg_erp/views_beta/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/bgplogo.png",
                  height: 150,
                  width: 200,
                ),
                const Text(
                  'User Login',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: authController.url,
                  hintText: 'URL (Optional)',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: authController.bpg,
                  hintText: 'BPG',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: authController.password,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  height: 45,
                  width: 200,
                  gradient: const LinearGradient(colors: [
                    Color(0xFF60CCD9),
                    Color(0xFF0096b5),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  navigation: () {
                    Get.offAll(() => const HomeScreen());
                  },
                  widget: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
