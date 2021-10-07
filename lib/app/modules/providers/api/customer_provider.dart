import 'dart:convert';

import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: get/uncomplated fonksiyonunu yaz
// TODO: get by id yok
class CustomerProvider extends GetConnect {
  /*  CRUD  */
  //CREATE Customer
  Future<dynamic> createCustomer(Map data) async {
    try {
      final response = await post("$serverUrl$customersUrl", data);
      if (response.status.hasError) {
        print(
            "createCustomer response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        return response.body;
      }
    } catch (exception) {
      print("createCustomer Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //READ fetch all customers
  Future<List<Customer>> fetchCustomers() async {
    try {
      final response = await get("$serverUrl$customersUrl");
      if (response.status.hasError) {
        print(
            "fetchCustomers response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print(jsonString);
        return customerFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchCustomers Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //UPDATE Data
  Future<dynamic> updateCustomer(int id, Map data) async {
    try {
      final response = await put("$serverUrl$customersUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updateCustomer response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        return response.body;
      }
    } catch (exception) {
      print("updateCustomer Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // //DELETE Data
  // Future<String> deleteCustomer(int id) async {
  //   try {
  //     final response = await delete("$serverUrl$customersUrl/$id");
  //     if (response.status.hasError) {
  //       print(
  //           "deleteCustomer response.status.hasError error ${response.statusText.toString()}");
  //       return Future.error(response.statusText.toString());
  //     } else {
  //       print(response.body.toString());
  //       return response.body['message'];
  //     }
  //   } catch (exception) {
  //     print("deleteCustomer Provider exception ${exception.toString()}");
  //     return Future.error(exception.toString());
  //   }
  // }

  // query Customers
  Future<List<Customer>> getCustomerSuggestions(String query) async {
    try {
      final response = await get("$serverUrl$customersUrl");
      if (response.status.hasError) {
        print(
            "fetchCustomers response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        final List jsonString = json.decode(response.bodyString.toString());
        return jsonString
            .map((json) => Customer.fromJson(json))
            .where((customer) {
          final nameLower = customer.name.toLowerCase();
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      }
    } catch (exception) {
      print("fetchCustomers Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }
}
