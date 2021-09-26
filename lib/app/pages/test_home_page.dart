import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/turbo_controller.dart';
import 'package:batiturbo_erp/app/modules/models/models.dart';
import 'package:batiturbo_erp/app/pages/dev_note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class TestHomePage extends StatelessWidget {
  var jobController = Get.put(JobController());
  var customerController = Get.put(CustomerController());
  var turboController = Get.put(TurboController());
  @override
  Widget build(BuildContext context) {
    //customerController.fetchCustomers();
    jobController.fetchJobs();
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.off(DevNote()), icon: Icon(Icons.info)),
            title: const Text('HomePage')),
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (jobController.isLoading.value)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else
                    return GetBuilder<CustomerController>(
                      init: CustomerController(),
                      builder: (val) {
                        print(
                            "val.customerList.length: ${val.customerList.length}");
                        return ListView.builder(
                            itemCount: val.customerList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                child: Container(
                                  width: Get.width - 4,
                                  child: Text(
                                      val.customerList[index].name.toString()),
                                ),
                              );
                            });
                      },
                    );
                }),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print("Tapped Create");
                  Job job = Job(
                    tanim1: "job.tanim11111",
                    musteri: "job.musteri",
                    tanim2: "job.tanim2",
                    teklif: "job.teklif",
                    photourl: 'photourl',
                    turbo: "job.turbo",
                    createdBy: 'admin',
                  );
                  jobController.createJob(job);
                },
                splashColor: Colors.blueGrey,
                child: Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print("Tapped Job Update");
                  Job job2 = Job(
                    tanim1: "ozgur.tanim11111",
                    musteri: "ozgur.musteri",
                    tanim2: "ozgur.tanim2",
                    teklif: "ozgur.teklif",
                    photourl: "photourl",
                    turbo: "ozgur.turbo",
                    createdBy: "ozgur",
                  );
                  jobController.updateJob(9, job2);
                },
                splashColor: Colors.blueGrey,
                child: Text(
                  'job Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print("Tapped Update");
                  Turbo turbo = Turbo(
                      name: "updated Turbo",
                      code: "13456",
                      tanim1: "tanim11",
                      tanim2: "tanim22",
                      photourl: "photourl",
                      createdBy: "admin");
                  turboController.updateTurbo(3, turbo);
                },
                splashColor: Colors.blueGrey,
                child: Text(
                  'turbo Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print("Tapped Update");
                  Customer customer = Customer(
                      name: "nameesae",
                      phone: "phone",
                      //vkn: "132654",
                      alacak: "123654");
                  customerController.updateCustomer(9, customer);
                },
                splashColor: Colors.blueGrey,
                child: Text(
                  'customer Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print("Tapped Delete");
                  jobController.deleteJob(6);
                },
                splashColor: Colors.blueGrey,
                child: Text(
                  'DEL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
