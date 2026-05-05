import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import '../models/getting_image_response.dart';
import '../models/image_delete_response.dart';
import '../models/image_payload.dart';
import '../models/inward_pending_alldatasres_model.dart';
import '../models/inwardimageres_model.dart';
import '../models/inwardpending_editapi_res_model.dart';
import '../models/inwardpending_save_apireq_model.dart';
import '../models/inwardpoamd_model.dart';
import '../models/onclickpendingdet_model.dart';
import '../models/poamdapproveres_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/requestconstant.dart';
import '../apimanager/apimanager.dart';
import '../models/inward_pending_entrylist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class Inward_Pending_provider {

  static Future<InwardAllDatasaRes?> getInward_ALLDatas(int? PoId) async {
    var response;
    try{
      response = await ApiManager.getAPICall(ApiConstant.GETMATERIALINWARD_ALLDATAS + "?PoId=$PoId");
      return inwardAllDatasaResFromJson(response);
    }
    catch (error , e) {
      print("Error == $error");
      return null;
    }
  }

  static Future<GetInwardListResponse?> getInwardEntry_List(int? Userid, String UserType, String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETINWARD_ENTRY_LIST}?FromDate=$frdate&ToDate=$todate");

      GetInwardListResponse data = getInwardListResponseFromJson(value);
      return data;
    } catch (error, stackTrace) {
      print("ERROR: $error");
      print("STACK TRACE: $stackTrace");
      return null;
    }
  }


  /// -----Po Amendment List-----------

  static Future<OnclickPendingDet?> getPoAmendment(int purOrdId) async {
    var response;
    try{
      response = await ApiManager.getAPICall("${ApiConstant.INWARD_MOREDETAILS}?PoId=$purOrdId");
      return onclickPendingDetFromJson(response);
    }
    catch (error , e) {
      print("Error == $error");
      return null;
    }
  }

  /// ----------PoAmendment Approval API-----------


  // static Future<PoAmendmentApproveResModel?> inward_PoAmendment_ApprovalAPI(String body) async {
  //   PoAmendmentApproveResModel? ratingRes;
  //   await ApiManager.postAPICall(ApiConstant.POAMENDMENT_APPROVAL_SAVEAPI, body).then((value) {
  //     var response = poAmendmentApproveResModelFromJson(value);
  //     if (response.retString != null) {
  //       ratingRes = response.retString;
  //       return ratingRes;
  //     }
  //   }, onError: (error) {
  //     print(error);
  //     BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //   });
  //   return ratingRes;
  // }


  static Future inward_PoAmendment_ApprovalAPI(String body) async {
    try {
      var value = await ApiManager.postAPICall(ApiConstant.POAMENDMENT_APPROVAL_SAVEAPI,body);
      final Map<String, dynamic> decoded = jsonDecode(value);

      if (decoded["success"] == true) {
        return decoded["message"];
      } else {
        return decoded["message"] ?? "Something went wrong";
      }
    } catch (error, e) {
      print("ERROR...${e}");
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      return null;
    }
  }


  ///-----invoiceNO and DCNo checking API----
  static Future invoice_DcNoCheck(String inwardNo,String invoiceNo,String dcNo,String supplierId,String inwardId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_INVOICEANDDCNOCHECK + "?InwardNo=$inwardNo&invoiceNo=$invoiceNo&partyDcNo=$dcNo&supplierId=$supplierId&inwardid=$inwardId").then((value) {
      print("invoice_DcNoCheck:" + value);
      data = value;
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(error);
    });
    return data;
  }

  static Future<dynamic> inward_Save(InwardPendingSaveReq data, List<File> imagesPath, saveButton,id) async {
      try {
        final url = saveButton == RequestConstant.RESUBMIT
            ? "${ApiConstant.PUT_INWARDPENDING_UPDATE_API}/$id"
            : ApiConstant.INWARDPENDING_SAVE_API;

        final request = http.MultipartRequest(
          saveButton == RequestConstant.RESUBMIT ? 'PUT' : 'POST',
          Uri.parse(url),
        );

        request.headers.addAll(RequestConstant.postHeaders());


        final bodyData = data.toJson();
        bodyData.remove('MaterialInwardMasLink');

        bodyData.forEach((key, value) {
          if (value != null) {
            request.fields[key] = value.toString();
          }
        });

        if (data.inwardDet != null && data.inwardDet!.isNotEmpty) {
          for (int i = 0; i < data.inwardDet!.length; i++) {
            final det = data.inwardDet![i];

            request.fields['MaterialInwardMasLink[$i].id'] =
                (det.id ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].materialInwardMasID'] =
                (det.materialInwardMasID ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].purOrdDetId'] =
                (det.purOrdDetId ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].materialID'] =
                (det.materialID ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].scaleID'] =
                (det.scaleID ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].qty'] =
                (det.qty ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].rate'] =
                (det.rate ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].amount'] =
                (det.amount ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].balQty'] =
                (det.balQty ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].addQty'] =
                (det.addQty ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].lessQty'] =
                (det.lessQty ?? 0).toString();

            request.fields['MaterialInwardMasLink[$i].AMDCheck'] =
                det.AMDCheck ?? "N";
          }
        }

        if (imagesPath.isNotEmpty) {
          for (File file in imagesPath) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'inwardImg',
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


  static Future<InwardPendingEditApiRes?> entryList_editAPI(int inwardId, String type) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.EDIT_INWARDPENDING_API}?InwardId=$inwardId&InwardType=$type");
      print('API Response: ${value}');
     return inwardPendingEditApiResFromJson(value);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<dynamic> InwardStatusCheckApi(int inwardId) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.GETINWARDSTATUSCHECKAPI}?inwId=$inwardId");
      print('API Response: ${value}');
      return jsonDecode(value);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }



  static Future<bool> entryList_deleteAPI(int InwId) async {
    try {
      final response = await ApiManager.deleteAPICall("${ApiConstant.DELETE_INWARDPENDINGLIST_API}/$InwId");

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

  static Future<dynamic> gettingImageProvider(int Id,String type) async {
    try {
      final value = await ApiManager.getAPICall(
          type=="inward"?"${ApiConstant.GET_INWARD_IMAGE_LIST}?id=$Id":
          type=="siteVoucher"?"${ApiConstant.GET_VOC_IMAGE_LIST}?id=$Id":
          "${ApiConstant.GET_DLR_IMAGE_LIST}?id=$Id");
      print('API Response: ${value}');
      return gettingImageFromJson(value);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


  /// Delete image provider.....


  static Future<bool> deleteImageProvider(int imageId,String type) async {
    try {
      final response = await ApiManager.deleteAPICall(
          type=="inward"?"${ApiConstant.DELETE_INWARD_IMAGE_API }?inwId=$imageId":
          type=="siteVoucher"?"${ApiConstant.SITE_VOC_IMAGE_DELETE }?Id=$imageId":
          "${ApiConstant.DELETE_DLR_IMAGE_API }?imgId=$imageId");

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
