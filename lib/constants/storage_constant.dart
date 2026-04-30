import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prahkurticore/utilities/print_logger.dart';
import '../models/authendication_model.dart';
import 'package:get_storage/get_storage.dart';
import '../models/login_details_payload.dart';
import '../models/punch_in_payload.dart';
import '../models/punch_out_payload.dart';
import '../models/site_location_response.dart';

class SessionStorage {

  static const String KEYUSERSESSION = 'myUser';
  static Future init() async => await GetStorage.init();

  static writeUser(User user) {
    String json = userToJson(user);
    final datacount = GetStorage();
    datacount.write(KEYUSERSESSION, json);
  }

  static User? readUser() {
    final datacount = GetStorage();
    var json = datacount.read(KEYUSERSESSION);
    if(kDebugMode){
      printToLog('GetSessionStorage :: $json');
    }
    return json == null ? null : userFromJson(json);
  }

  static removeUser() {
    final datacount = GetStorage();
    datacount.remove(KEYUSERSESSION);
  }
}

class ServiceLocalDatabaseService {

  static Future<dynamic> flashSecureLocalState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print("Delete token");
    }
    await prefs.clear();
  }

  /// Store single string values to local date base

  static Future<dynamic> saveLocalStateProp(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key.isEmpty) {
      return;
    }
    await prefs.setString(key, value);
  }

  /// Get single string values to local data base

  static Future<String?> getLocalStateProp(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prop = prefs.getString(key);
    print("prof value :: $prop");
    return prop ?? "0";
  }

  /// Store the login details to local data base

  static Future<void> saveLoginDetails(List<LoginDetailsPayload> newDetails,String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> loginDetailsJson = newDetails.map((details) => details.toJson()).toList();
    print("Saved values :: $loginDetailsJson");
    await prefs.setStringList(key, loginDetailsJson);
  }

  /// Get the login details to local data base

  static Future<List<LoginDetailsPayload>> getLoginDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> loginDetailsJson = prefs.getStringList(key) ?? [];
    print("Login details :: $loginDetailsJson");
    return loginDetailsJson.map((json) => LoginDetailsPayload.fromJson(json)).toList();
  }

  /// Delete the login details to local data base

  static Future<void> deleteLoginDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Store the site location details to local data base

  static Future<void> saveSiteLocation(SiteLocationResponse siteLocation,String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(siteLocation.toJson()));
  }

  /// Get the site location details to local data base

  static Future<SiteLocationResponse> getSiteLocation(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? siteLocationJson = prefs.getString(key);
    if (siteLocationJson != null) {
      return SiteLocationResponse.fromJson(json.decode(siteLocationJson));
    } else {
      return SiteLocationResponse();
    }
  }

  /// Delete the site location details to local data base

  static Future<void> deleteSiteLocationDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Store the punch In details to local data base

  static Future<void> savePunchInDetails(List<PunchInPayload> newDetails,String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> punchInJson = newDetails.map((details) => details.toJson()).toList();
    await prefs.setStringList(key, punchInJson);
  }

  /// Get the punch in details to local data base

  static Future<List<PunchInPayload>> getPunchInDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> punchInJson = prefs.getStringList(key) ?? [];
    print("Getting punch in details from local :: $punchInJson");
    return punchInJson.map((json) => PunchInPayload.fromJson(json)).toList();
  }

  /// Delete the punch in details to local data base

  static Future<void> deletePunchInDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Store the punch out details to local data base

  static Future<void> savePunchOutDetails(List<PunchOutPayload> newDetails,String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> punchOutJson = newDetails.map((details) => details.toJson()).toList();
    await prefs.setStringList(key, punchOutJson);
  }

  /// Get the punch out details to local data base

  static Future<List<PunchOutPayload>> getPunchOutDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> punchOutJson = prefs.getStringList(key) ?? [];
    print("Getting punch out details from local :: $punchOutJson");
    return punchOutJson.map((json) => PunchOutPayload.fromJson(json)).toList();
  }

  /// Delete the punch out details to local data base

  static Future<void> deletePunchOutDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

}


