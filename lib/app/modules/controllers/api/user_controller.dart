import 'package:batiturbo_erp/app/modules/models/api/user.dart';
import 'package:batiturbo_erp/app/modules/providers/api/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general.controller.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <User>[].obs;

  // @override
  // void onInit() async {
  //   fetchUsers();
  //   super.onInit();
  // }

  Future<UserController> init() async {
    fetchUsers();
    return this;
  }

  //CREATE Save Data
  void createUser(User user) {
    Map data = {
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
    };
    try {
      isLoading(true);
      UserProvider().createUser(data).then((resp) {
        print(
            "UserProvider().createUser(data).then((resp) : ${resp.toString()}");
        showSnackBar("Add User", resp.toString(), Colors.green);
        if (resp == "User added successfully!") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchUsers();
          // showSnackBar("Add User", "User Added", Colors.green);
          // getUserName.value = userList.last.name;
          // getUserPhone.value = userList.last.phone;
          // getUserVKN.value = userList.last.vkn!;
          // getUserAlacak.value = userList.last.alacak!;
          //lstJob.clear();
        } else {
          showSnackBar("Add Job", "Failed to Add Job", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("createUser Controller onError: ${err.toString()}");
        showSnackBar(
            "createUser Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("createUser Controller exception: ${exception.toString()}");
      showSnackBar(
          "createUser Controller exception", exception.toString(), Colors.red);
    }
  }

  //READ get all users
  void fetchUsers() async {
    try {
      isLoading(true);
      var users = await UserProvider().fetchUsers();
      userList.value = users;
      //print(users.length);
    } catch (exception) {
      print("fetchUsers Controller exception: ${exception.toString()}");
      showSnackBar(
          "fetchUsers Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Update User
  void updateUser(int id, User user) {
    Map data = {
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
    };
    try {
      isLoading(true);
      UserProvider().updateUser(id, data).then((resp) {
        print(
            "UserProvider().updateUser(id, data).then((resp) : ${resp.toString()}");
        showSnackBar("Edit User", resp.toString(), Colors.green);
        if (resp == "User successfully updated") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchUsers();
          showSnackBar("Edit User", "User Edited", Colors.green);

          //lstJob.clear();
        } else {
          showSnackBar("Edit Job", "Job not Updated", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("updateUser Controller onError: ${err.toString()}");
        showSnackBar(
            "updateUser Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("updateUser Controller exception: ${exception.toString()}");
      showSnackBar(
          "updateUser Controller exception", exception.toString(), Colors.red);
    }
  }
}
