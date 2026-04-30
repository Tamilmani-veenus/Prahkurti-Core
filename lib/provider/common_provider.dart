import 'dart:convert';
import 'package:prahkurticore/constants/ui_constant/textfont_style.dart';
import '../apimanager/apimanager.dart';
import '../models/accountname_model.dart';
import '../models/accounttype_model.dart';
import '../models/companydropdownlist_model.dart';
import '../models/companywiseprojectname_model.dart';
import '../models/invoiceno_billdir_model.dart';
import '../models/materiallist_model.dart';
import '../models/materialsubitem_dropdown_model.dart';
import '../models/materialwise_materialdropdown_model.dart';
import '../models/materialwise_subhead_dropdown_model.dart';
import '../models/nmr_billno_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/payfor_model.dart';
import '../models/paymode_model.dart';
import '../models/project_dropdownlist_model.dart';
import '../models/sitedropdownresponse_model.dart';
import '../models/staffname_responsemodel.dart';
import '../models/staffresponse_model.dart';
import '../models/subcont_entrylist_rights_model.dart';
import '../models/subcontract_dropdown_model.dart';
import '../models/supplierdropwon_model.dart';
import '../models/workorderno_dropdown_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class CommonProvider {
  static Future<ProjectDropdownListResponse?> getproject() async {
    try {
      final response =
          await ApiManager.getAPICall(ApiConstant.GETPROJECTDROPDOWNLIST);
      print("response...${response}");
      return projectDropdownListResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<ProjectDropdownListResponse?> getprojectAll() async {
    try {
      final response =
          await ApiManager.getAPICall(ApiConstant.GETPROJECTDROPDOWNLISTALL);
      print("response...${response}");
      return projectDropdownListResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<ProjectDropdownListResponse?> getReportproject(type) async {
    try {
      final response = await ApiManager.getAPICall(type == "attendance Rpt"
          ? ApiConstant.GETPROJECTDROPDOWNLIST
          : ApiConstant.GETREPORTPROJECTDROPDOWNLIST);
      print("response...${response}");
      return projectDropdownListResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

//-----Project Name Companywise list-----------
  static Future<List> getproject_Companywise(int compId) async {
    List responseData = [];
    await ApiManager.getAPICall(
            ApiConstant.GETPROJECTCOMPANYWISE_DROPDOWNLIST + "?compId=$compId")
        .then((value) {
      responseData = projectnameCompanywiseFromJson(value);
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

  static Future<List> getHeadName(int pId, int sId) async {
    List responseData = [];
    await ApiManager.getAPICall(
            ApiConstant.GET_HEAD_DROPDOWNLIST + "?PId=$pId&SId=$sId")
        .then((value) {
      responseData = headNameResFromJson(value);
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

  static Future<SubcontractorDropdownList?> getSubcontrator(
      int pid, int sid, checkScreen) async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GETSUBCONTRACTLIST + "?ProjectId=$pid");
      print("response...${response}");
      return subcontractorDropdownListFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<List> getWorkOrderNoList(int pId, int sId, int subId) async {
    List responseData = [];
    await ApiManager.getAPICall(
            ApiConstant.GETWRKORDERNOLIST + "?pid=$pId&sid=$sId&subid=$subId")
        .then((value) {
      responseData = workOrderNoResponseFromJson(value);
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

  static Future<List> getInvoiceNoList(int pId, int subId) async {
    List responseData = [];
    await ApiManager.getAPICall(
            ApiConstant.GETINVOICENOLIST + "?pid=$pId&subid=$subId")
        .then((value) {
      responseData = invoiceNoResponseFromJson(value);
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

  static Future<List> getNMRBillNoList(int pId, int subId) async {
    List responseData = [];
    await ApiManager.getAPICall(
            ApiConstant.GETNMRBILLNO + "?pid=$pId&subid=$subId")
        .then((value) {
      responseData = nmrBillNoResFromJson(value);
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

  static Future<List> getLabour() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETLABOURLIST).then((value) {
      responseData = getLabourDetailsFromJson(value);
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

  static Future<SiteDropdownResponse?> getSiteDropdown(
      int projectId, int? fromSiteId, String type,
      {int? toSiteId}) async {
    try {
      String response;

      if (type == "Fromsite") {
        response = await ApiManager.getAPICall(
          "${ApiConstant.SITEDROPDWONLISTAPI}?ProjectId=$projectId",
        );
      } else if (type == "StoreTransfer") {
        response = await ApiManager.getAPICall(
          "${ApiConstant.GETFROMSITELIST}?ProjectId=$projectId&ToSiteID=$toSiteId",
        );
      } else {
        response = await ApiManager.getAPICall(
          "${ApiConstant.TOSITEDROPDWONLISTAPI}?ProjectId=$projectId&fromSiteId=$fromSiteId",
        );
      }

      print("response...$response");
      return siteDropdownResponseFromJson(response);
    } catch (error, stackTrace) {
      print("Error == $error");
      print("StackTrace == $stackTrace");
      return null;
    }
  }

  static Future<List> getSupplierDropdown() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETSUPPLIERDROPDOWNAPI).then(
        (value) {
      // responseData = supplierDropdownResponseFromJson(value);
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

  static Future MaterialPost(String Material, String Scale, int Head_Id,
      int MaterialSubID, String Entry_Date) async {
    var data = null;
    await ApiManager.postCall(ApiConstant.POSTMATERIALSAVEAPI +
            "?Material=$Material&Scale=$Scale&Head_Id=$Head_Id&MaterialSubID=$MaterialSubID&Entry_Date=$Entry_Date")
        .then((value) {
      final res = saveDeduction_SaveResponseFromJson(value);
      if (res.RetString != null) {
        data = res.RetString;
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List> getCompany(int userId, int i) async {
    List responseData = [];

    if (i == 0) {
      await ApiManager.getAPICall(
              ApiConstant.GETCOMPANYDROPDOWNLIST + "?UserId=$userId")
          .then((value) {
        responseData = companyDropdownListResponseFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      }, onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong..');
      });
    } else {
      await ApiManager.getAPICall(ApiConstant.GETCOMPANYALL_DROPDOWNLIST).then(
          (value) {
        responseData = companyDropdownListResponseFromJson(value);
        if (responseData != null && responseData.length > 0) {
          return responseData;
        }
      }, onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong..');
      });
    }
    return responseData;
  }

  static Future<List> getmaterialsubDropdown(int mhId, reportScreen) async {
    List responseData = [];
    await ApiManager.getAPICall(reportScreen == 0
            ? ApiConstant.GETMATERIALSUBDRPDOWNLIST
            : ApiConstant.GETMATERIALSUBMAT_REPORTLIST + '?mhId=$mhId')
        .then((value) {
      // responseData = materialSubDropdownResponseFromJson(value);
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

  static Future<MaterialWiseHeadResponse?> materialWise_HeadDropdown() async {
    try {
      final response =
          await ApiManager.getAPICall("${ApiConstant.GETMATERIALHEAD_REPORT}");
      print("response...$response");
      return materialWiseHeadResponseFromJson(response);
    } catch (error, stackTrace) {
      print("Error == $error");
      print("StackTrace == $stackTrace");
      return null;
    }
  }

  static Future<MaterialWiseHeadSubResponse?> materialWise_sub_HeadDropdown(
      headId) async {
    try {
      final response = await ApiManager.getAPICall(
          "${ApiConstant.GETMATERIALSUBHEAD_REPORT}?HeadId=$headId");
      print("response...$response");
      return materialWiseHeadSubResponseFromJson(response);
    } catch (error, stackTrace) {
      print("Error == $error");
      print("StackTrace == $stackTrace");
      return null;
    }
  }

  static Future<MaterialWiseMaterialDropdownResponse?>
      materialWise_Based_HeadDropdown(MaterialId) async {
    try {
      final response = await ApiManager.getAPICall(
          "${ApiConstant.GETMATERIALBASEDSUBHEAD_REPORT}?MaterialSubId=$MaterialId");
      print("response...$response");
      return materialWiseMaterialDropdownResponseFromJson(response);
    } catch (error, stackTrace) {
      print("Error == $error");
      print("StackTrace == $stackTrace");
      return null;
    }
  }

  // static Future<List> materialWise_sub_HeadDropdown(int reportScreen) async {
  //   List responseData = [];
  //   await ApiManager.getAPICall(reportScreen == 0
  //           ? ApiConstant.GETMATERIAL_SUBHAED_DROPDOWNLIST
  //           : ApiConstant.GETMATERIALHEAD_REPORT)
  //       .then((value) {
  //     responseData = materialWiseSubHeadResponseFromJson(value);
  //     if (responseData != null && responseData.length > 0) {
  //       return responseData;
  //     }
  //   }, onError: (error) {
  //     print(error);
  //     print("Error == $error");
  //     BaseUtitiles.showToast('Something went wrong..');
  //   });
  //   return responseData;
  // }

  static Future<List> getMaterialDropdown(
      int subId, int mhId, int reportScreen) async {
    List responseData = [];
    await ApiManager.getAPICall(reportScreen == 0
            ? ApiConstant.GETMATERIALWISEDROPDOWNLIST
            : ApiConstant.GETMATERIALWISEREPORTLIST +
                "?MatSubId=$subId&mhId=$mhId")
        .then((value) {
      // responseData = materialWiseMaterialDropdownResponseFromJson(value);
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

  static Future<DailyEntrysubcontRightsEntrylistRes?>
      getSubControllerRightsEntryList(int MenuId) async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GETCONTROLL_RIGHTS_ENTRYLIST + "?MenuID=$MenuId");
      return dailyEntrysubcontRightsEntrylistResFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<ProjectDropdownListResponse?> getFromproject(type, id) async {
    try {
      String? response;
      if (type == "Against Mrn Approval") {
        response = await ApiManager.getAPICall(
            ApiConstant.GETFROMPROAGAINSTMRNLIST + "?id=$id");
      } else {
        response =
            await ApiManager.getAPICall(ApiConstant.GETPROJECTDROPDOWNLIST);
      }
      print("response...${response}");
      return projectDropdownListResponseFromJson(response!);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<dynamic> getAutoYearWise(Url) async {
    var response;
    try {
      if (Url == "MRN INDENT") {
        response = await ApiManager.getAPICall(
          "${ApiConstant.GETAUTONO_YEAR_WISE}?fieldName=ReqOrdNo&tableName=MaterialReqOrdMas&formName=MaterialReqOrdMas",
        );
      } else if (Url == "MRN PRE INDENT") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?fieldName=ReqOrdNo&tableName=MaterialReqOrdMas&formName=SiteRequest");
      } else if (Url == "CONSUMPTION") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?fieldName=ExpenseNo&tableName=MaterialExpenseMas&formName=MaterialExpenses");
      } else if (Url == "TRANSFER BETWEEN PROJECTS") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?projectId=0&fieldName=TransferNo&tableName=MaterialTransferMas&formName=MaterialTransfer");
      } else if (Url == "TRANSFER BETWEEN SITES") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?fieldName=TransferNo&tableName=MaterialSitetoSitetransferMas&formName=MaterialSitetosite");
      } else if (Url == "MATERIAL TRANSFER REQUEST") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?projectId=0&fieldName=TransferNo&tableName=MaterialTransferRequestMas&formName=MaterialTransferRequest");
      } else if (Url == "INWARD") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?projectId=0&fieldName=InwardNo%20&tableName=MaterialInwardMas%20&formName=MaterialInward");
      } else if (Url == "BOQ REVISED") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=Revise_No&TableName=BOQ_Revise_Mas&FormName=BOQ");
      } else if (Url == "SUBCONTRACTOR ATTENDANCE") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?projectId=0&fieldName=LabourAttendanceNo&tableName=SubContLabourAttendMas&formName=SubContLabourAttendMas");
      } else if (Url == "DPR") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=Work_No&TableName=SubCont_dailyWork_Mas&FormName=dpr");
      } else if (Url == "DPR NEW") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=Work_No&TableName=SubCont_dailyWork_Mas&FormName=DPR_New");
      } else if (Url == "DPR LABOUR") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}FieldName=Work_No&TableName=SubCont_dailyWork_Mas&FormName=DPR_New2");
      } else if (Url == "COMPANY NMR") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=NMRLbrAttn_No&TableName=NMRLbr_attend_Mas&FormName=NMR_Labr_Attn");
      } else if (Url == "DIRECT BILL") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=Work_No&TableName=SubCont_WorkQty_Mas&FormName=SubContBillDirect");
      } else if (Url == "NMR WEEKLY BILL") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=Work_No&TableName=SubCont_NMR_Bill_Mas&FormName=SubCont_NMR_Bill");
      } else if (Url == "ADVANCE REQ VOUCHER") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=voc_no&TableName=Ac_advance_req_voucher&FormName=AdvanceRequisitionvoucher");
      } else if (Url == "SITE VOUCHER") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?projectId=0&fieldName=SiteVoucherNo&tableName=AccountSiteVoucher&formName=AccountSiteVoucher");
      } else if (Url == "STAFF VOUCHER") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=StaffVocNo&TableName=AccountStaffVoucher&FormName=StaffVoucher");
      } else if (Url == "TRANSFER ACK PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?projectId=0&fieldName=AcknowledgeNo&tableName=MaterialTransferAckmas&formName=MaterialAckMas");
      } else if (Url == "REQ SLIP") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=Requestion_No&TableName=Staff_Requestion_Slip&FormName=StaffLeavePermission");
      }
      final data = json.decode(response);
      return data;
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<AccountTypeReponse?> getAccountType() async {
    try {
      final value = await ApiManager.getAPICall(ApiConstant.GETACCOUNTTYPEDROPDOWNLIST);
      return accountTypeReponseFromJson(value);
    } catch (e) {
      print("Error == $e");
      return null;
    }
  }

  static Future<List> getPaymodetype() async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GETPAYMODEDROPDOWNLIST).then(
        (value) {
      responseData = payModereponseFromJson(value);
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

  static Future<PayforReponse?> getPayforType() async {
    try {
      final value = await ApiManager.getAPICall(ApiConstant.GETPAYFORDROPDOWNLIST);
      return payforReponseFromJson(value);
    } catch (e) {
      print("Error == $e");
      return null;
    }
  }

  static Savetoken(token) async {
    try {
      final result =
          await ApiManager.postCall(ApiConstant.TOKEN_SAVE + "?Token=$token");
      return jsonDecode(result);
    } catch (e) {
      print("token error...${e}");
    }
  }

  static Future Usertoken_deleteAPI() async {
    try {
      final response =
          await ApiManager.postCall(ApiConstant.USERTOKENDELETE_API);
      return json.decode(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<AccountNameReponse?> getAccountnameDropdown(int AccTypeId) async {
    try {
      final value = await ApiManager.getAPICall(ApiConstant.ACCOUNTNAMEDROPDWONLISTAPI + "?typeId=$AccTypeId");
      return accountNameReponseFromJson(value);
    } catch (e) {
      print("Error == $e");
      return null;
    }
  }

  static Future<StaffNameResponse?> getStaffDropdown() async {
    try {
      final response =
          await ApiManager.getAPICall(ApiConstant.STAFFDROPDWONLISTAPI);
      print("response...${response}");
      return staffNameResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<MateriallistResponse?> getmaterial(
      bool requestType, projectId, siteId) async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETMATERIALLIST +
          "?asset=$requestType&projectId=$projectId&siteId=$siteId&SubId=0");
      print("response...${response}");
      return materiallistResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static SaveAccountnameScreenEntryAPI(String body, int Accnameid) async {
    var ratingRes = null;
    if (Accnameid != 0) {
      await ApiManager.putUpdateAPIButton(
              ApiConstant.PUT_ACCOUNTNAME_UPDATE_API, body)
          .then((value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    } else {
      await ApiManager.postAPICall(ApiConstant.ACCOUNTNAME_SAVE, body).then(
          (value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    return ratingRes;
  }

  //---Delete API----
  static Future Accountname_deleteAPI(int AccTypeId, int AccNameId) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_ACCOUNTNAME_API +
            "?AccTypeId=$AccTypeId&AccNameId=$AccNameId")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG + error);
    });
    return data;
  }
}
