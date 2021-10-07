import 'package:batiturbo_erp/app/modules/controllers/api/customer_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/input/customer_input.dart';
import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:batiturbo_erp/app/views/widgets/base_widgets/base_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customerDialog({int? id, TextEditingController? customerNameController}) {
  var customerInput = Get.put(CustomerInput());
  var customerC = Get.find<CustomerController>();
  var generalInput = Get.put(GeneralInputController());
  var customer =
      Customer(name: "", phone: "", createdBy: "", isComplated: false);
  if (id != null) {
    customer = customerC.findCustomer(id);
    customerInput.nameController.text = customer.name;
    customerInput.phoneController.text = customer.phone;
    customerInput.vknController.text = customer.vkn;
    customerInput.debtController.text = customer.debt;
    customerInput.emailController.text = customer.email;
  }
  if (customerNameController != null) {
    customerInput.nameController = customerNameController;
    customer.name = customerNameController.text;
  }

  Get.defaultDialog(
    title: "Müşteri Sayfası",
    content: Form(
      key: customerInput.customerFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          //müşteri adı
          TextFormField(
            decoration: InputDecoration(
                labelText: "Müşteri Adı",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            controller: customerInput.nameController,
            onChanged: (value) {
              customer.name = value;
            },
            validator: (value) {
              return customerInput.validateName(value!);
            },
          ),
          addVerticalSpace(7),
          //müşteri numarası
          TextFormField(
            decoration: InputDecoration(
                labelText: "Müşteri Telefon numarası",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            keyboardType: TextInputType.phone,
            controller: customerInput.phoneController,
            onChanged: (value) {
              customer.phone = value;
            },
            validator: (value) {
              return customerInput.validatePhone(value!);
            },
          ),
          addVerticalSpace(7),
          //müşteri email
          TextField(
            decoration: InputDecoration(
                labelText: "Müşteri e-mail",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            keyboardType: TextInputType.emailAddress,
            controller: customerInput.emailController,
            onChanged: (value) {
              customer.email = value;
            },
          ),
          addVerticalSpace(7),
          TextField(
            decoration: InputDecoration(
                labelText: "Müşteri debt",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            keyboardType: TextInputType.number,
            controller: customerInput.debtController,
            onChanged: (value) {
              customer.debt = value;
            },
          ),
          addVerticalSpace(7),

          //müşteri vkn
          TextField(
            decoration: InputDecoration(
                labelText: "Müşteri Vergi Kimlik No",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            keyboardType: TextInputType.number,
            controller: customerInput.vknController,
            onChanged: (value) {
              customer.vkn = value;
            },
          ),
          addVerticalSpace(7),

          ElevatedButton(
              onPressed: () {
                if (customerInput.checkSave()) {
                  print(customer.toJson().toString());
                  customerC.createCustomer(customer);
                  if (generalInput.returnCustomerId.isNotEmpty)
                    print("${generalInput.returnCustomerId.isNotEmpty}");
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
  );
}
