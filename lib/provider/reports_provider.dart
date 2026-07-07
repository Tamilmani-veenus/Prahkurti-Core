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
import '../models/mrnreq_tracker_reportmodel.dart';
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

  static Future<MaterialWiseMaterialDropdownResponse?> getReportMrnMaterial(type) async {
    try {
      final response =
      await ApiManager.getAPICall(type=="mrnReqTracker"?ApiConstant.GETALLMATERIALDROPDOWNLIST:ApiConstant.GETREPORTMATERIALDROPDOWNLIST);
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

  static Future getCompanyReports() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETCOMPANYLISTRPT);
      print("response...${response}");
      return jsonDecode(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
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

  static Future<OnItemSelectDprList?> onItemSelctDprList(int SelctId) async {
    try {
      final response = await ApiManager.getAPICall("${ApiConstant.DPRONITEMSELCT}?workId=$SelctId");
      print("OnItemSelectDPRList...${response}");
      return onItemSelectDprListFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERRORR...${e}");
      return null;
    }
  }


  static Future<MrnListReportsResponse?> getMrn_Report_List(int projectId,int siteId,String frdate,String todate,int matId) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETMRNREPORTSLISTAPI + "?fromDate=$frdate&toDate=$todate&ProjectId=$projectId&SiteId=$siteId&MaterialId=$matId");
      print("response...${response}");
      return mrnListReportsResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  static Future<MrnReqTrackerListModel?> getMrnReqTrackerRptList(int projectId,int siteId,int materialId,String frdate,String todate) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETREQTRACKERLISTAPI + "?projectId=$projectId&siteId=$siteId&materialId=$materialId&fromDate=$frdate&toDate=$todate");
      print("response...${response}");
      return mrnReqTrackerListModelFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }


  static Future<InwardReportListResponse?> getInward_Report_List(int projectId,int siteId,int subId,String frdate,String todate,int matId) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETINWARDREPORTSLISTAPI+"?ProjectId=$projectId&SiteId=$siteId&SupplierId=$subId&fromDate=$frdate&toDate=$todate&MaterialId=$matId");
      print("response...${response}");
      return inwardReportListResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }


  static Future getDprReport_List(int projectId,int siteId,int subId,String frdate,String todate,String wType) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETDPRLISTAPI+"?projectId=$projectId&siteId=$siteId&SubcontractorId=$subId&workType=$wType&fromDate=$frdate&toDate=$todate");
      print("response...${response}");
      return dprListResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }

  Future<GetStockRptListDetails?> stockReportProvider(int projectId,int siteId,int mHId,int mSId,int mId,type) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETMATERIAL_SHOW_LIST+"?ProjectId=$projectId&SiteId=$siteId&MatHeadId=$mHId&MatSubId=$mSId&MatId=$mId&Type=$type");
      print("response...${response}");
      return getStockRptListDetailsFromJson(response);
    } catch (error,e) {
      print("Error == $error");
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

  static Future<ProjectWiseDetailsListResponse?> getProject_Details_List(int projectId,int siteId,int mId,int mhId) async {
    try {
      final response =
      await ApiManager.getAPICall("${ApiConstant.GETMATERIAL_DETAILS_LIST}?projectId=$projectId&SiteId=$siteId&MaterialHeadItemId=$mhId&materialSubitemId=$mId");
      print("response...${response}");
      return projectWiseDetailsListResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR....${e}");
      return null;
    }
  }


}