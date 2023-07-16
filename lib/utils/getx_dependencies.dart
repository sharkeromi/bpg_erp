import 'package:bpg_erp/controller/home_controller.dart';
import 'package:get/get.dart';

class AllControllerBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}