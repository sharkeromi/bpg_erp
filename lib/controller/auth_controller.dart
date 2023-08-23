import 'dart:developer';

import 'package:bpg_erp/controller/common/api_controller.dart';
import 'package:bpg_erp/utils/const/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController url = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  final ApiController _apiController = ApiController();

  Future<void> userLogin() async {
    try {
      String suffixUrl = '?user_id=${userName.text}&pwd=${password.text}';
      var response = await _apiController.commonGet(token: null, url: loginUrl + suffixUrl, showLoading: true);
      log(response.toString());
    } catch (e) {
      log('User login error : $e');
    }
  }
}
