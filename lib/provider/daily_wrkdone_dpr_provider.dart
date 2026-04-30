import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../apimanager/apimanager.dart';
import '../models/dailywrk_don_dpr_entrylistres_model.dart';
import '../models/dailywrk_done_dpr_entrylist_editapi_model.dart';
import '../models/dailywrk_done_dpr_itemlist_model.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/dailywrk_done_dpr_typesubcont_response_model.dart';

import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class DPRProvider{

  static Future<List<DprItemListResponse>> get_Dpr_ItemList(
      int? Projectid, int? SiteId, int? Subcontid, String entryType) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_ITEM_LIST + "?PId=$Projectid&SId=$SiteId&SubId=$Subcontid&EntryType=$entryType").then((value) {
      print("DPRItemList:" + value);
      data = dprItemListResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return data;
  }

  static Future<List<DailywrkDoneDprEntrylistResmodel>> get_dpr_EntryList(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_ENTRY_LIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate").then((value) {
      print("DPREntryList:" + value);
      data = dailywrkDoneDprEntrylistResmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(error);
    });
    return data;
  }

  static Future dpr_entryList_deleteAPI(int WorkId,String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_DPR_ENTRYLIST_API + "?WorkId=$WorkId&WorkNo=$WorkNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        if(data=="Deleted"){
          BaseUtitiles.showToast("Deleted Successfully");
        }else{
          BaseUtitiles.showToast("$data");
        }
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return data;
  }

  static Future<List<DailywrkDoneDprEntrylistEditApiResmodel>> dpr_entryList_editAPI(int workId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_EDIT_API + "?WorkId=$workId").then((value) {
      final res = dailywrkDoneDprEntrylistEditApiResmodelFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future<List<DprTypeSucontResponse>> Dpr_getTypeSubcont(
      int? Projectid, int? SiteId, String entryType) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_SUBCONTRACTOR_LIST +
        "?PId=$Projectid&SId=$SiteId&EntryType=$entryType")
        .then((value) {
      print("SubcontType:" + value);
      data = dprTypeSucontResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return data;
  }

  // static SaveIemListScreenEntryAPI(body,workId,aprovedButton,int buttonControl,context) async {
  //   String? ratingRes;
  //
  //   try {
  //     dynamic value;
  //
  //     if (workId != 0) {
  //       // Approval update
  //       if (aprovedButton != 0) {
  //         value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_DPR_APROVE_API, body);
  //       } else {
  //         // Normal update
  //         value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_DPR_UPDATE_API, body);
  //       }
  //     } else {
  //       // New save
  //       value = await ApiManager.postAPICall(ApiConstant.DPR_SAVE_API, body);
  //     }
  //
  //     var response = dprItemscreenSaveResponseFromJson(value);
  //     if (response.RetString != null) {
  //       ratingRes = response.RetString;
  //     }
  //
  //   } on SocketException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
  //     if (Navigator.canPop(context)) Navigator.pop(context);
  //     return null;
  //   }
  //   on TimeoutException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
  //     if (Navigator.canPop(context)) Navigator.pop(context);
  //     return null;
  //   }
  //   on FormatException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
  //     if (Navigator.canPop(context)) Navigator.pop(context);
  //     return null;
  //   } catch (error) {
  //     print('❌ Error in SaveIemListScreenEntryAPI: $error');
  //     buttonControl = 0;
  //     BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //   }
  //
  //   return ratingRes;
  // }

  static Future<String?> SaveIemListScreenEntryAPI(DailywrkDoneDprItemlistSaveModel data,workId,aprovedButton,int buttonControl,context,List<File> imagesPath) async {
    String url;
    var request;

    // Determine the URL and HTTP method based on attendId and approvedButton
    if (workId != 0) {
      if(aprovedButton != 0){
        url = ApiConstant.PUT_DPR_APROVE_API;
        request = http.MultipartRequest('PUT', Uri.parse(url));
      }else{
        url = ApiConstant.PUT_DPR_UPDATE_API;
        request = http.MultipartRequest('PUT', Uri.parse(url));
      }
    }
    else {
      url = ApiConstant.DPR_SAVE_API;
      request = http.MultipartRequest('POST', Uri.parse(url));
    }

    if (kDebugMode) {
      print('Calling API: $url');
    }

    // Adding fields to the request
    Map<String, dynamic> bodyData = data.toJson();
    bodyData.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Convert attendanceDet to JSON and add to request fields
    if (data.dprDet != null && data.dprDet!.isNotEmpty) {
      request.fields['DprDet'] = json.encode(data.dprDet!.map((item) => item.toJson()).toList());
    }

    // Add image files if not null

      if (imagesPath.isNotEmpty) {
        for (File file in imagesPath) {
          var stream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(
            'Files',
            stream,
            length,
            filename: basename(file.path),
            contentType: MediaType('image', 'jpeg'),
          );
          request.files.add(multipartFile);
        }
      }


    if (kDebugMode) {
      print("Request Fields: ${request.fields}");
      // print("AttendanceDet Request Field: ${request.fields['AttendanceDet']}");
      print("Request Files: ${request.files.map((f) => f.filename).toList()}");
    }

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      if (kDebugMode) {
        print('ResponseData: $jsonResponse');
      }
      if (response.statusCode == 200) {
        var res = DprItemlistscreenSaveResponse.fromJson(jsonResponse);
        if (kDebugMode) {
          print('Response data: ${res.RetString}');
        }
        return res.RetString;
      } else {
        // dailyEntriesController.buttonControl = 0;
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
        return null;
      }

    } on SocketException catch (_) {
      BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    on TimeoutException catch (_) {
      BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    on FormatException catch (_) {
      BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    catch (e) {
      buttonControl = 0;
      if (kDebugMode) {
        print('Exception: $e');
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }
  }

}