import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../apimanager/apimanager.dart';
import '../models/attendancereportlist_model.dart';
import '../models/dprlistresponse_model.dart';
import '../models/getstockprojwise_model.dart';
import '../models/inward_report_list_model.dart';
import '../models/materialwise_materialdropdown_model.dart';
import '../models/materialwise_showlist_model.dart';
import '../models/mrnlist_reports_model.dart';
import '../models/onitem_attendance_selct_model.dart';
import '../models/onitem_dpr_select_model.dart';
import '../models/onitem_inward_select_model.dart';
import '../models/onitem_mrn_select_model.dart';
import '../models/project_dropdownlist_model.dart';
import '../models/projectwise_details_list_model.dart';
import '../models/reqsatffreport.dart';
import '../models/sitedropdownresponse_model.dart';
import '../models/subcontract_dropdown_model.dart';
import '../models/supplierdropwon_model.dart';
import '../models/wklyreport_response.dart';
import '../splash/splash.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'package:http/http.dart' as http;


class ReportsProvider{

  final http.Client _httpClient = http.Client();

  ///------------****************-------Reports DropDown Lists ------------****************-------------------

  //-----------Get Project Reports--------------------

  static Future<List> getprojectReports(int userId,String userType, int reqSlip) async {
    List responseData = [];
    if (reqSlip == 0) {
      await ApiManager.getAPICall(
          ApiConstant.GETPROJECT_REPORTS + "?UserId=$userId&UserType=$userType")
          .then((value) {
        // responseData = projectDropdownListFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      }, onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong..');
      });
      return responseData;
    } else {
      await ApiManager.getAPICall(ApiConstant.GETPROJECT_REQUISITIONSLIP).then((value) {
        // responseData = projectDropdownListFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      }, onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong..');
      });
      return responseData;
    }
  }


