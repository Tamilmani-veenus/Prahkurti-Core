import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/logincontroller.dart';

import '../constants/storage_constant.dart';
import '../login/animation_signinpage/welcomepage.dart';
import '../provider/dashboard_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class Dashboard_Controller extends GetxController {

  LoginController loginController = Get.put(LoginController());

  RxList main_List = [].obs;


  Future DashboardEntryList() async {
    var response =
    await Dashboard_Provider.getDashboardAPI_List();
    if (response != null) {
      if (response.success == true) {
        main_List.value = [response.result];
        if (main_List.isNotEmpty) {
          return main_List.value;
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }







}
