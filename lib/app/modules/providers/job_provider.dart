import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobProvider extends GetConnect {
  // getJobByid
  Future<List<Job>> getJob(int id) async {
    try {
      final response = await get("$serverUrl$jobsUrl/$id");
      if (response.status.hasError) {
        print(
            "getJob response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print("response.body = $jsonString");
        return jobFromJson(jsonString);
      }
    } catch (exception) {
      print("getJob Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // fetchJobs
  Future<List<Job>> fetchJobs() async {
    try {
      final response = await get("$serverUrl$jobsUrl");
      if (response.status.hasError) {
        print(
            "fetchJobs response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        return jobFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchJobs Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //createJob
  Future<String> createJob(Map data) async {
    try {
      final response = await post("$serverUrl$jobsUrl", data);
      if (response.status.hasError) {
        print(
            "createJob response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        showSnackBar(
            "Add Job", response.body['message'].toString(), Colors.green);
        print(
            "createJob response.body; ${response.body['message'].toString()}");
        return response.body['message'];
      }
    } catch (exception) {
      print("createJob Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // Update Data
  Future<String> updateJob(int id, Map data) async {
    try {
      final response = await put("$serverUrl$jobsUrl/$id", data);
      print("$serverUrl$jobsUrl/$id");
      if (response.status.hasError) {
        print(
            "updateJob response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("updateJob Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

// Delete Data
  Future<String> deleteJob(int id) async {
    try {
      final response = await delete("$serverUrl$jobsUrl/$id");
      if (response.status.hasError) {
        print(
            "deleteJob response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("deleteJob Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }
}
