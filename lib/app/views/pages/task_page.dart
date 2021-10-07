import 'package:batiturbo_erp/app/modules/controllers/api/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPage extends StatelessWidget {
  final String jobId;
  final id;

  TaskPage({Key? key, required this.jobId, this.id}) : super(key: key);

  var returnV = "".obs;
  final taskC = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("İşlem Sayfası"),
              actions: [Center(child: Text("${jobId} numaralı işin"))],
              leading: IconButton(
                  onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
            ),
            body: Container(
              margin: EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: "Açıklama",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    onChanged: (value) {},
                  ),
                ],
              ),
            )));
  }
}
