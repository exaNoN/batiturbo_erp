import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general_controller.dart';
import 'package:batiturbo_erp/app/modules/models/turbo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurboProvider extends GetConnect {
  // getTurboByid
  Future<List<Turbo>> getTurbo(int id) async {
    try {
      final response = await get("$serverUrl$turbosUrl/$id");
      if (response.status.hasError) {
        print(
            "getTurbo response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print("response.body = $jsonString");
        return turboFromJson(jsonString);
      }
    } catch (exception) {
      print("getTurbo Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // fetchTurbos
  Future<List<Turbo>> fetchTurbos() async {
    try {
      final response = await get("$serverUrl$turbosUrl");
      if (response.status.hasError) {
        print(
            "fetchTurbos response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        return turboFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchTurbos Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //createTurbo
  Future<String> createTurbo(Map data) async {
    try {
      final response = await post("$serverUrl$turbosUrl", data);
      if (response.status.hasError) {
        print(
            "createTurbo response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        showSnackBar(
            "Add Turbo", response.body['message'].toString(), Colors.green);
        print(
            "createTurbo response.body; ${response.body['message'].toString()}");
        return response.body['message'];
      }
    } catch (exception) {
      print("createTurbo Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // Update Data
  Future<String> updateTurbo(int id, Map data) async {
    try {
      final response = await put("$serverUrl$turbosUrl/$id", data);
      print("$serverUrl$turbosUrl/$id");
      if (response.status.hasError) {
        print(
            "updateTurbo response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("updateTurbo Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

// Delete Data
  Future<String> deleteTurbo(int id) async {
    try {
      final response = await delete("$serverUrl$turbosUrl/$id");
      if (response.status.hasError) {
        print(
            "deleteTurbo response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body['message'];
      }
    } catch (exception) {
      print("deleteTurbo Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }
}
