import 'package:batiturbo_erp/app/modules/controllers/customer_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/models/customer_model.dart';
import 'package:batiturbo_erp/app/pages/customer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class CustomerField extends GetWidget<CustomerController> {
  var jobC = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(bottom: 8),
        width: double.infinity,
        child: TypeAheadField<Customer>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller.customerEditingController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Müşteri Adı',
              labelText: 'controller.customerEditingController.text',
            ),
          ),
          hideOnLoading: true,
          noItemsFoundBuilder: (BuildContext context) {
            return ElevatedButton(
                onPressed: () => Get.to(CustomerPage(),
                    arguments: controller.customerEditingController.text),
                child: Row(
                  children: [Icon(Icons.person_add_alt), Text("Müşteri Ekle")],
                ));
          },
          itemBuilder: (context, Customer? suggestion) {
            final customer = suggestion!;
            return ListTile(
              title: Text(customer.name),
            );
          },
          onSuggestionSelected: (Customer? suggestion) {
            jobC.selectedCustomerId.value = suggestion!.id.toString();
            jobC.isCustomerSelected(true);
            Get.snackbar(jobC.selectedCustomerId.value, "Selected Customer",
                snackPosition: SnackPosition.BOTTOM);
          },
          suggestionsCallback: controller.getCustomerSuggestions,
        ));
  }
}
