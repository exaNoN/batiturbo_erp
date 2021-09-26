import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'app/modules/controllers/general_controller.dart';
import 'app/modules/routes/app_pages.dart';

//5057120634adsl@turk.net
//2b549f364e

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var jobC = Get.put(JobController());
  jobC.fetchJobs();
  var customerC = Get.put(CustomerController());
  customerC.fetchCustomers();
  var turboC = Get.put(TurboController());
  turboC.fetchTurbos();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: "BatıTurboERP",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
