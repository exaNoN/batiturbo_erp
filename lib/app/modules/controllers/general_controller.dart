import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'job_controller.dart';
export 'customer_controller.dart';
export 'turbo_controller.dart';

showSnackBar(String title, String message, Color backgroundColor) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white);
}
