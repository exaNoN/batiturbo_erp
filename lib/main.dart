import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'app/modules/controllers/api_controllers.dart';
import 'app/routes/app_pages.dart';

//5057120634adsl@turk.net
//2b549f364e

void main() {
  initServices();
  Future.delayed(const Duration(milliseconds: 300));
  runApp(MyApp());
}

initServices() async {
  await Get.putAsync<JobController>(() => JobController().init());
  await Get.putAsync<CustomerController>(() => CustomerController().init());
  await Get.putAsync<PaymentController>(() => PaymentController().init());
  await Get.putAsync<TaskController>(() => TaskController().init());
  await Get.putAsync<TurboController>(() => TurboController().init());
  await Get.putAsync<UserController>(() => UserController().init());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "BatıTurboERP",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
