import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../apimanager/apimanager.dart';
import '../controller/logincontroller.dart';
import '../login/animation_signinpage/signin_page.dart';
import '../models/authendication_model.dart';
import '../models/changepassword_response_model.dart';
import '../models/deviceIDres_model.dart';
import '../models/getDeviceCheck_model.dart';
import '../models/getversion_model.dart';
import '../models/punch_in_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class AuthendicationProvider {



  static Future getAuthendication(body,context,{from}) async {
    try {
      final response = await ApiManager.postAPICall(
        "${ApiConstant.AUTHENTICATION}",jsonEncode(body)
      );

      final res = userFromJson(response);
      return res;

    }  catch (error) {
      print("Error == $error");
      if(from!="session") {
        Navigator.pop(context);
      }
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }
  }

  static Future<List<AppVersionResponse>> getVersion() async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETVERSIONAPI).then((value) async{
      final res = appVersionResponseFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error.toString());
      print("Error == ${error.toString()}");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  ///-------Device Model Check---------------
  static deviceModelCheck(String body) async {
    var ratingRes = null;
    await ApiManager.postAPICall(ApiConstant.DeviceModelAPI, body).then((value) {
      var response = devicemodelFromJson(value);
      if (response.retString != null) {
        ratingRes = response.retString;
        return ratingRes;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return ratingRes;
  }



  /// Get punch in status provider.....


  static Future<GetPunchSatusResponse?> getPunchInStatusProvider() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GET_PUNCHIN_STATUS);
      print("response...${response}");
      return getPunchSatusResponseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future changePassword(body) async {
    try {
      var value = await ApiManager.putUpdateAPIButton("${ApiConstant.PUTCHANGEPASSWORDAPI}",jsonEncode(body));
      return changedPasswordResponseFromJson(value);
    } catch (error , e) {
      print(error);
      print("ERROR...${e}");
    }
  }


  static dynamic getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.toString();
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

}
