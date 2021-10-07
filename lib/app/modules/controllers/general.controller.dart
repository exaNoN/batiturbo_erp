import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String message, Color backgroundColor) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white);
}

class GeneralInputController extends GetxController {
  var returnCustomerId = "".obs;
  var returnTurboId = "".obs;
}
