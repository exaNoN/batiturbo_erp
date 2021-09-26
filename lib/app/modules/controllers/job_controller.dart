import 'package:batiturbo_erp/app/modules/models/job_model.dart';
import 'package:batiturbo_erp/app/modules/providers/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'general_controller.dart';

class JobController extends GetxController {
  //var customerList = Get.find<CustomerController>().customerList.obs;

  var isLoading = true.obs;
  var jobList = <Job>[].obs;
  int id = int.parse((1.obs).toString());

  RxString getJobtanim1 = "".obs;
  RxString getJobmusteri = "".obs;
  RxString getJobtanim2 = "".obs;
  RxString getJobteklif = "".obs;
  RxString getJobphotourl = "".obs;
  RxString getJobturbo = "".obs;
  RxString getJobcreatedBy = "".obs;
  RxString getJobcreatedAt = "".obs;

  void onInit() async {
    print("JobController init");
    fetchJobs();
    super.onInit();
  }

  Job findJob(int id) =>
      jobList.firstWhere((job) => job.id == id, orElse: () => Job(musteri: 1));

  void getJob(var id) async {
    try {
      isLoading(true);
      var job = await JobProvider().getJob(id);
      getJobtanim1.value = job.last.tanim1;
      getJobmusteri.value = job.last.musteri!;
      getJobtanim2.value = job.last.tanim2!;
      getJobteklif.value = job.last.teklif!;
      getJobphotourl.value = job.last.photourl!;
      getJobturbo.value = job.last.turbo!;
      getJobcreatedBy.value = job.last.createdBy!;
      getJobcreatedAt.value = job.last.createdAt!;
      if (id != 1) {
        showSnackBar("Get Job", getJobtanim1.value, Colors.blue);
      } else {
        print("getJob id:1");
      }
    } catch (exception) {
      print("getJob Controller exception: ${exception.toString()}");
      showSnackBar(
          "getJob Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void fetchJobs() async {
    try {
      isLoading(true);
      var jobs = await JobProvider().fetchJobs();
      print(jobs.toString());
      jobList.value = jobs;
    } catch (exception) {
      print("fetchJobs Controller exception: ${exception.toString()}");
      showSnackBar(
          "fetchJobs Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Save Data
  void createJob(Job job) {
    Map data = {
      'tanim1': job.tanim1,
      'musteri': job.musteri,
      'tanim2': 'job.tanim2',
      'teklif': job.teklif,
      'photourl': 'photourl',
      'turbo': job.turbo,
      'created_by': 'admin',
    };
    try {
      isLoading(true);
      JobProvider().createJob(data).then((resp) {
        print("JobProvider().createJob(data).then((resp) : ${resp.toString()}");
        showSnackBar("Add Job", resp.toString(), Colors.green);
        if (resp == "Job added successfully!") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchJobs();
          showSnackBar("Add Job", "Job Added", Colors.green);
          getJobtanim1.value = jobList.last.tanim1;
          getJobmusteri.value = jobList.last.musteri!;
          getJobtanim2.value = jobList.last.tanim2!;
          getJobteklif.value = jobList.last.teklif!;
          getJobphotourl.value = jobList.last.photourl!;
          getJobturbo.value = jobList.last.turbo!;
          getJobcreatedBy.value = jobList.last.createdBy!;
          getJobcreatedAt.value = jobList.last.createdAt;
          //lstTask.clear();
        } else {
          showSnackBar("Add Job", "Failed to Add Job", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("createJob Controller onError: ${err.toString()}");
        showSnackBar(
            "createJob Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("createJob Controller exception: ${exception.toString()}");
      showSnackBar(
          "createJob Controller exception", exception.toString(), Colors.red);
    }
  }

  // Update Job
  void updateJob(int id, Job job) {
    Map data = {
      'tanim1': job.tanim1,
      'musteri': job.musteri,
      'tanim2': job.tanim2,
      'teklif': job.teklif,
      'photourl': 'photourl',
      'turbo': job.turbo,
      'created_by': 'admin',
    };
    try {
      isLoading(true);
      JobProvider().updateJob(id, data).then((resp) {
        print(
            "JobProvider().updateJob(id, data).then((resp) : ${resp.toString()}");
        showSnackBar("Edit Job", resp.toString(), Colors.green);
        if (resp == "Job successfully updated") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchJobs();
          showSnackBar("Edit Job", "Job Edited", Colors.green);
          getJobtanim1.value = jobList.last.tanim1;
          getJobmusteri.value = jobList.last.musteri!;
          getJobtanim2.value = jobList.last.tanim2!;
          getJobteklif.value = jobList.last.teklif!;
          getJobphotourl.value = jobList.last.photourl!;
          getJobturbo.value = jobList.last.turbo!;
          getJobcreatedBy.value = jobList.last.createdBy!;
          getJobcreatedAt.value = jobList.last.createdAt!;

          //lstTask.clear();
        } else {
          showSnackBar("Edit Job", "Job not Updated", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("updateJob Controller onError: ${err.toString()}");
        showSnackBar(
            "updateJob Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("updateJob Controller exception: ${exception.toString()}");
      showSnackBar(
          "updateJob Controller exception", exception.toString(), Colors.red);
    }
  }

  // Delete Job
  void deleteJob(int id) {
    try {
      isLoading(true);
      JobProvider().deleteJob(id).then((resp) {
        isLoading(false);
        if (resp == "Job successfully deleted") {
          //lstTask.clear();
          fetchJobs();
          showSnackBar("deleteJob Job", "Job Deleted", Colors.green);
        } else {
          showSnackBar("Delete Job", "Job not Deleted", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("deleteJob Controller onError: ${err.toString()}");
        showSnackBar(
            "deleteJob Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("deleteJob Controller exception: ${exception.toString()}");
      showSnackBar(
          "deleteJob Controller exception", exception.toString(), Colors.red);
    }
  }
}
