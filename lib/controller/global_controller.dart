import 'package:bpg_erp/controller/sp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{

  SharedPreference sharedPreference = Get.put(SharedPreference());

  saveDataSP(value) async {
    await sharedPreference.saveImageData(value);
    showSnackBar("Success!", "Data send successfully.");
  }

  showSnackBar(String title, String message){
    return Get.snackbar(
            title,
            message,
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.green,
            colorText: Colors.white,
            maxWidth: 400,
            snackPosition: SnackPosition.TOP,
          );
  }

  resetSharedPreference() async {
    await sharedPreference.removeCache();
  }
}