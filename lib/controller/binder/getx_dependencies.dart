import 'package:bpg_erp/controller/auth_controller.dart';
import 'package:bpg_erp/controller/common/global_controller.dart';
import 'package:bpg_erp/controller/home_controller.dart';
import 'package:get/get.dart';

class AllControllerBinder implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<AuthController>(AuthController());
    Get.put<GlobalController>(GlobalController());
  }
}
