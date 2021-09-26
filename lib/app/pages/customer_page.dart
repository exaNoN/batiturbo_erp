import 'package:batiturbo_erp/app/modules/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerPage extends GetView<CustomerController> {
  var customerC = Get.arguments;

  //const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(customerC.runtimeType.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Müşteri Sayfası"),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
                //initialValue: "customerC.text",
                //controller: controller.customerNameController,
                ),
            TextFormField(),
            TextFormField(),
            ElevatedButton(
                onPressed: () {
                  print("müşteri kaydedildi");
                },
                child: Row(
                  children: [
                    Icon(Icons.person_add_alt),
                    Text("Müşteriyi Kaydet")
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
