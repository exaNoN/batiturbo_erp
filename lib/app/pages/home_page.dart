import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/turbo_controller.dart';
import 'package:batiturbo_erp/app/modules/widgets/job_tile.dart';
import 'package:batiturbo_erp/app/pages/createjob_page.dart';
import 'package:batiturbo_erp/app/pages/dev_note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// git config --global user.email "ahmetozgurkalkan@gmail.com"
// git config --global user.name "exaNoN"

// ignore: use_key_in_widget_constructors, must_be_immutable
class HomePage extends StatelessWidget {
  var jobC = Get.find<JobController>();
  var customerC = Get.find<CustomerController>();
  var turboC = Get.find<TurboController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.off(DevNote()), icon: Icon(Icons.info)),
          title: const Text('HomePage'),
        ),
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(child: Obx(() {
                if (jobC.isLoading.value == true) {
                  print("val.isLoading.value == ${jobC.isLoading.value}");

                  // jobC.fetchJobs();
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (jobC.jobList.length > 0) {
                    return ListView.builder(
                        itemCount: jobC.jobList.length,
                        itemBuilder: (context, index) {
                          return JobTile(context, index);
                        });
                  } else
                    return Center(
                      child: Text("Data Not Found"),
                    );
                }
              })),

              // MaterialButton(
              //   color: Colors.blue,
              //   onPressed: () {
              //     print("Tapped Create");
              //     Job job = Job(
              //       tanim1: "bu da bi tanim",
              //       musteri: "6",
              //       tanim2: "job.tanim2",
              //       teklif: "job.teklif",
              //       photourl: 'photourl',
              //       turbo: "4",
              //       createdBy: 'admin',
              //     );
              //     jobC.createJob(job);
              //   },
              //   splashColor: Colors.blueGrey,
              //   child: Text(
              //     'Create',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // MaterialButton(
              //   color: Colors.blue,
              //   onPressed: () {
              //     print("Tapped Job Update");
              //     Job job2 = Job(
              //       tanim1: "ozgur.tanim11111",
              //       musteri: "3",
              //       tanim2: "ozgur.tanim2",
              //       teklif: "ozgur.teklif",
              //       photourl: "photourl",
              //       turbo: "1",
              //       createdBy: "ozgur",
              //     );
              //     jobC.updateJob(9, job2);
              //   },
              //   splashColor: Colors.blueGrey,
              //   child: Text(
              //     'job Update',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // MaterialButton(
              //   color: Colors.blue,
              //   onPressed: () {
              //     print("Tapped Update");
              //     Turbo turbo = Turbo(
              //         name: "updated Turbo",
              //         code: "13456",
              //         tanim1: "tanim11",
              //         tanim2: "tanim22",
              //         photourl: "photourl",
              //         createdBy: "admin");
              //     turboC.updateTurbo(3, turbo);
              //   },
              //   splashColor: Colors.blueGrey,
              //   child: Text(
              //     'turbo Update',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // MaterialButton(
              //   color: Colors.blue,
              //   onPressed: () {
              //     print("Tapped Update");
              //     Customer customer = Customer(
              //         name: "nameesae",
              //         phone: "phone",
              //         //vkn: "132654",
              //         alacak: "123654");
              //     customerC.updateCustomer(9, customer);
              //   },
              //   splashColor: Colors.blueGrey,
              //   child: Text(
              //     'customer Update',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // MaterialButton(
              //   color: Colors.blue,
              //   onPressed: () {
              //     print("Tapped Delete");
              //     jobC.deleteJob(6);
              //   },
              //   splashColor: Colors.blueGrey,
              //   child: Text(
              //     'DEL',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("İş ekle"),
          onPressed: () {
            Get.off(CreateJobPage());
          },
        ));
  }
}
