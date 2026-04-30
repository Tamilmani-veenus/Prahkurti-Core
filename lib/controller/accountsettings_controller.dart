import '../constants/storage_constant.dart';
import '../controller/logincontroller.dart';
import '../login/animation_signinpage/welcomepage.dart';
import '../provider/authendication_provider.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSetingController  extends GetxController {

  LoginController loginController = Get.put(LoginController());
  final repassword_controller = TextEditingController();
  final password_controller = TextEditingController();


  changePasswordDetails(BuildContext context) async {
    Map<String, String> body = {
      "newPassword": password_controller.text.trim(),
      "confirmPassword": repassword_controller.text.trim(),
    };
    final value = await AuthendicationProvider.changePassword(body);
    if (value != null) {
      if (value.success == true) {
        BaseUtitiles.showToast(value.result);
        SessionStorage.removeUser();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
              (Route<dynamic> route) => false,
        );
      } else {
        BaseUtitiles.showToast(value?.result ?? "Password change failed");
      }
    }
    else {
      BaseUtitiles.showToast("Something Went Wrong..");
    }
  }
}