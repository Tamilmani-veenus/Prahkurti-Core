import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_parser/http_parser.dart';
import '../apimanager/apimanager.dart';
import '../models/getpunchtype_model.dart';
import '../models/punch_filter_response.dart';
import '../models/punch_in_model.dart';
import '../models/today_punch_in_response.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../utilities/apiconstant.dart';
import 'package:http/http.dart' as http;
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class PunchInProvider {

  final http.Client _httpClient = http.Client();

  /// Send Request.....

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return _httpClient.send(request);
  }

  /// Punch In provider.....

  static Future<dynamic> punchInProvider(PunchInSaveModel data, File imageFile,context) async {
    try {
      Uri uri = Uri.parse(ApiConstant.PUNCH_IN);
      print("Image Sending Uri ::::: $uri");

      var request = http.MultipartRequest("POST", uri);
      dynamic bodyData = data.toJson();
      request.files.add(
        await http.MultipartFile.fromPath(
          'PunchInImageFile',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.headers.addAll(RequestConstant.postHeaders());

      for (var field in bodyData.keys) {
        var value = bodyData[field];
        if (value != null) {
          request.fields[field] = value.toString(); // ✅ FIX
        }
      }

      request.fields.forEach((key, value) {
        print("FIELD: $key => $value");
      });

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("response...${jsonDecode(responseBody)}");

      return jsonDecode(responseBody);

    } catch (error,e) {
      if (kDebugMode) {
        print('Error sending request: $error');
        print('Error sending request: $e');
      }
      return null;
    }
  }

  /// Punch Out Provider.....

  static Future<dynamic> punchOutProvider(PunchOutSaveModel data, File imageFile, context) async {
    try {
      Uri uri = Uri.parse(ApiConstant.PUNCH_IN);
      print("Image Sending Uri ::::: $uri");

      var request = http.MultipartRequest("POST", uri);
      dynamic bodyData = data.toJson();
      request.files.add(
        await http.MultipartFile.fromPath(
          'PunchOutImageFile',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.headers.addAll(RequestConstant.postHeaders());

      for (var field in bodyData.keys) {
        var value = bodyData[field];
        if (value != null) {
          request.fields[field] = value.toString(); // ✅ FIX
        }
      }

      request.fields.forEach((key, value) {
        print("FIELD: $key => $value");
      });

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("response...${jsonDecode(responseBody)}");

      return jsonDecode(responseBody);
    }catch (error,e) {
      if (kDebugMode) {
        print('Error sending request: $error');
        print('Error sending request: $e');
      }
      return null;
    }
  }


  /// Today Punch In Provider.....


  static Future<TodayPunchInResponse?> todayPunchInProvider(String frdate, String todate,int? empId) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.OLDTODAY_PUNCHIN_STATUS}?FromDate=$frdate&ToDate=$todate&employeeID=$empId");
      TodayPunchInResponse data = todayPunchInResponseFromJson(value);
      return data;
    } catch (error, e) {
      print(error);
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<GetPunchTypeListRes?> getPunchTypeList() async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_PUNCH_TYPE_LIST);
      return getPunchTypeListResFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR....${e}");
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
            'Error occurred while communication with server with statusCode: ${response.statusCode}');
    }
  }

}