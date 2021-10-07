import 'package:batiturbo_erp/app/modules/models/api/payment.dart';
import 'package:batiturbo_erp/app/modules/providers/api/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general.controller.dart';

class PaymentController extends GetxController {
  var isLoading = true.obs;
  var paymentList = <Payment>[].obs;
  var paymentListSuggestions = <Payment>[].obs;

  var createdPayment;

  final GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();
  var paymentMethodController = TextEditingController();

  String? validateLength(String value) {
    if (value.length < 2) {
      return "Eksik Giriş";
    }
    return null;
  }

  bool checkSave() {
    final isValid = paymentFormKey.currentState!.validate();
    if (!isValid) return false;
    paymentFormKey.currentState!.save();
    return true;
  }

  // @override
  // void onInit() async {
  //   fetchPayments();
  //   super.onInit();
  // }

  Future<PaymentController> init() async {
    fetchPayments();
    return this;
  }

  // get Payment Suggestions
  Future<List<Payment>> getPaymentSuggestions(String query) async {
    var payments = await PaymentProvider().getCustomerSuggestions(query);
    return paymentListSuggestions.value = payments;
  }

  //CREATE Save Data
  void createPayment(Payment payment) {
    Map data = payment.toJson();
    try {
      isLoading(true);
      PaymentProvider().createPayment(data).then((resp) {
        print(
            "PaymentProvider().createPayment(data).then((resp) : ${resp.toString()}");

        if (resp['message'] == "Payment creating succesfully!") {
          createdPayment = Payment.fromJson(resp['data']);
          isLoading(false);
          fetchPayments();
        } else {
          showSnackBar("Add Payment", "Failed to Add Payment", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("createPayment Controller onError: ${err.toString()}");
        showSnackBar(
            "createPayment Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("createPayment Controller exception: ${exception.toString()}");
      showSnackBar("createPayment Controller exception", exception.toString(),
          Colors.red);
    }
  }

  //READ get all payments
  void fetchPayments() async {
    try {
      isLoading(true);
      var payments = await PaymentProvider().fetchPayments();
      paymentList.value = payments;
      //print(payments.length);
    } catch (exception) {
      print("fetchPayments Controller exception: ${exception.toString()}");
      showSnackBar("fetchPayments Controller exception", exception.toString(),
          Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Update Payment
  void updatePayment(int id, Payment payment) {
    Map data = payment.toJson();
    try {
      isLoading(true);
      PaymentProvider().updatePayment(id, data).then((resp) {
        print(
            "PaymentProvider().updatePayment(id, data).then((resp) : ${resp.toString()}");

        if (resp['message'] == "Payment successfully updated") {
          isLoading(false);
          fetchPayments();
          showSnackBar("Edit Payment", "Payment Edited", Colors.green);

          //lstJob.clear();
        } else {
          showSnackBar("Edit Job", "Job not Updated", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("updatePayment Controller onError: ${err.toString()}");
        showSnackBar(
            "updatePayment Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("updatePayment Controller exception: ${exception.toString()}");
      showSnackBar("updatePayment Controller exception", exception.toString(),
          Colors.red);
    }
  }
}
