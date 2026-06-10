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

  Future DirectBill_EntryList() async {
    main_List.value.clear();
    await Dashboard_Provider.getDashboardAPI_List(loginController.user.value.userType.toString()).then((value) async {
      if (value != null && value.length > 0) {
        main_List.value = value;
        return main_List.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }


}
