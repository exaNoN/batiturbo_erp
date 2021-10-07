import 'dart:convert';

import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: get by id yok

class PaymentProvider extends GetConnect {
  /*  CRUD  */
  //CREATE Payment
  Future<dynamic> createPayment(Map data) async {
    try {
      final response = await post("$serverUrl$paymentsUrl", data);
      if (response.status.hasError) {
        print(
            "createPayment response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        // showSnackBar(
        //     "Add Payment", response.body['message'].toString(), Colors.green);
        print(
            "createPayment response.body; ${response.body['message'].toString()}");
        return response.body;
      }
    } catch (exception) {
      print("createPayment Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //READ fetch all payments
  Future<List<Payment>> fetchPayments() async {
    try {
      final response = await get("$serverUrl$paymentsUrl");
      if (response.status.hasError) {
        print(
            "fetchPayments response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print(jsonString);
        return paymentFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchPayments Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //UPDATE Data
  Future<dynamic> updatePayment(int id, Map data) async {
    try {
      final response = await put("$serverUrl$paymentsUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updatePayment response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body;
      }
    } catch (exception) {
      print("updatePayment Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // query Customers
  Future<List<Payment>> getCustomerSuggestions(String query) async {
    try {
      final response = await get("$serverUrl$paymentsUrl");
      if (response.status.hasError) {
        print(
            "fetchPayments response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        final List jsonString = json.decode(response.bodyString.toString());
        //print(jsonString.toString());
        return jsonString
            .map((json) => Payment.fromJson(json))
            .where((payment) {
          final methodLower = payment.paymentMethod.toLowerCase();
          final queryLower = query.toLowerCase();
          return methodLower.contains(queryLower);
        }).toList();
      }
    } catch (exception) {
      print("fetchPayments Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }
}
