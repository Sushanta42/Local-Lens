import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_lens/service/service.dart';

class ProblemController extends GetxController {
  var problems = [].obs;
  var isLoading = false.obs;
  var problemsbyid = [].obs;

  //Get upcoming
  Future getProblems() async {
    try {
      isLoading(true);
      var response = await RemoteService.fetchProblems();
      // if (response != null) {
      problems.value = response;
      // }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      // debugPrint("$e");
    } finally {
      isLoading(false);
    }
  }

  Future getProblemsId(var id) async {
    try {
      isLoading(true);
      var response = await RemoteService.fetchProblemById(id);
      if (response != null) {
        problemsbyid.value = response;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      debugPrint("$e");
    } finally {
      isLoading(false);
    }
  }

  // Method to update problems list
  // void updateProblems(List newProblems) {
  //   problems.assignAll(newProblems);
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProblems();
  }
}
