import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: get/uncomplated eklenecek
// TODO: get by id yok

// TODO: get by customer(müşteriye göre işleri çek)(backend)
// TODO: get by turbo eklenecek(backend)

class TaskProvider extends GetConnect {
  /*  CRUD  */
  //CREATE Task
  Future<dynamic> createTask(Map data) async {
    try {
      final response = await post("$serverUrl$tasksUrl", data);
      if (response.status.hasError) {
        print(
            "createTask response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        showSnackBar(
            "Add Task", response.body['message'].toString(), Colors.green);
        print(
            "createTask response.body; ${response.body['message'].toString()}");
        return response.body;
      }
    } catch (exception) {
      print("createTask Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //READ fetchTasks
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await get("$serverUrl$tasksUrl");
      if (response.status.hasError) {
        print(
            "fetchTasks response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print(jsonString);
        return taskFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchTasks Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //UPDATE Data
  Future<dynamic> updateTask(int id, Map data) async {
    try {
      final response = await put("$serverUrl$tasksUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updateTask response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body;
      }
    } catch (exception) {
      print("updateTask Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // //DELETE Data
  // Future<String> deleteTask(int id) async {
  //   try {
  //     final response = await delete("$serverUrl$tasksUrl/$id");
  //     if (response.status.hasError) {
  //       print(
  //           "deleteTask response.status.hasError error ${response.statusText.toString()}");
  //       return Future.error(response.statusText.toString());
  //     } else {
  //       print(response.body.toString());
  //       return response.body['message'];
  //     }
  //   } catch (exception) {
  //     print("deleteTask Provider exception ${exception.toString()}");
  //     return Future.error(exception.toString());
  //   }
  // }

}
