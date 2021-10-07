import 'package:batiturbo_erp/app/modules/controllers/api/payment_controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  final TextEditingController controller;

  PaymentMethod({Key? key, required this.controller}) : super(key: key);
  final paymentC = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TypeAheadField<Payment?>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              decoration: const InputDecoration(
                  labelText: 'Ödeme Şekli',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            hideOnLoading: true,
            noItemsFoundBuilder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Method ekle"),
                  ),
                ],
              );
            },
            suggestionsCallback: paymentC.getPaymentSuggestions,
            itemBuilder: (context, Payment? suggestion) {
              final payment = suggestion!;
              return ListTile(
                title: Text(payment.paymentMethod),
              );
            },
            onSuggestionSelected: (Payment? suggestion) {
              controller.text = suggestion!.paymentMethod;
            }));
  }
}
