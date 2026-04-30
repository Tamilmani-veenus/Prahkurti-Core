import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants/storage_constant.dart';
import '../controller/logincontroller.dart';
import '../controller/punch_in_controller.dart';
import '../controller/site_location_controller.dart';
import '../db_helper/db_manager.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../models/punch_in_model.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/print_logger.dart';
import 'internetissue.dart';
import 'package:http/http.dart' as http;

final http.Client _httpClient = http.Client();

/// Send Request.....

Future<http.StreamedResponse> send(http.BaseRequest request) async {
  return _httpClient.send(request);
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController =
  Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());

  ConnectivityResult? connectivityResult;
  bool? isConnectionSuccessful;

  String versionName = "";
  String code = "";



  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 3);
    Future.delayed(duration, () async {
      final ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        await BaseUtitiles.getDeviceDetails();
        SessionCheck();
        DBManager dbManager = DBManager();
        dbManager.database;
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InternetLostConnection()));
      }
    });
  }


  void SessionCheck() async {
    final value = await SessionStorage.readUser();

    loginController.seassion_values = value;
    if (value != null) {
      await loginController.getLoginNew_seassionvalues(context);
      if (loginController.user.value.success == true) {
        if (loginController.user.value.userId.toString() == loginController.seassion_values.userId.toString() &&
            loginController.user.value.userType.toString() == loginController.seassion_values.userType.toString() &&
            loginController.user.value.userPassword.toString() == loginController.seassion_values.userPassword.toString()) {
          if (loginController.user.value.userType == "A") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Dashboard_screen()));
          }
          else {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => DashboardScreen_OtherUser()));
          }
        }
        else {
          if (loginController.user.value.userType == "A") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Dashboard_screen()));
          }
          else {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => DashboardScreen_OtherUser()));
          }
        }
      }
      else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      }
    }
    else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Image.asset('assets/images/loading.gif'),
          ),
        ],
      ),
    );
  }
}
