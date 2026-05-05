import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import '../apimanager/apimanager.dart';
import 'package:http/http.dart' as http;
import '../models/get_site_voc_image.dart';
import '../models/inwardimageres_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/site_voc_image_delete.dart';
import '../models/site_voc_image_payload.dart';
import '../models/site_voucher_entrylist_model.dart';
import '../models/sitevouchereditresponse_model.dart';
import '../models/sitevouchersave_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class Sitevoucher_provider{

  static Future<Sitevocentrylist?> getSiteVouc_Entry_List(String frdate, String todate) async {
    try{
    final value = await ApiManager.getAPICall(ApiConstant.GETSITEVOC_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("SitevocEntryList:" + value);
      return sitevocentrylistFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  ///---Save API---

  static Future<dynamic> SaveSitevoucherScreenEntryAPI(SitevoucherSaveRequest data, List<File> imagesPath, saveButton,id) async {
    try {
      final url = saveButton == RequestConstant.RESUBMIT
          ? "${ApiConstant.PUT_SITEVOUCHER_UPDATE_API}?id=$id"
          : ApiConstant.SITEVOUCHER_SAVE;

      print('API url: ${url}');

      final request = http.MultipartRequest(
        saveButton == RequestConstant.RESUBMIT ? 'PUT' : 'POST',
        Uri.parse(url),
      );

      request.headers.addAll(RequestConstant.postHeaders());


      final bodyData = data.toJson();
      bodyData.remove('accountSiteVoucherSWPayments');

      bodyData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      if (data.accountSiteVoucherSwPayments != null && data.accountSiteVoucherSwPayments!.isNotEmpty) {
        for (int i = 0; i < data.accountSiteVoucherSwPayments!.length; i++) {
          final det = data.accountSiteVoucherSwPayments![i];

          request.fields['accountSiteVoucherSWPayments[$i].id'] = (det.id ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].siteVoucherId'] = (det.siteVoucherId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].payType'] = (det.payType ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].projectId'] = (det.projectId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].siteId'] = (det.siteId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].purOrdmasId'] = (det.purOrdmasId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].purOrdBillmasId'] = (det.purOrdBillmasId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].workOrderId'] = (det.workOrderId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].workId'] = (det.workId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].nmrWorkDetId'] = (det.nmrWorkDetId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].nmrWorkId'] = (det.nmrWorkId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].paymentReqId'] = (det.paymentReqId ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].tdsPercentage'] = (det.tdsPercentage ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].tdsAmount'] = (det.tdsAmount ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].amount'] = (det.amount ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].netAmount'] = (det.netAmount ?? 0).toString();
          request.fields['accountSiteVoucherSWPayments[$i].reqAmount'] = (det.reqAmount ?? 0).toString();
        }
      }

      if (imagesPath.isNotEmpty) {
        for (File file in imagesPath) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'siteVouImg',
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

  ///---Delete API----

  static Future<bool> Sitevoucher_entryList_deleteAPI(int vocId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_SITEVOUCHER_ENTRYLIST_API}?id=$vocId");

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


  ///--EditAPI

  static Future<SitevouchereditResponse?> Sitevoucher_entryList_editAPI(int VocId) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.GET_SITEVOUCHER_EDIT_API}?id=$VocId");
      print('API Response: ${value}');
      return sitevouchereditResponseFromJson(value);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


  /// Getting multiple image provider.....

  Future<GetSiteVocImage> gettingImageProvider(vocId) async {
    const String contentType = "application/json; charset=utf-8";
    Uri uri = Uri.parse("${ApiConstant.GET_VOC_IMAGE_LIST}?voc_id=$vocId");
    print(uri.toString());
    String method = "GET";
    http.Request request = http.Request(method, uri);
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    print("Response Data ::  ${response.body}");
    return GetSiteVocImage.fromJson(jsonDecode(response.body.toString()));
  }

  /// Delete image provider.....

  Future<SiteVocImageDelete> deleteImageProvider(int imageId) async {
    const String contentType = "application/json; charset=utf-8";
    Uri uri = Uri.parse("${ApiConstant.SITE_VOC_IMAGE_DELETE}?ImageId=$imageId");
    print(uri.toString());
    String method = "DELETE";
    http.Request request = http.Request(method, uri);
    request.headers["content-type"] = contentType;
    http.StreamedResponse streamedRes = await http.Client().send(request);
    http.Response response = await http.Response.fromStream(streamedRes);
    await getResponse(response);
    print("Response Data ::  ${response.body}");
    return SiteVocImageDelete.fromJson(jsonDecode(response.body.toString()));
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