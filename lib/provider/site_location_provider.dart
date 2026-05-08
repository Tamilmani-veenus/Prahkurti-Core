import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../apimanager/apimanager.dart';
import '../models/set_site_location_payload.dart';
import '../models/set_site_location_response.dart';
import '../models/site_location_payload.dart';
import '../models/site_location_response.dart';
import '../utilities/apiconstant.dart';

class SiteLocationProvider {

  /// Site Location Name Provider.....

  static Future<SiteLocationResponse?> siteLocationProvider(userId,empId,punchId,check,status,userType,projectName) async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GET_SITE_LOCATION+"?Id=0&EmployeeID=$empId&status=$status&check=$check&projectName=$projectName");
      print("response...${response}");
      return siteLocationResponseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }


  /// Set Site Location Provider.....

  static setSiteLocationAPI(SetSiteLocationPayload body) async {

    try {
        final response = await ApiManager.postAPICall(ApiConstant.SET_SITE_LOCATION, jsonEncode(body.toJson()));

        return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
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