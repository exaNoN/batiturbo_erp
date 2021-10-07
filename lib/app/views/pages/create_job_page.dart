import 'package:batiturbo_erp/app/modules/controllers/api/customer_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/api/job_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/api/turbo_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/input/turbo_input.dart';
import 'package:batiturbo_erp/app/modules/controllers/inputs_controllers.dart';
import 'package:batiturbo_erp/app/modules/models/api/job.dart';
import 'package:batiturbo_erp/app/views/pages/job_detail_page.dart';
import 'package:batiturbo_erp/app/views/widgets/customer_field.dart';
import 'package:batiturbo_erp/app/views/widgets/turbo_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateJobPage extends StatelessWidget {
  final inputJob = Get.put(JobInput());
  final jobC = Get.find<JobController>();
  final customerC = Get.find<CustomerController>();
  final turboC = Get.find<TurboController>();

  @override
  Widget build(BuildContext context) {
    Job job = Job(
        description: inputJob.descriptionController.text,
        customerId: '1',
        isComplated: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("İş ekleme sayfası"),
          leading: IconButton(
              onPressed: () {
                Get.toNamed("/home");
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Form(
                key: inputJob.jobFormKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    CustomerField(),
                    //İş açıklaması descriptionController
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "İşin Açıklaması",
                          labelText: "İşin Açıklaması"),
                      controller: inputJob.descriptionController,
                      validator: (value) {
                        return inputJob.validateDescription(value!);
                      },
                    ),
                    TurboField(),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Teklif", labelText: "Teklif"),
                      controller: inputJob.offerController,
                    )
                  ],
                ),
              ),
              //
              ElevatedButton(
                child: Container(
                  color: Color(0xFF008161),
                  child: Row(
                    children: [Icon(Icons.add), Text("İşi Kaydet")],
                  ),
                ),
                onPressed: () async {
                  if (inputJob.descriptionController.text.isNotEmpty) {
                    if (inputJob.offerController.text.isNotEmpty) {
                      job.offer = inputJob.offerController.text;
                    }
                    jobC.createJob(job);
                    await 1.delay();
                    Get.off(JobDetailPage(
                      index: jobC.createdJob.id,
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
