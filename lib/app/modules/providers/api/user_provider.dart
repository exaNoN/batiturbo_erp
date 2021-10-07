import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: get/uncomplated fonksiyonunu yaz
// TODO: get by id yok
class UserProvider extends GetConnect {
  /*  CRUD  */
  //CREATE User
  Future<String> createUser(Map data) async {
    try {
      final response = await post("$serverUrl$usersUrl", data);
      if (response.status.hasError) {
        print(
            "createUser response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        showSnackBar(
            "Add User", response.body['message'].toString(), Colors.green);
        print(
            "createUser response.body; ${response.body['message'].toString()}");
        return response.body['message'];
      }
    } catch (exception) {
      print("createUser Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //READ fetch all users
  Future<List<User>> fetchUsers() async {
    try {
      final response = await get("$serverUrl$usersUrl");
      if (response.status.hasError) {
        print(
            "fetchUsers response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        print(jsonString);
        return userFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchUsers Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //UPDATE Data
  Future<String> updateUser(int id, Map data) async {
    try {
      final response = await put("$serverUrl$usersUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updateUser response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("updateUser Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // //DELETE Data
  // Future<String> deleteUser(int id) async {
  //   try {
  //     final response = await delete("$serverUrl$usersUrl/$id");
  //     if (response.status.hasError) {
  //       print(
  //           "deleteUser response.status.hasError error ${response.statusText.toString()}");
  //       return Future.error(response.statusText.toString());
  //     } else {
  //       print(response.body.toString());
  //       return response.body['message'];
  //     }
  //   } catch (exception) {
  //     print("deleteUser Provider exception ${exception.toString()}");
  //     return Future.error(exception.toString());
  //   }
  // }
}
