import 'package:batiturbo_erp/app/modules/controllers/api/job_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/api/turbo_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/input/turbo_input.dart';
import 'package:batiturbo_erp/app/modules/models/api/turbo.dart';
import 'package:batiturbo_erp/app/views/pages/turbo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class TurboField extends StatelessWidget {
  final turboC = Get.find<TurboController>();
  final turboInput = Get.put(TurboInput());
  final jobC = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Turbo?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: turboC.codeController,
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Turbo Adı',
          labelText: 'Turbo Adı',
        ),
      ),
      hideOnLoading: true,
      noItemsFoundBuilder: (BuildContext context) {
        return ElevatedButton(
            onPressed: () => Get.to(TurboPage(turboC.codeController)),
            child: Row(
              children: [Icon(Icons.add_reaction), Text("Turbo Ekle")],
            ));
      },
      suggestionsCallback: turboC.getTurboSuggestions,
      itemBuilder: (context, Turbo? suggestion) {
        final turbo = suggestion!;
        return ListTile(
          title: Text(turbo.code),
        );
      },
      onSuggestionSelected: (Turbo? suggestion) {
        jobC.selectedTurboId.value = suggestion!.id.toString();
      },
    );
  }
}
