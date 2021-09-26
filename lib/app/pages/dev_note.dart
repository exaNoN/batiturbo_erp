import 'package:batiturbo_erp/app/modules/controllers/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DevNote extends StatelessWidget {
  // const DevNote({Key? key}) : super(key: key);
  //var jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              //jobController.fetchJobs();
              Get.toNamed("home");
            },
            //onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                Text(
                  "JobController.jobUpdate çalışmıyor?",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Backend tarafına bakılacak",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
