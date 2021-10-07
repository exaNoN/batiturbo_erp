import 'dart:convert';

import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:batiturbo_erp/app/modules/providers/api/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general.controller.dart';

class CustomerController extends GetxController {
  var isLoading = true.obs;
  var customerList = <Customer>[].obs;
  var customerListSuggestions = <Customer>[].obs;

  var nameController = TextEditingController();
  var createdCustomer;

  // @override
  // void onInit() async {
  //   fetchCustomers();
  //   super.onInit();
  // }

  Future<CustomerController> init() async {
    fetchCustomers();
    super.onInit();
    return this;
  }

  // find customer by id from list
  Customer findCustomer(int id) =>
      customerList.firstWhere((customer) => customer.id == id,
          orElse: () => Customer(
              phone: '05467670392',
              name: 'Yanlış arama',
              createdBy: '',
              debt: '',
              isComplated: false));

  // get Customer Suggestions
  Future<List<Customer>> getCustomerSuggestions(String query) async {
    var customers = await CustomerProvider().getCustomerSuggestions(query);
    return customerListSuggestions.value = customers;
  }

  //CREATE Save Data
  void createCustomer(Customer customer) {
    Map data = customer.toJson();
    print(data);
    try {
      isLoading(true);
      CustomerProvider().createCustomer(data).then((resp) {
        print(
            "CustomerProvider().createCustomer(data).then((resp) : ${resp['data'].toString()}");
        if (resp['message'] == "Customer creating succesfully!") {
          showSnackBar(
              "Add Customer", resp['message'].toString(), Colors.green);
          createdCustomer = Customer.fromJson(resp['data']);
          print(createdCustomer.id.toString());

          isLoading(false);
          fetchCustomers();
        } else {
          showSnackBar("Add Customer", "Failed to Add Customer", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("createCustomer Controller onError: ${err.toString()}");
        showSnackBar(
            "createCustomer Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("createCustomer Controller exception: ${exception.toString()}");
      showSnackBar("createCustomer Controller exception", exception.toString(),
          Colors.red);
    }
  }

  //READ get all customers
  void fetchCustomers() async {
    try {
      isLoading(true);
      var customers = await CustomerProvider().fetchCustomers();
      customerList.value = customers;
      //print(customers.length);
    } catch (exception) {
      print("fetchCustomers Controller exception: ${exception.toString()}");
      showSnackBar("fetchCustomers Controller exception", exception.toString(),
          Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Update Customer
  void updateCustomer(int id, Customer customer) {
    Map data = customer.toJson();
    try {
      isLoading(true);
      CustomerProvider().updateCustomer(id, data).then((resp) {
        print(
            "CustomerProvider().updateCustomer(id, data).then((resp) : ${resp.toString()}");

        if (resp['message'] == "Customer was updated successfully.") {
          isLoading(false);
          fetchCustomers();
          showSnackBar("Edit Customer", "Customer Edited", Colors.green);
        } else {
          showSnackBar("Edit Job", "Job not Updated", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("updateCustomer Controller onError: ${err.toString()}");
        showSnackBar(
            "updateCustomer Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("updateCustomer Controller exception: ${exception.toString()}");
      showSnackBar("updateCustomer Controller exception", exception.toString(),
          Colors.red);
    }
  }
}
