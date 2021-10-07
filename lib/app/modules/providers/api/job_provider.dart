import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/job.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: get/uncomplated eklenecek
// TODO: get by id yok

// TODO: get by customer(müşteriye göre işleri çek)(backend)
// TODO: get by turbo eklenecek(backend)

class JobProvider extends GetConnect {
  /*  CRUD  */
  //CREATE Job
  Future<dynamic> createJob(Map data) async {
    print(data);
    try {
      final response = await post("$serverUrl$jobsUrl/", data);
      if (response.status.hasError) {
        print(
            "createJob response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        return response.body;
      }
    } catch (exception) {
      print("createJob Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //READ fetchJobs
  Future<List<Job>> fetchJobs() async {
    try {
      final response = await get("$serverUrl$jobsUrl");
      if (response.status.hasError) {
        print(
            "fetchJobs response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print(jsonString);
        return jobFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchJobs Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //UPDATE Data
  Future<dynamic> updateJob(int id, Map data) async {
    try {
      final response = await put("$serverUrl$jobsUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updateJob response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        return response.body['message'];
      }
    } catch (exception) {
      print("updateJob Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // //DELETE Data
  // Future<String> deleteJob(int id) async {
  //   try {
  //     final response = await delete("$serverUrl$jobsUrl/$id");
  //     if (response.status.hasError) {
  //       print(
  //           "deleteJob response.status.hasError error ${response.statusText.toString()}");
  //       return Future.error(response.statusText.toString());
  //     } else {
  //       print(response.body.toString());
  //       return response.body['message'];
  //     }
  //   } catch (exception) {
  //     print("deleteJob Provider exception ${exception.toString()}");
  //     return Future.error(exception.toString());
  //   }
  // }
}
