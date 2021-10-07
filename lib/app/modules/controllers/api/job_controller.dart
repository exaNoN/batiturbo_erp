import 'package:batiturbo_erp/app/modules/models/api/job.dart';
import 'package:batiturbo_erp/app/modules/providers/api/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general.controller.dart';

class JobController extends GetxController {
  var isLoading = true.obs;
  var jobList = <Job>[].obs;

  var selectedCustomerId = "".obs;
  var selectedTurboId = "".obs;
  var createdJob;

  var descriptionController = TextEditingController();

  // @override
  // void onInit() async {
  //   fetchJobs();
  //   super.onInit();
  // }
  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<JobController> init() async {
    fetchJobs();
    super.onInit();
    return this;
  }

  //CREATE Save Data
  void createJob(Job job) {
    Map data = job.toJson();
    try {
      isLoading(true);
      JobProvider().createJob(data).then((resp) {
        print("JobProvider().createJob(data).then((resp) : ${resp.toString()}");

        if (resp['message'] == "Job creating succesfully!") {
          showSnackBar("Add Job", resp.toString(), Colors.green);
          createdJob = Job.fromJson(resp['data']);
          isLoading(false);
          fetchJobs();
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

  //READ get all jobs
  void fetchJobs() async {
    try {
      isLoading(true);
      var jobs = await JobProvider().fetchJobs();
      jobList.value = jobs;
      //print(jobs.length);
    } catch (exception) {
      print("fetchJobs Controller exception: ${exception.toString()}");
      showSnackBar(
          "fetchJobs Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Update Job
  void updateJob(int id, Job job) {
    Map data = {
      "description": job.description,
      "offer": job.offer == null ? "0" : job.offer,
      "deadline": job.deadline == null ? "" : job.deadline,
      "customer_id": job.customerId,
      "turbo_id": job.turboId == null ? "1" : job.turboId,
      "created_by": job.createdBy == null ? "1" : job.createdBy,
      "updated_by": job.updatedBy == null ? "1" : job.updatedBy,
      "is_complated": job.isComplated == null ? false : job.isComplated,
    };
    try {
      isLoading(true);
      JobProvider().updateJob(id, data).then((resp) {
        print(
            "JobProvider().updateJob(id, data).then((resp) : ${resp.toString()}");

        if (resp['message'] == "Job was updated successfully.") {
          isLoading(false);
          fetchJobs();
          showSnackBar("Edit Job", "Job Edited", Colors.green);
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
}
