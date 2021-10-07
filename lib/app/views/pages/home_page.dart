import 'package:batiturbo_erp/app/modules/controllers/api/customer_controller.dart';
import 'package:batiturbo_erp/app/modules/controllers/api/job_controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/customer.dart';
import 'package:batiturbo_erp/app/modules/models/api_models.dart';
import 'package:batiturbo_erp/app/routes/app_pages.dart';
import 'package:batiturbo_erp/app/views/widgets/dialog_fields.dart';
import 'package:batiturbo_erp/app/views/widgets/floating_button.dart';
import 'package:batiturbo_erp/app/views/widgets/job_tile.dart';
import 'package:batiturbo_erp/app/views/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final jobC = Get.find<JobController>();
  final customerC = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      if (jobC.isLoading.value) {
        return const SplashScreen();
      } else {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.info)),
            title: const Text('HomePage'),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xFF008161),
            icon: Icon(Icons.add),
            label: Text("İş ekle"),
            onPressed: () {
              Get.toNamed(Paths.createJob);
            },
          ),
          body: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                FloatingButton(
                    text: "get.defaultDialog",
                    icon: Icons.notifications,
                    onPressed: () {
                      Job job = Job(
                          customerId: '1',
                          description: 'izahat',
                          isComplated: false);
                      jobC.createJob(job);
                    }),
                Expanded(child: JobList()),
              ],
            ),
          ),
        );
      }
    }));
  }
}

class JobList extends StatelessWidget {
  final jobC = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: jobC.jobList.length,
        itemBuilder: (context, index) {
          return JobTile(context, index);
        });
  }
}
