import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobInput extends GetxController {
  final GlobalKey<FormState> jobFormKey = GlobalKey<FormState>();
  var descriptionController = TextEditingController();
  var offerController = TextEditingController();
  var textDescription = "";
  var textOffer = "";

  //validations
  String? validateDescription(String value) {
    if (value.length < 4) {
      return "Tanım 4 harften fazla olmalı";
    }
    return null;
  }
}
