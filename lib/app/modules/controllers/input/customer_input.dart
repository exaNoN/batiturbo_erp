import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerInput extends GetxController {
  final GlobalKey<FormState> customerFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var vknController = TextEditingController();
  var debtController = TextEditingController();
  var isComplatedController = false.obs;
  // var textName = "";
  // var textPhone = "";
  // var textEmail = "";
  // var textVkn = "";
  // var textDebt = "";
  // var createdBy = "1";
  // var isComplated

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    vknController.dispose();
    debtController.dispose();
  }

  //validations
  String? validateName(String value) {
    if (value.length < 4) {
      return "İsim 4 harften fazla olmalı";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.length != 11) {
      return "Telefon numarasını yanlış girdiniz(11 Hane)";
    }
    return null;
  }

  bool checkSave() {
    final isValid = customerFormKey.currentState!.validate();
    if (!isValid) return false;
    customerFormKey.currentState!.save();
    return true;
  }
}
