import 'package:batiturbo_erp/app/modules/controllers/api_controllers.dart';
import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:batiturbo_erp/app/modules/models/api/job.dart';
import 'package:batiturbo_erp/app/modules/models/api/turbo.dart';
import 'package:batiturbo_erp/app/views/pages/job_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class JobTile extends StatelessWidget {
  var jobC = Get.find<JobController>();
  var customerC = Get.find<CustomerController>();
  var turboC = Get.find<TurboController>();

  var context;
  int index;

  JobTile(this.context, this.index);

  @override
  Widget build(BuildContext context) {
    Job job = jobC.jobList[index];

    int customerId = int.parse(job.customerId.toString());
    Customer customer = customerC.findCustomer(customerId);
    int turboId = int.parse(job.turboId.toString());
    Turbo turbo = turboC.findTurbo(turboId);

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.black),
      width: Get.width - 4,
      child: InkWell(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Row(
                  //mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                          color: Colors.greenAccent,
                          alignment: Alignment.topLeft,
                          child: Text("${job.createdAt}"
                              //"${job.createdAt.toString().split(':')[0]}:${job.createdAt.toString().split(':')[1]}"
                              )),
                    ),
                    Flexible(
                      flex: 4,
                      child: Container(
                        color: Colors.blueGrey,
                        margin: EdgeInsets.all(8),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${customer.name}",
                            )),
                      ),
                    ),
                    Flexible(
                        child: Container(
                            color: Colors.greenAccent,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${job.id.toString()}",
                              style: TextStyle(fontSize: 20),
                            )))
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                  Column(
                    children: [Text("${turbo.code}"), Text(job.description)],
                  )
                ],
              )
            ],
          ),
          onTap: () {
            print(index);
            Get.to(JobDetailPage(
              index: index,
            ));
          }),
    );
  }
}
