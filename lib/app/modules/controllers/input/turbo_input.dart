import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurboInput extends GetxController {
  final GlobalKey<FormState> turboFormKey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    codeController.dispose();
    descriptionController.dispose();
  }

  //validations
  String? validateCode(String value) {
    if (value.length < 2) {
      return "Turbo kodu 2 harften fazla olmalı";
    }
    return null;
  }

  String? validateDescribe(String value) {
    if (value.length < 2) {
      return "Lütfen açıklama giriniz";
    }
    return null;
  }

  bool checkSave() {
    final isValid = turboFormKey.currentState!.validate();
    if (!isValid) return false;
    turboFormKey.currentState!.save();
    return true;
  }
}
