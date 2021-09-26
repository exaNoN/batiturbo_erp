import 'dart:convert';

import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// List<Customer> customerFromJson(String str) =>
//     List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

class CustomerProvider extends GetConnect {
  // getCustomerByid
  Future<Customer> getCustomer(int id) async {
    try {
      final response = await get("$serverUrl$customersUrl/$id");
      if (response.status.hasError) {
        print(
            "getCustomer response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.body;
        // print("response.body = $jsonString");
        // final jsonData = json.decode(jsonString);
        final customer = Customer(
            name: jsonString['name'],
            phone: jsonString['phone'],
            vkn: jsonString['vkn'],
            alacak: jsonString['alacak']);
        print(customer.name);
        print(customer.phone);
        print(customer.vkn);
        print(customer.alacak);
        return customer;
      }
    } catch (exception) {
      print("getCustomer Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // fetchCustomers
  Future<List<Customer>> fetchCustomers() async {
    try {
      final response = await get("$serverUrl$customersUrl");
      if (response.status.hasError) {
        print(
            "fetchCustomers response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        return customerFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchCustomers Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //createCustomer
  Future<String> createCustomer(Map data) async {
    try {
      final response = await post("$serverUrl$customersUrl", data);
      if (response.status.hasError) {
        print(
            "createCustomer response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        showSnackBar(
            "Add Customer", response.body['message'].toString(), Colors.green);
        print(
            "createCustomer response.body; ${response.body['message'].toString()}");
        return response.body['message'];
      }
    } catch (exception) {
      print("createCustomer Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // Update Data
  Future<String> updateCustomer(int id, Map data) async {
    try {
      final response = await put("$serverUrl$customersUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updateCustomer response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("updateCustomer Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

// Delete Data
  Future<String> deleteCustomer(int id) async {
    try {
      final response = await delete("$serverUrl$customersUrl/$id");
      if (response.status.hasError) {
        print(
            "deleteCustomer response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("deleteCustomer Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }
}
