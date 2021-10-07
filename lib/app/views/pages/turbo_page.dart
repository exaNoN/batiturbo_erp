import 'package:batiturbo_erp/app/modules/controllers/api/turbo_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/input/turbo_input.dart';
import 'package:batiturbo_erp/app/modules/models/api/turbo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurboPage extends StatelessWidget {
  final turboInput = Get.find<TurboInput>();
  final generalInput = Get.find<GeneralInputController>();
  final turboC = Get.find<TurboController>();
  Turbo turbo = Turbo(description: '', createdBy: '1');
  final context;
  final String debt;
  final TextEditingController turboCode;

  TurboPage(this.turboCode, [this.context, this.debt = "0"]);

  @override
  Widget build(BuildContext context) {
    if (turboCode.text.isNotEmpty) turboInput.codeController = turboCode;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Turbo sayfası"),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: Container(
            padding: EdgeInsets.all(8),
            child: Form(
              key: turboInput.turboFormKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Turbo Kodu
                  TextFormField(
                    decoration: InputDecoration(hintText: "Turbo Kodu"),
                    controller: turboInput.codeController,
                    onSaved: (value) {
                      turbo.code = value!;
                    },
                    validator: (value) {
                      return turboInput.validateCode(value!);
                    },
                  ),
                  //Turbo Açıklaması
                  TextFormField(
                    decoration: InputDecoration(hintText: "Turbo Açıklaması"),
                    onSaved: (value) {
                      turbo.description = value!;
                    },
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(hintText: "Müşteri debt"),
                  //   keyboardType: TextInputType.number,
                  //   onSaved: (value) {
                  //     turbo.debt = value!;
                  //   },
                  //   // validator: (value) {
                  //   //   return turboInput.validatePhone(value!);
                  //   // },
                  // ),

                  ElevatedButton(
                      onPressed: () {
                        if (turboInput.checkSave()) {
                          turboC.createTurbo(turbo);
                          if (generalInput.returnTurboId.isNotEmpty)
                            print("${generalInput.returnTurboId.isNotEmpty}");
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
