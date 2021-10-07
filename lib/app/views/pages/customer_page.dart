import 'package:batiturbo_erp/app/modules/controllers/api/customer_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/input/customer_input.dart';
import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerPage extends StatelessWidget {
  final customerInput = Get.put(CustomerInput());
  final generalInput = Get.put(GeneralInputController());
  final customerC = Get.find<CustomerController>();
  final Customer customer =
      Customer(name: '', phone: '', createdBy: '1', isComplated: false);
  final TextEditingController customerController;
  final context;
  final String debt;

  CustomerPage(this.customerController, [this.context, this.debt = "0"]);

  @override
  Widget build(BuildContext context) {
    if (debt.isNotEmpty) {
      customer.debt = debt;
    }
    if (customerController.text.isNotEmpty) {
      customerInput.nameController.text = customerController.text;
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Müşteri sayfası"),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: Container(
            padding: EdgeInsets.all(8),
            child: Form(
              key: customerInput.customerFormKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //müşteri adı
                  TextFormField(
                    decoration: InputDecoration(hintText: "Müşteri Adı"),
                    controller: customerInput.nameController,
                    onSaved: (value) {
                      customer.name = value!;
                    },
                    validator: (value) {
                      return customerInput.validateName(value!);
                    },
                  ),
                  //müşteri numarası
                  TextFormField(
                    decoration:
                        InputDecoration(hintText: "Müşteri Telefon Numarası"),
                    keyboardType: TextInputType.phone,
                    // controller: customerInput.phoneController,
                    onSaved: (value) {
                      customer.phone = value!;
                    },
                    validator: (value) {
                      return customerInput.validatePhone(value!);
                    },
                  ),
                  //müşteri email
                  TextFormField(
                    decoration:
                        InputDecoration(hintText: "Müşteri Email Adresi"),
                    keyboardType: TextInputType.emailAddress,
                    // controller: customerInput.phoneController,
                    onSaved: (value) {
                      customer.email = value!;
                    },
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(hintText: "Müşteri debt"),
                  //   keyboardType: TextInputType.number,
                  //   onSaved: (value) {
                  //     customer.debt = value!;
                  //   },
                  //   // validator: (value) {
                  //   //   return customerInput.validatePhone(value!);
                  //   // },
                  // ),

                  //müşteri vkn
                  TextFormField(
                    decoration:
                        InputDecoration(hintText: "Müşteri Vergi Kimlik No"),
                    keyboardType: TextInputType.number,
                    controller: customerInput.vknController,
                    onSaved: (value) {
                      customer.vkn = value!;
                    },
                  ),

                  ElevatedButton(
                      onPressed: () {
                        if (customerInput.checkSave()) {
                          print(customer.toJson().toString());
                          customerC.createCustomer(customer);
                          if (generalInput.returnCustomerId.isNotEmpty)
                            print(
                                "${generalInput.returnCustomerId.isNotEmpty}");
                          Get.back();
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_add_alt),
                          Text("Müşteriyi Kaydet")
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
