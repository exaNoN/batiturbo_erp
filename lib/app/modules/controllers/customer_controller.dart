import 'package:batiturbo_erp/app/modules/models/customer_model.dart';
import 'package:batiturbo_erp/app/modules/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'general_controller.dart';

class CustomerController extends GetxController {
  var isLoading = true.obs;
  var customerList = <Customer>[].obs;
  var id = int.parse((1.obs).toString());
  RxString getCustomerName = "".obs;
  RxString getCustomerPhone = "".obs;
  RxString getCustomerVKN = "".obs;
  RxString getCustomerAlacak = "".obs;

  @override
  void onInit() async {
    customerList.refresh();
    fetchCustomers();
    super.onInit();
  }

  Customer findCustomer(int id) =>
      customerList.firstWhere((customer) => customer.id == id,
          orElse: () => Customer(phone: '05467670392', name: 'Yanlış arama'));

  void getCustomer(var id) async {
    try {
      isLoading(true);
      var customer = await CustomerProvider().getCustomer(id);
      getCustomerName.value = customer.name;
      getCustomerPhone.value = customer.phone;
      getCustomerVKN.value = customer.vkn!;
      getCustomerAlacak.value = customer.alacak!;
    } catch (exception) {
      print("getCustomer Controller exception: ${exception.toString()}");
      showSnackBar(
          "getCustomer Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
    }
  }

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

  // Save Data
  void createCustomer(Customer customer) {
    Map data = {
      'name': customer.name,
      'phone': customer.phone,
      'vkn': customer.vkn,
      'alacak': customer.alacak,
    };
    try {
      isLoading(true);
      CustomerProvider().createCustomer(data).then((resp) {
        print(
            "CustomerProvider().createCustomer(data).then((resp) : ${resp.toString()}");
        showSnackBar("Add Customer", resp.toString(), Colors.green);
        if (resp == "Customer added successfully!") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchCustomers();
          showSnackBar("Add Customer", "Customer Added", Colors.green);
          getCustomerName.value = customerList.last.name;
          getCustomerPhone.value = customerList.last.phone;
          getCustomerVKN.value = customerList.last.vkn!;
          getCustomerAlacak.value = customerList.last.alacak!;
          //lstJob.clear();
        } else {
          showSnackBar("Add Job", "Failed to Add Job", Colors.red);
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

  // Update Customer
  void updateCustomer(int id, Customer customer) {
    Map data = {
      'name': customer.name,
      'phone': customer.phone,
      'vkn': customer.vkn,
      'alacak': customer.alacak,
    };
    try {
      isLoading(true);
      CustomerProvider().updateCustomer(id, data).then((resp) {
        print(
            "CustomerProvider().updateCustomer(id, data).then((resp) : ${resp.toString()}");
        showSnackBar("Edit Customer", resp.toString(), Colors.green);
        if (resp == "Customer successfully updated") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchCustomers();
          showSnackBar("Edit Customer", "Customer Edited", Colors.green);
          getCustomerName.value = customerList.last.name;
          getCustomerPhone.value = customerList.last.phone;
          getCustomerVKN.value = customerList.last.vkn!;
          getCustomerAlacak.value = customerList.last.alacak!;

          //lstJob.clear();
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

  // Delete Customer
  void deleteCustomer(int id) {
    try {
      isLoading(true);
      CustomerProvider().deleteCustomer(id).then((resp) {
        isLoading(false);
        if (resp == "Customer successfully deleted") {
          //lstJob.clear();
          fetchCustomers();
          showSnackBar(
              "deleteCustomer Customer", "Customer Deleted", Colors.green);
        } else {
          showSnackBar("Delete Job", "Job not Deleted", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("deleteCustomer Controller onError: ${err.toString()}");
        showSnackBar(
            "deleteCustomer Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("deleteCustomer Controller exception: ${exception.toString()}");
      showSnackBar("deleteCustomer Controller exception", exception.toString(),
          Colors.red);
    }
  }
}
