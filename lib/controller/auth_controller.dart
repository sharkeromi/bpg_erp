import 'dart:developer';

import 'package:bpg_erp/controller/common/api_controller.dart';
import 'package:bpg_erp/controller/common/global_controller.dart';
import 'package:bpg_erp/utils/const/color.dart';
import 'package:bpg_erp/utils/const/url.dart';
import 'package:bpg_erp/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final GlobalController _globalController = Get.find<GlobalController>();
  TextEditingController url = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  final ApiController _apiController = ApiController();

  final RxBool isObscureOn = RxBool(true);

  resetAuthFieldValues() {
    userName.clear();
    password.clear();
    isObscureOn.value = true;
  }

  Future<void> userLogin() async {
    try {
      if (userName.text.trim() == '') {
        if (!Get.isSnackbarOpen) {
          _globalController.showSnackBar("Warning", "User name missing", cWarningColor);
        }

        return;
      } else if (password.text.trim() == '') {
        if (!Get.isSnackbarOpen) {
          _globalController.showSnackBar("Warning", "password missing", cWarningColor);
        }
        return;
      }
      String suffixUrl = '?user_id=${userName.text}&pwd=${password.text}';
      var response = await _apiController.commonGet(token: null, url: loginUrl + suffixUrl, showLoading: true);
      log(response.toString());
      if (response['status'] == true) {
        Get.offAll(() =>  HomeScreen());
        _globalController.showSnackBar("Success", "Login Successful", cAcceptColor);
      } else {
        log(response.toString());
        _globalController.showSnackBar("Error", "Something went wrong", cRedAccentColor);
      }
    } catch (e) {
      log('User login error : $e');
    }
  }
}
