import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../apimanager/apimanager.dart';
import '../models/banknamelist_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/staffvoucher_entrylist_model.dart';
import '../models/staffvouchersiterequest_model.dart';
import '../models/staffvouchersiteresponse_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class StaffVoucher_provider{

  static Future<Staffvoucherentrylist?> getStaffVouc_Entry_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GETSTAFFVOC_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("SitevocEntryList:" + value);
      return staffvoucherentrylistFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  //--------BankName List--------------

  static Future<BankNamelistModel?> getBankName_List() async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_STAFFVOUCHER_BANKNAMELIST_API);
      print("SitevocEntryList:" + value);
      return bankNamelistModelFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }


  // -----------Save API------------

  static Future<dynamic> SaveSitevoucherScreenEntryAPI(StaffvouchersiteRequest data, List<File> imagesPath, saveButton,id) async {
    try {
      final url = saveButton == RequestConstant.RESUBMIT
          ? "${ApiConstant.PUT_STAFFVOUCHER_UPDATE_API}?id=$id"
          : ApiConstant.STAFFVOUCHER_SAVE;

      print('API url: ${url}');

      final request = http.MultipartRequest(
        saveButton == RequestConstant.RESUBMIT ? 'PUT' : 'POST',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());


      final bodyData = data.toJson();
      bodyData.remove('AccStaffVocSWpaymentS');

      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      if (data.AccStaffVocSWpaymentS != null && data.AccStaffVocSWpaymentS!.isNotEmpty) {
        for (int i = 0; i < data.AccStaffVocSWpaymentS!.length; i++) {
          final det = data.AccStaffVocSWpaymentS![i];

          request.fields['AccStaffVocSWpaymentS[$i].id'] = (det.id ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].staffVocherId'] = (det.staffVocherId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].payType'] = (det.payType ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].amount'] = (det.amount ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].siteId'] = (det.siteId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].tdsPercentage'] = (det.tdsPercentage ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].tdsAmount'] = (det.tdsAmount ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].netAmount'] = (det.netAmount ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].purOrdMasId'] = (det.purOrdMasId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].purOrdBillMasId'] = (det.purOrdBillMasId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].workOrderId'] = (det.workOrderId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].workId'] = (det.workId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].nmrWorkId'] = (det.nmrWorkId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].nmrWorkDetId'] = (det.nmrWorkDetId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].siteId'] = (det.siteId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].projectId'] = (det.projectId ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].reqAmount'] = (det.reqAmount ?? 0).toString();
          request.fields['AccStaffVocSWpaymentS[$i].paymentReqId'] = (det.paymentReqId ?? 0).toString();
        }
      }

      if (imagesPath.isNotEmpty) {
        for (File file in imagesPath) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'staffVouImg',
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
      print("responseBodyyyyy...${jsonDecode(responseBody)}");
      return jsonDecode(responseBody);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

//---Delete API----

  static Future<bool> Staffvoucher_entryList_deleteAPI(int vocId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_STAFFVOUCHERSITE_ENTRYLIST_API}?id=$vocId");

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

  //--EditAPI

  static Future<StaffvouchereditResponse?> SitevoucherSite_entryList_editAPI(int VocId) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_STAFFVOUCHERSITE_EDIT_API + "?id=$VocId");
      print("SitevocEntryList:" + value);
      return staffvouchereditResponseFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

}