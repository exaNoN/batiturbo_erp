import 'package:batiturbo_erp/app/modules/models/api/turbo.dart';
import 'package:batiturbo_erp/app/modules/providers/api/turbo_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general.controller.dart';

class TurboController extends GetxController {
  var isLoading = true.obs;
  var turboList = <Turbo>[].obs;
  var turboListSuggestions = <Turbo>[].obs;

  var createdTurbo;

  var codeController = TextEditingController();

  // @override
  // void onInit() async {
  //   fetchTurbos();
  //   super.onInit();
  // }

  Future<TurboController> init() async {
    fetchTurbos();
    super.onInit();
    return this;
  }

  Turbo findTurbo(int id) => turboList.firstWhere((turbo) => turbo.id == id,
      orElse: () => Turbo(description: 'yanlış aranan turbo', createdBy: '1'));

  //GET Turbo Suggestions
  Future<List<Turbo>> getTurboSuggestions(String query) async {
    var turbos = await TurboProvider().getTurboSuggestions(query);
    return turboListSuggestions.value = turbos;
  }

  //CREATE Save Data
  void createTurbo(Turbo turbo) {
    Map data = turbo.toJson();
    try {
      isLoading(true);
      TurboProvider().createTurbo(data).then((resp) {
        print(
            "TurboProvider().createTurbo(data).then((resp) : ${resp.toString()}");
        showSnackBar("Add Turbo", resp.toString(), Colors.green);
        if (resp['message'] == "Turbo creating succesfully!") {
          createdTurbo = Turbo.fromJson(resp['data']);
          print(createdTurbo.id.toString());
          isLoading(false);
          fetchTurbos();
        } else {
          showSnackBar("Add Job", "Failed to Add Job", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("createTurbo Controller onError: ${err.toString()}");
        showSnackBar(
            "createTurbo Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("createTurbo Controller exception: ${exception.toString()}");
      showSnackBar(
          "createTurbo Controller exception", exception.toString(), Colors.red);
    }
  }

  //READ get all turbos
  void fetchTurbos() async {
    try {
      isLoading(true);
      var turbos = await TurboProvider().fetchTurbos();
      turboList.value = turbos;
      //print(turbos.length);
    } catch (exception) {
      print("fetchTurbos Controller exception: ${exception.toString()}");
      showSnackBar(
          "fetchTurbos Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Update Turbo
  void updateTurbo(int id, Turbo turbo) {
    Map data = turbo.toJson();
    try {
      isLoading(true);
      TurboProvider().updateTurbo(id, data).then((resp) {
        print(
            "TurboProvider().updateTurbo(id, data).then((resp) : ${resp.toString()}");
        showSnackBar("Edit Turbo", resp.toString(), Colors.green);
        if (resp['message'] == "Turbo successfully updated") {
          isLoading(false);
          fetchTurbos();
          showSnackBar("Edit Turbo", "Turbo Edited", Colors.green);

          //lstJob.clear();
        } else {
          showSnackBar("Edit Job", "Job not Updated", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("updateTurbo Controller onError: ${err.toString()}");
        showSnackBar(
            "updateTurbo Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("updateTurbo Controller exception: ${exception.toString()}");
      showSnackBar(
          "updateTurbo Controller exception", exception.toString(), Colors.red);
    }
  }
}
