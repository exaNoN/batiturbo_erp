import 'package:batiturbo_erp/app/modules/controllers/api/customer_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/api/job_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/input/customer_input.dart';
import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:batiturbo_erp/app/views/pages/customer_page.dart';
import 'package:batiturbo_erp/app/views/widgets/dialog_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class CustomerField extends StatelessWidget {
  final customerInput = Get.put(CustomerInput());
  final customerC = Get.find<CustomerController>();
  final jobC = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Customer?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: customerC.nameController,
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Müşteri Adı',
            labelText: 'Müşteri Adı',
          ),
        ),
        hideOnLoading: true,
        noItemsFoundBuilder: (BuildContext context) {
          return ElevatedButton(
              onPressed: () => customerDialog(
                  customerNameController: customerC.nameController
                  //id: 2
                  ),
              child: Row(
                children: [Icon(Icons.person_add), Text("Müşteriyi Ekle")],
              ));
        },
        suggestionsCallback: customerC.getCustomerSuggestions,
        itemBuilder: (context, Customer? suggestion) {
          final customer = suggestion!;
          return ListTile(
            title: Text(customer.name),
          );
        },
        onSuggestionSelected: (Customer? suggestion) {
          jobC.selectedCustomerId.value = suggestion!.id.toString();
        });
  }
}
