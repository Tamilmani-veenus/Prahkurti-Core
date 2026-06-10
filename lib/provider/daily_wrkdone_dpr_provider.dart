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

  static Future<DprItemListResponse?> get_Dpr_ItemList(int? Projectid, int? SiteId, int? Subcontid) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_DPR_ITEM_LIST}?projectId=$Projectid&siteId=$SiteId&subcontractorId=$Subcontid");
      return dprItemListResponseFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR...${e}");
      return null;
    }
  }


  static Future<DailywrkDoneDprEntrylistResmodel?> get_dpr_EntryList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_DPR_ENTRY_LIST}?fromDate=$frdate&toDate=$todate");
      return dailywrkDoneDprEntrylistResmodelFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> dpr_entryList_deleteAPI(int reqId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_DPR_ENTRYLIST_API}?id=$reqId");

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

  static Future<DprEditApimodel?> dpr_entryList_editAPI(int workId) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.GET_DPR_EDIT_API}?id=$workId");
      print('API Response: ${value}');
      return dprEditApimodelFromJson(value);

    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<DprTypeSucontResponse?> Dpr_getTypeSubcont(int? Projectid, int? SiteId, type,entryType) async {
    try {
      var value = await ApiManager.getAPICall(
          type=="Dprnew"?"${ApiConstant.GET_DPRNEW_SUBCONTRACTOR_LIST}?projectId=$Projectid&siteId=$SiteId&entryType=$entryType" :
          "${ApiConstant.GET_DPR_SUBCONTRACTOR_LIST}?projectId=$Projectid&siteId=$SiteId"
      );
      DprTypeSucontResponse data = dprTypeSucontResponseFromJson(value);
      return data;
    } catch (error) {
      print(error);
      return null;
    }
  }


  static Future<dynamic> SaveIemListScreenEntryAPI(DailywrkDoneDprItemlistSaveModel data, imagesPath,saveButton,id) async {
    try {

      final url = saveButton == RequestConstant.RESUBMIT || saveButton == RequestConstant.APPROVAL
          ? "${ApiConstant.PUT_DPR_UPDATE_API}?id=$id"
          : ApiConstant.DPR_SAVE_API;

      print("eeeee....${url}");

      final request = http.MultipartRequest(
        saveButton == RequestConstant.RESUBMIT || saveButton == RequestConstant.APPROVAL? 'PUT' : 'POST',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());

      final bodyData = data.toJson();
      bodyData.remove('SubContractDailyWorkDets');

      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      if (data.subContractDailyWorkDets != null && data.subContractDailyWorkDets!.isNotEmpty) {
        for (int i = 0; i < data.subContractDailyWorkDets!.length; i++) {
          final det = data.subContractDailyWorkDets![i];

          request.fields['SubContractDailyWorkDets[$i].id'] = (det.id ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].subContractDailyWorkMasId'] = (det.subContractDailyWorkMasId ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].subContarctWorkdetid'] = (det.subContarctWorkdetid ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].headItemId'] = (det.headItemId ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].subItemId'] = (det.subItemId ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].level3ItemId'] = (det.level3ItemId ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].itemDescription'] = (det.itemDescription ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].workType'] = (det.workType ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].boqCode'] = (det.boqCode ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].scaleId'] = (det.scaleId ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].siteId'] = (det.siteId ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].billStatus'] = (det.billStatus ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].cement'] = (det.cement ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].workRemarks'] = (det. workRemarks?? "-").toString();
          request.fields['SubContractDailyWorkDets[$i].qty'] = (det.qty ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].rate'] = (det.rate ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].amount'] = (det.amount ?? 0).toString();
          request.fields['SubContractDailyWorkDets[$i].avgLabRate'] = (det.avgLabRate ?? 0).toString();
        }
      }

      if (imagesPath.isNotEmpty) {
        for (File file in imagesPath) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'DPRImg',
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
      return jsonDecode(responseBody);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


}