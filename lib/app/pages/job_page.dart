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
    );
  }
}
