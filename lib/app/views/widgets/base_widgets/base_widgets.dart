import 'package:batiturbo_erp/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget customButton(String text, RxString returnV) {
  return MaterialButton(
    onPressed: () {
      returnV.value = text;
      print(returnV.value);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color_grey.withAlpha(25),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Text(
        text,
        style: headline3,
      ),
    ),
  );
}
