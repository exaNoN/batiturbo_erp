import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobController>(() => JobController());
    Get.lazyPut<CustomerController>(() => CustomerController());
    Get.lazyPut<TurboController>(() => TurboController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
