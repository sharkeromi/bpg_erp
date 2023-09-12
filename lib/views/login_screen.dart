import 'package:bpg_erp/utils/const/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/styles.dart';
import 'package:bpg_erp/views/widgets/custom_button.dart';
import 'package:bpg_erp/views/widgets/custom_textfield.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCBackgroundColor,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kSizedBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      //logo,
                      logo1,
                      height: 100,
                      width: 160,
                      // color: kCDefaultColor2,
                    ),
                  ],
                ),
                kSizedBox20,
                const Text(
                  'User Login',
                  style: kTSLogInScreenHeader,
                  textAlign: TextAlign.center,
                ),
                kSizedBox20,
                // Container(
                //   height: 45,
                //   decoration: kTextFieldDecoration,
                //   child: CustomTextField(
                //     controller: authController.url,
                //     hintText: 'URL (Optional)',
                //   ),
                // ),
                // kSizedBox20,
                Container(
                  height: 45,
                  decoration: kTextFieldDecoration,
                  child: CustomTextField(
                    controller: authController.userName,
                    hintText: 'User name',
                  ),
                ),
                kSizedBox20,
                Obx(
                  () => Stack(
                    children: [
                      Container(
                        height: 45,
                        decoration: kTextFieldDecoration,
                        child: CustomTextField(
                          controller: authController.password,
                          hintText: 'Password',
                          obscureText: authController.isObscureOn.value,
                          textInputAction: TextInputAction.done,
                          rightContentPadding: 35,
                        ),
                      ),
                      Positioned(
                          top: 12,
                          bottom: 12,
                          right: 10,
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              authController.isObscureOn.value =
                                  !authController.isObscureOn.value;
                            },
                            child: Icon(
                              !authController.isObscureOn.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20,
                            ),
                          ))
                    ],
                  ),
                ),
                kSizedBox40,
                CustomButton(
                  height: 45,
                  width: 200,
                  gradient: kGDefaultGradient,
                  navigation: () async {
                    await authController.userLogin();
                    //Get.to(() => const HomeScreen());
                  },
                  widget: const Text(
                    'Log In',
                    style: kTSDefaultStyle,
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
