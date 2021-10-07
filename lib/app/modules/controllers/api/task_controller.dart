import 'package:batiturbo_erp/app/modules/models/api/task.dart';
import 'package:batiturbo_erp/app/modules/providers/api/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general.controller.dart';

class TaskController extends GetxController {
  var isLoading = true.obs;
  var taskList = <Task>[].obs;

  var createdTask;

  var descriptionController = TextEditingController();
  var debtController = TextEditingController();

  final GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();
  var paymentMethodController = TextEditingController();

  String? validateDescription(String value) {
    if (value.length < 3) {
      return "Açıklamayı eksik girdiniz";
    }
    return null;
  }

  bool checkSave() {
    final isValid = taskFormKey.currentState!.validate();
    if (!isValid) return false;
    taskFormKey.currentState!.save();
    return true;
  }
  // @override
  // void onInit() async {
  //   fetchTasks();
  //   super.onInit();
  // }

  Future<TaskController> init() async {
    fetchTasks();
    return this;
  }

  //CREATE Save Data
  void createTask(Task task) {
    Map data = task.toJson();
    try {
      isLoading(true);
      TaskProvider().createTask(data).then((resp) {
        print(
            "TaskProvider().createTask(data).then((resp) : ${resp.toString()}");
        showSnackBar("Add Task", resp.toString(), Colors.green);
        if (resp['message'] == "Task creating succesfully!") {
          createdTask = Task.fromJson(resp['data']);
          isLoading(false);
          fetchTasks();
        } else {
          showSnackBar("Add Task", "Failed to Add Task", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("createTask Controller onError: ${err.toString()}");
        showSnackBar(
            "createTask Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("createTask Controller exception: ${exception.toString()}");
      showSnackBar(
          "createTask Controller exception", exception.toString(), Colors.red);
    }
  }

  //READ get all tasks
  void fetchTasks() async {
    try {
      isLoading(true);
      var tasks = await TaskProvider().fetchTasks();
      taskList.value = tasks;
      //print(tasks.length);
    } catch (exception) {
      print("fetchTasks Controller exception: ${exception.toString()}");
      showSnackBar(
          "fetchTasks Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
      //update();a
    }
  }

  // Update Task
  void updateTask(int id, Task task) {
    Map data = task.toJson();
    try {
      isLoading(true);
      TaskProvider().updateTask(id, data).then((resp) {
        print(
            "TaskProvider().updateTask(id, data).then((resp) : ${resp.toString()}");

        if (resp['message'] == "Task successfully updated") {
          isLoading(false);
          fetchTasks();
          showSnackBar("Edit Task", "Task Edited", Colors.green);

          //lstTask.clear();
        } else {
          showSnackBar("Edit Task", "Task not Updated", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("updateTask Controller onError: ${err.toString()}");
        showSnackBar(
            "updateTask Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("updateTask Controller exception: ${exception.toString()}");
      showSnackBar(
          "updateTask Controller exception", exception.toString(), Colors.red);
    }
  }
}
