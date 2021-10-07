import 'package:batiturbo_erp/app/views/pages/z_pages.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(name: Paths.home, page: () => HomePage()),
    GetPage(name: Paths.createJob, page: () => CreateJobPage()),
    //GetPage(name: Paths.customerP, page: () => CustomerPage())
    //GetPage(name: Paths.paymentP page: () => Payement)
  ];
}