  static Future<MaterialWiseMaterialDropdownResponse?> getReportMrnMaterial() async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETREPORTMATERIALDROPDOWNLIST);
      print("response...${response}");
      return materialWiseMaterialDropdownResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }


  //-----------Get Site Reports--------------------


  static Future<SiteDropdownResponse?> getsiteReports(int pId) async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETSITE_REPORTS+"?ID=$pId");
      print("response...${response}");
      return siteDropdownResponseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  //-----------Get Supplier Reports--------------------

  static Future<SupplierDropdownResponse?> getsupplierReports() async {
    try {
      final response = await ApiManager.getAPICall(
        "${ApiConstant.GETSUPPLIER_REPORTS}",
      );
      print("response...$response");
      return supplierDropdownResponseFromJson(response);

    } catch (error, stackTrace) {
      print("Error == $error");
      print("StackTrace == $stackTrace");
      return null;
    }
  }


  ///-----------Get Material Head Reports--------------------

  static Future<List> getMatReports(int userId,String userType) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPROJECT_REPORTS+"?UserId=$userId&UserType=$userType").then((value) {
      // responseData = projectDropdownListFromJson(value);
      if (responseData!=null&& responseData.length>0) {
        return responseData;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return responseData;
  }

  //-----------Get Subcontractor Reports--------------------

  static Future<SubcontractorDropdownList?> getsubcontactorReports() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTLISTRPT);
      print("response...${response}");
      return subcontractorDropdownListFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  /// ------------ **************** ------- Reports List View ------------ **************** -------------------

  static Future<List<WklyReportResponse>> getNMRreportList(int projectId,int subId,String frdate,String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETNMRREPORT+"?PrjId=$projectId&SubId=$subId&FrDate=$frdate&ToDate=$todate").then((value) {
      print("WklyReportList:"+value);
      data = wklyReportResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<AttendanceReportListResponse?> getAttendancereportList(int projectId,int siteId,int subId,String frdate,String todate,String workType) async {
    try {
      final response =
      await ApiManager.getAPICall("${ApiConstant.GETATTENDANCEREPORTLIST}?fromDate=$frdate&toDate=$todate&ProjectId=$projectId&SiteId=$siteId&SubContactId=$subId&WorkType=$workType");
      print("response...${response}");
      return attendanceReportListResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<OnItemSelectAttendanceList?> onItemSelctAttendanceList(int SelctId) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.ATTENDANCEONITEMSELCT+"?AttenId=$SelctId");
      print("response...${response}");
      return onItemSelectAttendanceListFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<OnItemSelectInwardList?> onItemSelctInwardList(int SelctId) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.INWARDONITEMSELCT+"?InwardId=$SelctId");
      print("response...${response}");
      return onItemSelectInwardListFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<OnItemSelectMrnList?> onItemSelctMrnList(int SelctId) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.MRNONITEMSELCT+"?ReqOrdId=$SelctId");
      print("response...${response}");
      return onItemSelectMrnListFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<List<OnItemSelectDprList>> onItemSelctDprList(int SelctId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.DPRONITEMSELCT+"?WorkId=$SelctId").then((value) {
      print("OnItemSelectDPRList:"+value);
      data = onItemSelectDprListFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<MrnListReportsResponse?> getMrn_Report_List(int projectId,int siteId,String frdate,String todate) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETMRNREPORTSLISTAPI + "?fromDate=$frdate&toDate=$todate&ProjectId=$projectId&SiteId=$siteId");
      print("response...${response}");
      return mrnListReportsResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }


  static Future<InwardReportListResponse?> getInward_Report_List(int projectId,int siteId,int subId,String frdate,String todate) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETINWARDREPORTSLISTAPI+"?PrjId=$projectId&SiteId=$siteId&SupId=$subId&FrDate=$frdate&ToDate=$todate");
      print("response...${response}");
      return inwardReportListResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<List<DprListResponse>> getDprReport_List(int projectId,int siteId,int subId,String frdate,String todate,String wType, String userType, int userId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETDPRLISTAPI+"?PrjId=$projectId&SiteId=$siteId&SubId=$subId&FrDate=$frdate&ToDate=$todate&WorkType=$wType&UserType=$userType&UserId=$userId").then((value) {
      print("AttendanceReportList:"+value);
      data = dprListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


  // static Future<List<StockReport>> getProject_Show_List(int userId,String userType,int projectId,int siteId,int mId,int mhId) async {
  //   List<StockReport> data = [];
  //   await ApiManager.getAPICall("${ApiConstant.GETMATERIAL_SHOW_LIST}?UserId=$userId&UserType=$userType&PId=$projectId&SId=$siteId&MHID=$mhId&MSId=$mId").then((value) {
  //     print("StockReportList:$value");
  //     // data = projectWiseShowListResponseFromJson(value);
  //     data = stockReportFromJson(value) as List<StockReport>;
  //     if (data.isNotEmpty && data.length>0) {
  //       return data;
  //     }else{
  //       Fluttertoast.showToast(msg: RequestConstant.NORECORD_FOUND);
  //     }
  //   }, onError: (error) {
  //     print(error);
  //     print("Error == $error");
  //     BaseUtitiles.showToast('Something went wrong..');
  //   });
  //   return data;
  // }


  Future<GetstockprojwiseModel> stockReportProvider(int userId,String userType,int projectId,int siteId,int mId,int mhId) async {
    try {
      Uri uri = Uri.parse("${ApiConstant.GETMATERIAL_SHOW_LIST}?UserId=$userId&UserType=$userType&PId=$projectId&SId=$siteId&MHID=$mhId&MSId=$mId");
      if (kDebugMode) {
        print(uri.toString());
      }
      String method = "GET";
      http.Request request = http.Request(method, uri);
      request.headers['Content-Type'] = 'application/json';
      http.StreamedResponse streamRes = await send(request);
      http.Response response = await http.Response.fromStream(streamRes);

      print("Response Data ::  ${response.body}");
      print("Response Data ::  ${uri}");
      await getResponse(response);
      if (response.statusCode == 200){
        return GetstockprojwiseModel.fromJson(jsonDecode(response.body.toString()));
      }
      else {
        throw Exception('Request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending request: $e');
      }
      rethrow;
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

  static Future<List<ProjectWiseDetailsListResponse>> getProject_Details_List(int projectId,int siteId,int mId,int mhId) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.GETMATERIAL_DETAILS_LIST}?PId=$projectId&SId=$siteId&MHID=$mhId&MSId=$mId").then((value) {
      print("AttendanceReportList:"+value);
      data = projectWiseDetailsListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List<MaterialWiseShowListResponse>> getMaterialWise_Show_List(int userId,String userType,int msId,int mId,int mhId) async {
    List<MaterialWiseShowListResponse> data = [];
    await ApiManager.getAPICall(ApiConstant.GETMATERIALWISE_SHOW_LIST+"?UserId=$userId&UserType=$userType&MHID=$mhId&MSId=$msId&MId=$mId").then((value) {
      print("Material ReportList:"+value);
      data = materialWiseShowListResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List<StaffLeaveReport>> reqSlipReportProvider(int StaffId,int cmpId,String frDate,String toDate,String levType,String userType) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.GET_REQLEAVETYPE_LIST}?staffId=$StaffId&CmpId=$cmpId&UserType=$userType&FrDate=$frDate&ToDate=$toDate&LeaveType=$levType").then((value) {
      print('StaffAttendanceReportList:$value');
      data = staffLeaveReportFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

}