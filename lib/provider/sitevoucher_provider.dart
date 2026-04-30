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

  /// -----------Save API------------

  // static SaveSitevoucherScreenEntryAPI(String body, int vocid) async {
  //   var ratingRes = null;
  //   if(vocid!=0){
  //     await ApiManager.putUpdateAPIButton(ApiConstant.PUT_SITEVOUCHER_UPDATE_API, body).then(
  //             (value) {
  //           var response = saveDeduction_SaveResponseFromJson(value);
  //           if (response.RetString != null) {
  //             ratingRes = response.RetString;
  //             return ratingRes;
  //           }
  //         }, onError: (error) {
  //       print(error);
  //       BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //     });
  //   }
  //   else{
  //     await ApiManager.postAPICall(
  //         ApiConstant.SITEVOUCHER_SAVE, body)
  //         .then((value) {
  //       var response = saveDeduction_SaveResponseFromJson(value);
  //       if (response.RetString != null) {
  //         ratingRes = response.RetString;
  //         return ratingRes;
  //       }
  //     }, onError: (error) {
  //       print(error);
  //       BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //     });
  //   }
  //   return ratingRes;
  // }

  ///---Save API---

  // static Future<String?> SaveSitevoucherScreenEntryAPI(int vocid, Sitevouchersaverequest data, imagesPath, buttonControl,context) async {
  //   var request;
  //   String url;
  //   if (vocid != 0) {
  //     url = ApiConstant.PUT_SITEVOUCHER_UPDATE_API;
  //     request = http.MultipartRequest('PUT', Uri.parse(url));
  //   } else {
  //     url = ApiConstant.SITEVOUCHER_SAVE;
  //     request = http.MultipartRequest('POST', Uri.parse(url));
  //   }
  //   if (kDebugMode) {
  //     print('Calling API: $url');
  //   }
  //
  //   Map<String, dynamic> bodyData = data.toJson();
  //
  //   bodyData.forEach((key, value) {
  //     if (value != null) {
  //       request.fields[key] = value.toString();
  //     }
  //   });
  //
  //   // Serialize VocDet into a JSON string
  //   if (bodyData.containsKey('VocDet')) {
  //     request.fields['VocDet'] = jsonEncode(bodyData['VocDet']);
  //     bodyData.remove('VocDet'); // Remove it from bodyData to avoid double encoding
  //   }
  //
  //   if (imagesPath != null) {
  //     for (File file in imagesPath!) {
  //       var stream = http.ByteStream(file.openRead());
  //       var length = await file.length();
  //       var multipartFile = http.MultipartFile(
  //         'Files',
  //         stream,
  //         length,
  //         filename: basename(file.path),
  //         contentType: MediaType('image', 'jpeg'),
  //       );
  //       request.files.add(multipartFile);
  //     }
  //   }
  //
  //   print("Request Fields: ${request.fields}");
  //   print("Request Files: ${request.files.map((f) => f.filename).toList()}");
  //   var responseBody;
  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       responseBody = await response.stream.bytesToString();
  //       var jsonResponse = json.decode(responseBody);
  //       print('Response: $jsonResponse');
  //       var res = InwardImageRes.fromJson(jsonResponse);
  //       print('Response data: ${res.retString}');
  //       return res.retString;
  //     } else {
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //       BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
  //       return null;
  //     }
  //   } on SocketException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //   on TimeoutException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //   on FormatException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //   catch (e) {
  //     buttonControl=0;
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //     print('Exception: $e');
  //     return null;
  //   }
  // }


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

  static Future<List<SitevouchereditResponse>> Sitevoucher_entryList_editAPI(int VocId) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.GET_SITEVOUCHER_EDIT_API}?VocId=$VocId").then((value) {
      final res = sitevouchereditResponseFromJson(value);
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

  /// Sending multiple image provider.....

  Future<InwardImageRes> sendMultipleImageProvider(SiteVocImagePayload data,List<File> imagesPath) async {
    const String contentType = "application/json; charset=utf-8";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiConstant.SITEVOCIMAGE_SAVEAPI));
      if (kDebugMode) {
        print("Calling API: ${ApiConstant.SITEVOCIMAGE_SAVEAPI}");
      }
      Map<String, dynamic> bodyData = data.toJson();
      for (var i = 0; i < imagesPath.length; i++) {
        print("Index value :: $i");
        var imageFile = imagesPath[i];
        request.files.add(
          await http.MultipartFile.fromPath(
            'VocFile',
            imageFile.path,
            contentType: MediaType('image', 'jpeg'),
            filename: 'image_$i.jpeg',
          ),
        );
      }
      for (var field in bodyData.keys) {
        var value = bodyData[field];
        if (value is String || value is num) {
          request.fields[field] = value.toString();
        }
      }
      request.headers["content-type"] = contentType;
      var response = await http.Response.fromStream(await request.send());
      if (kDebugMode) {
        print("Request Data :: ${request.fields}");
        print("Request Data :: ${request.files}");
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Status code ::: ${response.statusCode}");
        }
        await getResponse(response);
        return InwardImageRes.fromJson(jsonDecode(response.body.toString()));
      } else if(response.statusCode == 500) {
        if (kDebugMode) {
          print("Status code ::: ${response.statusCode}");
        }
        await getResponse(response);
        throw Exception('Failed to upload images: ${response.reasonPhrase}');
      } else {
        await getResponse(response);
        throw Exception('Failed to upload images: ${response.reasonPhrase}');
      }
    } on SocketException {
      throw Exception(RequestConstant.NOINTERNETCONNECTION);
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