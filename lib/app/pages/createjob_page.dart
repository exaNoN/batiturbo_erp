import 'package:batiturbo_erp/app/modules/widgets/customer_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateJobPage extends StatelessWidget {
  const CreateJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İş ekleme sayfası"),
        leading: IconButton(
            onPressed: () {
              Get.toNamed("home");
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomerField(),
            ],
          ),
        ),
      ),
    );
  }
}
