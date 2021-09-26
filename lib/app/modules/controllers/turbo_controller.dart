import 'package:batiturbo_erp/app/modules/models/turbo_model.dart';
import 'package:batiturbo_erp/app/modules/providers/turbo_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'general_controller.dart';

class TurboController extends GetxController {
  var isLoading = true.obs;
  var turboList = <Turbo>[].obs;
  var id = int.parse((1.obs).toString());
  RxString getTurboname = "".obs;
  RxString getTurbocode = "".obs;
  RxString getTurbotanim1 = "".obs;
  RxString getTurbotanim2 = "".obs;
  RxString getTurbophotourl = "".obs;
  RxString getTurbocreatedBy = "".obs;

  @override
  void onInit() async {
    fetchTurbos();
    super.onInit();
  }

  Turbo findTurbo(int id) => turboList.firstWhere((turbo) => turbo.id == id,
      orElse: () => Turbo(name: 'yanlış aranan turbo'));

  void getTurbo(var id) async {
    try {
      isLoading(true);
      var turbo = await TurboProvider().getTurbo(id);
      getTurboname.value = turbo.last.name;
      getTurbocode.value = turbo.last.code;
      getTurbotanim1.value = turbo.last.tanim1;
      getTurbotanim2.value = turbo.last.tanim2;
      getTurbophotourl.value = turbo.last.photourl!;
      getTurbocreatedBy.value = turbo.last.createdBy!;
      if (id != 1) {
        showSnackBar("Get Turbo", getTurboname.value, Colors.blue);
      } else {
        print("getTurbo id:1");
      }
    } catch (exception) {
      print("getTurbo Controller exception: ${exception.toString()}");
      showSnackBar(
          "getTurbo Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void fetchTurbos() async {
    try {
      isLoading(true);
      var turbos = await TurboProvider().fetchTurbos();
      turboList.value = turbos;
    } catch (exception) {
      print("fetchTurbos Controller exception: ${exception.toString()}");
      showSnackBar(
          "fetchTurbos Controller exception", exception.toString(), Colors.red);
    } finally {
      isLoading(false);
      //update();
    }
  }

  // Save Data
  void createTurbo(Turbo turbo) {
    Map data = {
      'name': turbo.name,
      'tanim1': turbo.tanim1,
      'tanim2': turbo.tanim2,
      'code': turbo.code,
      'photourl': 'photourl',
      'created_by': 'admin',
    };
    try {
      isLoading(true);
      TurboProvider().createTurbo(data).then((resp) {
        print(
            "TurboProvider().createTurbo(data).then((resp) : ${resp.toString()}");
        showSnackBar("Add Turbo", resp.toString(), Colors.green);
        if (resp == "Turbo added successfully!") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchTurbos();
          showSnackBar("Add Turbo", "Turbo Added", Colors.green);
          getTurboname.value = turboList.last.name;
          getTurbocode.value = turboList.last.code;
          getTurbotanim1.value = turboList.last.tanim1;
          getTurbotanim2.value = turboList.last.tanim2;
          getTurbophotourl.value = turboList.last.photourl!;
          getTurbocreatedBy.value = turboList.last.createdBy!;
          //lstTask.clear();
        } else {
          showSnackBar("Add Turbo", "Failed to Add Turbo", Colors.red);
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

  // Update Turbo
  void updateTurbo(int id, Turbo turbo) {
    Map data = {
      'name': turbo.name,
      'tanim1': turbo.tanim1,
      'tanim2': turbo.tanim2,
      'code': turbo.code,
      'photourl': 'photourl',
      'created_by': 'admin',
    };
    try {
      isLoading(true);
      TurboProvider().updateTurbo(id, data).then((resp) {
        print(
            "TurboProvider().updateTurbo(id, data).then((resp) : ${resp.toString()}");
        showSnackBar("Edit Turbo", resp.toString(), Colors.green);
        if (resp == "Turbo successfully updated") {
          //clearTextEditingControllers();
          isLoading(false);
          fetchTurbos();
          showSnackBar("Edit Turbo", "Turbo Edited", Colors.green);
          getTurboname.value = turboList.last.name;
          getTurbocode.value = turboList.last.code;
          getTurbotanim1.value = turboList.last.tanim1;
          getTurbotanim2.value = turboList.last.tanim2;
          getTurbophotourl.value = turboList.last.photourl!;
          getTurbocreatedBy.value = turboList.last.createdBy!;

          //lstTask.clear();
        } else {
          showSnackBar("Edit Turbo", "Turbo not Updated", Colors.red);
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

  // Delete Turbo
  void deleteTurbo(int id) {
    try {
      isLoading(true);
      TurboProvider().deleteTurbo(id).then((resp) {
        isLoading(false);
        if (resp == "Turbo successfully deleted") {
          //lstTask.clear();
          fetchTurbos();
          showSnackBar("deleteTurbo Turbo", "Turbo Deleted", Colors.green);
        } else {
          showSnackBar("Delete Turbo", "Turbo not Deleted", Colors.red);
        }
      }, onError: (err) {
        isLoading(false);
        print("deleteTurbo Controller onError: ${err.toString()}");
        showSnackBar(
            "deleteTurbo Controller onError ", err.toString(), Colors.red);
      });
    } catch (exception) {
      isLoading(false);
      print("deleteTurbo Controller exception: ${exception.toString()}");
      showSnackBar(
          "deleteTurbo Controller exception", exception.toString(), Colors.red);
    }
  }
}
