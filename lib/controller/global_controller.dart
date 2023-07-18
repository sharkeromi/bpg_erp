import 'package:bpg_erp/controller/sp_controller.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{

  SharedPreference sharedPreference = Get.put(SharedPreference());

  saveDataSP(value) async {
    await sharedPreference.saveImageData(value);
  }
}