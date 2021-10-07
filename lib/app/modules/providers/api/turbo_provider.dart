import 'dart:convert';

import 'package:batiturbo_erp/app/data/serverinfo.dart';
import 'package:batiturbo_erp/app/modules/controllers/general.controller.dart';
import 'package:batiturbo_erp/app/modules/models/api/turbo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: get/uncomplated fonksiyonunu yaz
// TODO: get by id yok
class TurboProvider extends GetConnect {
  /*  CRUD  */
  //CREATE Turbo
  Future<dynamic> createTurbo(Map data) async {
    try {
      final response = await post("$serverUrl$turbosUrl", data);
      if (response.status.hasError) {
        print(
            "createTurbo response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(
            "createTurbo response.body; ${response.body['message'].toString()}");
        return response.body;
      }
    } catch (exception) {
      print("createTurbo Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //READ fetch all turbos
  Future<List<Turbo>> fetchTurbos() async {
    try {
      final response = await get("$serverUrl$turbosUrl");
      if (response.status.hasError) {
        print(
            "fetchTurbos response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        var jsonString = response.bodyString.toString();
        //print(jsonString);
        return turboFromJson(jsonString);
      }
    } catch (exception) {
      print("fetchTurbos Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  //UPDATE Data
  Future<dynamic> updateTurbo(int id, Map data) async {
    try {
      final response = await put("$serverUrl$turbosUrl/$id", data);
      if (response.status.hasError) {
        print(
            "updateTurbo response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        print(response.body.toString());
        return response.body;
      }
    } catch (exception) {
      print("updateTurbo Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }

  // //DELETE Data
  // Future<String> deleteTurbo(int id) async {
  //   try {
  //     final response = await delete("$serverUrl$turbosUrl/$id");
  //     if (response.status.hasError) {
  //       print(
  //           "deleteTurbo response.status.hasError error ${response.statusText.toString()}");
  //       return Future.error(response.statusText.toString());
  //     } else {
  //       print(response.body.toString());
  //       return response.body['message'];
  //     }
  //   } catch (exception) {
  //     print("deleteTurbo Provider exception ${exception.toString()}");
  //     return Future.error(exception.toString());
  //   }
  // }

  // query Turbos
  Future<List<Turbo>> getTurboSuggestions(String query) async {
    try {
      final response = await get("$serverUrl$turbosUrl");
      if (response.status.hasError) {
        print(
            "fetchTurbos response.status.hasError error ${response.statusText.toString()}");
        return Future.error(response.statusText.toString());
      } else {
        final List jsonString = json.decode(response.bodyString.toString());
        return jsonString.map((json) => Turbo.fromJson(json)).where((turbo) {
          final nameLower = turbo.code.toLowerCase();
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      }
    } catch (exception) {
      print("fetchTurbos Provider exception ${exception.toString()}");
      return Future.error(exception.toString());
    }
  }
}
