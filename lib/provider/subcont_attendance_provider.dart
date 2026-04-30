import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../apimanager/apimanager.dart';
import '../models/get_atten_image.dart';
import '../models/labr_atten_response.dart';
import '../models/punch_in_model.dart';
import '../models/subcon_image_payload.dart';
import '../models/subcont_attendance_etrylistresponse_model.dart';
import '../models/subcont_attendentrylist_editresponse.dart';
import '../models/subcont_entry_showclick_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class SubContAttendanceProvider {

  static Future<List<SubContEntryShowResponse>> getShowPopupList(int subId, int projectId) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.GETSUBCONT_ENTRY_SHOW_CLICK}?id=$subId&PID=$projectId").then((value) {
      print("SubContEntryShowClick:" + value);
      data = subContEntryShowResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return data;
  }

  static Future<SubContEntryShowResponse?> getSubcontAttenDetList(int projectId,int subId) async {
   try{
    final value =await ApiManager.getAPICall("${ApiConstant.GETSUBCONTATTEND_CLICK}?projectId=$projectId&subcontId=$subId");
      return subContEntryShowResponseFromJson(value);
    }
   catch (error, e) {
     print(error);
     print("ERROR...${e}");
     return null;
   }
  }


  ///New Code

  static Future<dynamic> saveSubContScreenEntryAPI(SubcontEntryScreenSaveRequest data, imagesPath) async {
    try {
      final url =  ApiConstant.SUBCONTLABATTAENDANCE_SAVE_API;
      print("eeeee....${url}");

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());

      final bodyData = data.toJson();
      bodyData.remove('SubContLabourAttendDetS');

      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      if (data.subContLabourAttendDetS != null && data.subContLabourAttendDetS!.isNotEmpty) {
        for (int i = 0; i < data.subContLabourAttendDetS!.length; i++) {
          final det = data.subContLabourAttendDetS![i];

          request.fields['SubContLabourAttendDetS[$i].id'] = (det.id ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].rate'] = (det.rate ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].otHrs'] = (det.otHrs ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].otNos'] = (det.otNos ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].subContLabourMasId'] = (det.subContLabourMasId ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].eveotAmt'] = (det.eveotAmt ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].eveotHrs'] = (det.eveotHrs ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].nos'] = (det.nos ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].morotAmt'] = (det.morotAmt ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].remarks'] = (det.remarks ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].morotHrs'] = (det.morotHrs ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].extra'] = (det.extra ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].extraAmt'] = (det.extraAmt ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].labourId'] = (det.labourId ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].totalAmount'] = (det.totalAmount ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].labourCategoryId'] = (det.lbrCatId ?? 0).toString();
          request.fields['SubContLabourAttendDetS[$i].siteId'] = (det.siteId ?? 0).toString();

        }
      }

      if (imagesPath.isNotEmpty) {
        for (File file in imagesPath) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'DLRImg',
              file.path,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }
      }

      if (kDebugMode) {
        print("Fields: ${request.fields}");
        print("Files: ${request.files.map((f) => f.filename).toList()}");
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print("ssssssssss...${jsonDecode(responseBody)}");
      return jsonDecode(responseBody);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


  static Future<SubContAttendanceEntrylistRes?> getSubcontAttenEntry_List(String frdate, String todate) async {

    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETSUBCONT_ATTEN_ENTRY_LIST}?FromDate=$frdate&ToDate=$todate");
      SubContAttendanceEntrylistRes data = subContAttendanceEntrylistResFromJson(value);
      return data;

    } catch (error, e) {
      print(error);
      print("ERROR...${e}");
      BaseUtitiles.showToast('Something went wrong..');
      return null;

    }
  }


  static Future<bool> subcont_entryList_deleteAPI(int attendId) async {
    try {
      final response = await ApiManager.deleteAPICall(
        "${ApiConstant.DELETE_SUBCONT_ENTRYLIST_API}?id=$attendId",
      );

      final Map<String, dynamic> decoded = jsonDecode(response);

      bool isSuccess = decoded["success"] == true;

      final message = decoded["message"] ??
          (isSuccess
              ? "Deleted successfully"
              : "Something went wrong");

      BaseUtitiles.showToast(message);

      return isSuccess;
    } catch (error) {
      print("Delete API Error: $error");
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      return false;
    }
  }

  static Future<SubContAttendEntryListEditRes?> subcont_entryList_editAPI(int attendId) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.EDIT_SUBCONT_ENTRYLIST_API + "?LabrAttdId=$attendId");
      return subContAttendEntryListEditResFromJson(value);

    } catch (error, e) {
      print(error);
      print("ERROR...${e}");
      BaseUtitiles.showToast('Something went wrong..');
      return null;

    }
  }

  /// SubContractor Image provider.....

  // static Future<String> sendSingleImageProvider(SubConImagePayload data, File imageFile) async {
  //   try {
  //     Uri uri = Uri.parse(ApiConstant.SUBIMAGE_SAVEAPI);
  //     var request = http.MultipartRequest("POST", uri);
  //     dynamic bodyData = data.toJson();
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'File',
  //         imageFile.path,
  //         contentType: MediaType('image', 'jpeg'),
  //         filename: 'image.jpeg',
  //       ),
  //     );
  //     for (var field in bodyData.keys) {
  //       var value = bodyData[field];
  //       if (value is String) {
  //         request.fields[field] = value;
  //       }
  //     }
  //     request.headers["content-type"] = "application/json; charset=utf-8";
  //     final response = await http.Response.fromStream(await request.send());
  //     print("Request Data :: ${request.fields}");
  //     print("Request Data :: ${request.files}");
  //     print("Response Data :: ${response.body}");
  //     if (response.statusCode == 200){
  //       var punchInSaveRes = PunchInSaveRes(retString: response.body.toString());
  //       String ratingRes = punchInSaveRes.toString();
  //       await getResponse(response);
  //       return ratingRes;
  //     }
  //     else {
  //       await getResponse(response);
  //       throw Exception('Request failed with status code ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error sending request: $e');
  //     }
  //     rethrow;
  //   }
  // }

  /// Getting multiple image provider.....

  Future<GetAttenImage> gettingImageProvider(labId,dprId,from) async {
    const String contentType = "application/json; charset=utf-8";
    String url;
    if(from=="Subcont Attendance"){
      url = "${ApiConstant.GET_ATTEN_IMAGE_LIST}?LabrAttn_Id=$labId";
    }
    else{
      url = "${ApiConstant.GET_DPR_IMAGE_LIST}?DprId=$dprId";
    }
    print(url.toString());
    String method = "GET";
    http.Request request = http.Request(method, Uri.parse(url));
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    print("Response Data ::  ${response.body}");
    return GetAttenImage.fromJson(jsonDecode(response.body.toString()));
  }

  /// Delete image provider.....


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
