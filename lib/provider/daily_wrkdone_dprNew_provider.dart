import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import '../apimanager/apimanager.dart';
import '../models/dailywrk_don_dpr_entrylistres_model.dart';
import '../models/dailywrk_don_dprnew_det_editres.dart';
import '../models/dailywrk_don_dprnew_editresapi.dart';
import '../models/dailywrk_done_dpr_new_save_api_model.dart';
import '../models/dailywrkdon_dprNew_getBoqdetailsRes.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class DPR_New_Provider{

  static Future<GetDprNewBoqListModel?> dprNew_getBoqDetails(int? PId, int SId, int SubId,int Headid, String EntryType) async {
    try{
      final value =await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_BOQDETAILSLIST + "?projectId=$PId&siteId=$SId&subcontractorId=$SubId&headItemId=$Headid&entryType=$EntryType");
      return getDprNewBoqListModelFromJson(value);
    }
    catch (error, e) {
      print(error);
      print("ERROR...${e}");
      return null;
    }
  }

  static Future<dynamic> DPR_NEW_SaveAPI(DprNewSaveReq data, List<File> imagesPath, saveButton,id) async {
    try {
      final url = saveButton == RequestConstant.RESUBMIT || saveButton==RequestConstant.APPROVAL
          ? "${ApiConstant.PUT_DPR_NEW_UPDATE_API}?id=$id"
          : ApiConstant.DPR_NEW_SAVE_API;

      print("url....${url}");

      final request = http.MultipartRequest(
        saveButton == RequestConstant.RESUBMIT || saveButton == RequestConstant.APPROVAL? 'PUT' : 'POST',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());


      final bodyData = data.toJson();
      bodyData.remove('SubContractDailyWorkDets');
      bodyData.remove('SubcontractDailyWorkLabours');
      bodyData.remove('SubcontractDailyWorkCements');
      bodyData.remove('SubcontractDailyWorkMeasurements');

      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      if (data.subContractDailyWorkDets != null && data.subContractDailyWorkDets!.isNotEmpty) {
        for (int i = 0; i < data.subContractDailyWorkDets!.length; i++) {
          final det = data.subContractDailyWorkDets![i];

          request.fields['SubContractDailyWorkDets[$i].id'] =
              (det.id ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].subContractDailyWorkMasId'] =
              (det.subContractDailyWorkMasId ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].subContarctWorkdetid'] =
              (det.subContarctWorkdetid ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].cement'] =
              (det.cement ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].rate'] =
              (det.rate ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].workRemarks'] =
              (det.workRemarks ?? '').toString();

          request.fields['SubContractDailyWorkDets[$i].siteId'] =
              (det.siteId ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].scaleId'] =
              (det.scaleId ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].itemDescription'] =
              (det.itemDescription ?? '').toString();

          request.fields['SubContractDailyWorkDets[$i].workType'] =
              (det.workType ?? '').toString();

          request.fields['SubContractDailyWorkDets[$i].headItemId'] =
              (det.headItemId ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].subItemId'] =
              (det.subItemId ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].boqCode'] =
              (det.boqCode ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].qty'] =
              (det.qty ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].amount'] =
              (det.amount ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].billStatus'] =
              (det.billStatus ?? '').toString();

          request.fields['SubContractDailyWorkDets[$i].avgLabRate'] =
              (det.avgLabRate ?? 0).toString();

          request.fields['SubContractDailyWorkDets[$i].level3ItemId'] =
              (det.level3ItemId ?? 0).toString();
        }
      }
      if (data.subcontractDailyWorkLabours != null && data.subcontractDailyWorkLabours!.isNotEmpty) {
        for (int i = 0; i < data.subcontractDailyWorkLabours!.length; i++) {
          final det = data.subcontractDailyWorkLabours![i];

          request.fields['SubcontractDailyWorkLabours[$i].id'] =
              (det.id ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].subContractDailyWorkMasId'] =
              (det.subContractDailyWorkMasId ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].otHrs'] =
              (det.otHrs ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].wages'] =
              (det.wages ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].subContractorId'] =
              (det.subContractorId ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].nos'] =
              (det.nos ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].amount'] =
              (det.amount ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].categoryId'] =
              (det.categoryId ?? 0).toString();

          request.fields['SubcontractDailyWorkLabours[$i].otAmount'] =
              (det.otAmount ?? 0).toString();
        }
      }
      if (data.subcontractDailyWorkCements != null && data.subcontractDailyWorkCements!.isNotEmpty) {
        for (int i = 0; i < data.subcontractDailyWorkCements!.length; i++) {
          final det = data.subcontractDailyWorkCements![i];

          request.fields['SubcontractDailyWorkCements[$i].id'] =
              (det.id ?? 0).toString();

          request.fields['SubcontractDailyWorkCements[$i].subContractDailyWorkMasId'] =
              (det.subContractDailyWorkMasId ?? 0).toString();

          request.fields['SubcontractDailyWorkCements[$i].materialId'] =
              (det.materialId ?? 0).toString();

          request.fields['SubcontractDailyWorkCements[$i].scaleId'] =
              (det.scaleId ?? 0).toString();

          request.fields['SubcontractDailyWorkCements[$i].qty'] =
              (det.qty ?? 0).toString();

        }
      }
      if (data.subcontractDailyWorkMeasurements != null && data.subcontractDailyWorkMeasurements!.isNotEmpty) {
        for (int i = 0; i < data.subcontractDailyWorkMeasurements!.length; i++) {
          final det = data.subcontractDailyWorkMeasurements![i];

          request.fields['SubcontractDailyWorkMeasurements[$i].id'] =
              (det.id ?? 0).toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].subContractDailyWorkMasId'] =
              (det.subContractDailyWorkMasId ?? 0).toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].descriptionWork'] =
              (det.descriptionWork ?? '').toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].no'] =
              (det.no ?? 0).toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].length'] =
              (det.length ?? 0).toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].breadth'] =
              (det.breadth ?? 0).toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].depth'] =
              (det.depth ?? 0).toString();

          request.fields['SubcontractDailyWorkMeasurements[$i].qty'] =
              (det.qty ?? 0).toString();
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


  static Future getMaterial(projectId,siteId,level3ItemId) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_MATERIAL_API + "?projectId=$projectId&siteId=$siteId&level3ItemId=$level3ItemId");
      return jsonDecode(value);
    } catch (error,e) {
      print(error);
      print("ERROR...${e}");
      return null;
    }
  }

  static Future<DailywrkDoneDprEntrylistResmodel?> get_dprNew_EntryList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_DPR_NEW_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      return dailywrkDoneDprEntrylistResmodelFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future<DailywrkdonDprNewEditApiRes?> dpr_New_entryList_editAPI(int workId) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_EDIT_API + "?id=$workId");
      return dailywrkdonDprNewEditApiResFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future<DprNewDetEditApi?> dpr_New_entryList_detEditAPI(int workId) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_DET_EDIT_API + "?masId=$workId");
      return dprNewDetEditApiFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future<bool> dprNew_entryList_deleteAPI(int workId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_DPRNEW_ENTRYLIST_API}?id=$workId");

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

}