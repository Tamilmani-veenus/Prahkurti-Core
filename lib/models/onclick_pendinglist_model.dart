

import 'dart:convert';

OnclickPendingListResponse onclickPendingListResponseFromJson(String str) => OnclickPendingListResponse.fromJson(json.decode(str));

String onclickPendingListResponseToJson(OnclickPendingListResponse data) => json.encode(data.toJson());

class OnclickPendingListResponse {
  bool? success;
  List<OnClickListResult>? result;
  String? message;

  OnclickPendingListResponse({
    this.success,
    this.result,
    this.message,
  });

  factory OnclickPendingListResponse.fromJson(Map<String, dynamic> json) {
    return OnclickPendingListResponse(
      success: json["success"],
      result: json["result"] is List
          ? List<OnClickListResult>.from(
          json["result"].map((x) => OnClickListResult.fromJson(x)))
          : [],
      message: json["message"]// 👈 if string like "No Records Found"
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message" :message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class OnClickListResult {
  int? id;
  int? ReqOrdMasId;
  int? PONo;
  int? PoId;
  String? requisitionNo;
  String? requisitionTypeValue;
  String? reqOrdNo;
  String? ReqOrdNo;
  String? reviseNo;
  String? reviseDate;
  String? labourAttendanceNo;
  String? labourAttendanceDate;
  String? reqOrdDate;
  String? ReqOrdDate;
  String? reqdueDate;
  String? ReqDueDate;
  String? requestType;
  int? projectId;
  int? siteId;
  String? fromProjectName;
  String? FromProjectName;
  String? siteName;
  String? SiteName;
  String? createdName;
  String? CreatedName;
  String? verifyName;
  String? approveName;
  String? approvedName;
  String? preApprovedName;
  String? projectName;
  String? ProjectName;
  int? approvedname;
  int? appId;
  dynamic? no;
  String? date;
  String? dueDate;
  String? deliveryDate;
  String? accName;
  String? accType;
  String? supplierName;
  String? suppliername;
  String? supplier;
  String? prepareby;
  String? preparedBy;
  String? preparedby;
  String? preparedByName;
  String? Preparedbyname;
  String? preparebyname;
  String? preparedByBOQ;
  String? preparedName;
  int? preparedByid;
  double? netAmt;
  double? netAmount;
  String? frProjectName;
  int? toProjectId;
  String? toProjectName;
  String? ToProjectName;
  String? type;
  String? potype;
  int? DprType;
  String? appNo;
  String? subContractorName;
  String? subContractor;
  String? SubcontName;
  double? totNos;
  double? totAmt;
  String? Payfor;
  int? ProjectId;
  int? ProjectID;
  int? Projectid;
  int? projId;
  int? SiteId;
  int? SiteID;
  String? VerifiedBy;
  String? PreapprovedBy;
  String? req_remarks;
  String? app_remarks;
  String? appRemarks;
  int? delaydays;
  String? fromDate;
  String? frDate;
  String? toDate;
  String? tDate;
  String? billno;
  String? billNo;
  String? purchaseType;
  String? PurchaseType;
  String? approvedby;
  String? workshift;
  String? workordertype;
  String? worktype;
  String? shift;
  String? dcno;
  String? dcNo;
  String? staffName;
  String? StaffName;
  int? staffId;
  String? vehicleno;
  String? vehicleName;
  String? entryType;
  double? reqAmt;
  String? leaveReason;
  String? LeaveReason;
  double? totalLeave;
  String? permissionReason;
  String? permissionFromDate;
  String? permissionToDate;
  String? permissionFromTime;
  String? PermissionFromTime;
  String? permissionToTime;
  int? permissionTimeMins;
  int? permissionTimeHrs;
  String? Time;
  String? Address;
  String? Remarks;
  String? requisitionType;
  String? Designation;
  double? totalPermissionHours;
  String? employeeName;
  String? empName;
  String? purchaseOrdNo;
  String? PurchaseOrdNo;
  String? purchaseOrdDate;
  String? PurchaseOrdDate;
  String? inwType;
  String? approveByName;
  String? createdByName;
  String? createdByNamebill;
  String? approvedbyname;
  String? fromSiteName;
  String? transferEntryDate;
  String? transEntryDate;
  String? entryDate;
  String? entryDateMobile;
  String? transferNo;
  String? TransferNo;
  String? leaveFromDate;
  double? totalLeaveDays;
  String? leaveToDate;
  int? reqMasId;
  String? subcontractName;
  String? SubcontractName;
  String? entryName;
  String? verifiedBy;
  int? materialReqOrdMasId;
  String? reqDueDate;
  int? qCount;
  dynamic createdBy;
  int? employeeId;
  String? quoteRemarks;
  String? workNo;
  String? workDate;
  int? workId;
  double? netPayAmount;
  String? entryNo;
  String? billStatus;
  String? billType;
  String? siteVoucherNo;
  String? vocdate;
  String? accountName;
  String? payMode;
  String? accountTypeName;
  double? siteVoucherAmount;
  String? payfor;
  double? advanceReqVoucherAmount;
  String? advanceReqVoucherType;

  OnClickListResult({
    this.id,
    this.ReqOrdMasId,
    this.PONo,
    this.PoId,
    this.requisitionNo,
    this.requisitionTypeValue,
    this.reqOrdNo,
    this.ReqOrdNo,
    this.reviseNo,
    this.reviseDate,
    this.labourAttendanceNo,
    this.labourAttendanceDate,
    this.reqOrdDate,
    this.ReqOrdDate,
    this.reqdueDate,
    this.ReqDueDate,
    this.requestType,
    this.projectId,
    this.Projectid,
    this.siteId,
    this.fromProjectName,
    this.FromProjectName,
    this.siteName,
    this.SiteName,
    this.createdName,
    this.CreatedName,
    this.verifyName,
    this.approveName,
    this.approvedName,
    this.preApprovedName,
    this.projectName,
    this.ProjectName,
    this.approvedname,
    this.appId,
    this.no,
    this.date,
    this.dueDate,
    this.deliveryDate,
    this.accName,
    this.accType,
    this.supplierName,
    this.suppliername,
    this.supplier,
    this.prepareby,
    this.preparedBy,
    this.preparedby,
    this.preparedByid,
    this.preparedByName,
    this.Preparedbyname,
    this.preparebyname,
    this.preparedByBOQ,
    this.preparedName,
    this.netAmt,
    this.netAmount,
    this.frProjectName,
    this.toProjectId,
    this.toProjectName,
    this.ToProjectName,
    this.type,
    this.potype,
    this.DprType,
    this.requisitionType,
    this.appNo,
    this.subContractorName,
    this.subContractor,
    this.SubcontName,
    this.totNos,
    this.totAmt,
    this.Payfor,
    this.ProjectId,
    this.ProjectID,
    this.projId,
    this.SiteId,
    this.SiteID,
    this.VerifiedBy,
    this.PreapprovedBy,
    this.req_remarks,
    this.app_remarks,
    this.appRemarks,
    this.delaydays,
    this.fromDate,
    this.frDate,
    this.toDate,
    this.tDate,
    this.billno,
    this.billNo,
    this.purchaseType,
    this.PurchaseType,
    this.approvedby,
    this.workshift,
    this.workordertype,
    this.worktype,
    this.shift,
    this.dcno,
    this.dcNo,
    this.vehicleno,
    this.vehicleName,
    this.staffName,
    this.StaffName,
    this.staffId,
    this.reqAmt,
    this.leaveReason,
    this.LeaveReason,
    this.totalLeave,
    this.permissionReason,
    this.permissionFromDate,
    this.permissionToDate,
    this.leaveFromDate,
    this.totalLeaveDays,
    this.leaveToDate,
    this.permissionFromTime,
    this.PermissionFromTime,
    this.permissionToTime,
    this.permissionTimeHrs,
    this.permissionTimeMins,
    this.Time,
    this.Address,
    this.Remarks,
    this.Designation,
    this.totalPermissionHours,
    this.employeeName,
    this.empName,
    this.purchaseOrdNo,
    this.PurchaseOrdNo,
    this.purchaseOrdDate,
    this.PurchaseOrdDate,
    this.inwType,
    this.approveByName,
    this.createdByName,
    this.createdByNamebill,
    this.approvedbyname,
    this.fromSiteName,
    this.transferEntryDate,
    this.transEntryDate,
    this.transferNo,
    this.TransferNo,
    this.reqMasId,
    this.entryType,
    this.entryDate,
    this.entryDateMobile,
    this.subcontractName,
    this.SubcontractName,
    this.entryName,
    this.verifiedBy,
    this.materialReqOrdMasId,
    this.reqDueDate,
    this.qCount,
    this.createdBy,
    this.employeeId,
    this.quoteRemarks,
    this.workNo,
    this.workDate,
    this.workId,
    this.netPayAmount,
    this.entryNo,
    this.billType,
    this.billStatus,
    this.siteVoucherNo,
    this.vocdate,
    this.accountName,
    this.payMode,
    this.accountTypeName,
    this.siteVoucherAmount,
    this.payfor,
    this.advanceReqVoucherAmount,
    this.advanceReqVoucherType,
  });

  factory OnClickListResult.fromJson(Map<String, dynamic> json) => OnClickListResult(
    id: json["id"],
    ReqOrdMasId: json["ReqOrdMasId"],
    PONo: json["PONO"],
    PoId: json["PoId"],
    reqOrdNo: json["reqOrdNo"],
    requisitionNo: json["requisitionNo"],
    requisitionTypeValue: json["requisitionTypeValue"],
    ReqOrdNo: json["ReqOrdNo"],
      reviseNo: json["reviseNo"],
      reviseDate: json["reviseDate"],
    labourAttendanceNo: json["LabourAttendanceNo"],
    labourAttendanceDate: json["LabourAttendanceDate"],
    reqOrdDate: json["reqOrdDate"],
    ReqOrdDate: json["ReqOrdDate"],
    reqdueDate: json["reqdueDate"],
    ReqDueDate: json["ReqdueDate"],
    requestType: json["requestType"],
    projectId: json["projectID"],
    ProjectID:json["ProjectID"],
    Projectid:json["Projectid"],
    siteId: json["siteID"],
    fromProjectName: json["fromProjectName"],
    FromProjectName: json["FromProjectName"],
    siteName: json["siteName"],
    SiteName: json["SiteName"],
    createdName: json["createdName"],
    CreatedName: json["CreatedName"],
    verifyName: json["verifyName"],
    approveName: json["ApproveName"],
    approvedName: json["approvedName"],
    preApprovedName: json["preApprovedName"],
    projectName: json["projectName"],
    ProjectName: json["ProjectName"],
    approvedname: json["ApprovedBy"],
    appId: json["AppId"],
    no: json["No"],
    date: json["PODate"],
    dueDate: json["DueDate"],
    deliveryDate: json["deliveryDate"],
    accName: json["Acc_name"],
    accType: json["Acc_type"],
    supplierName: json["SupplierName"],
    suppliername: json["supplierName"],
    supplier: json["supplier"],
    preparedBy: json["PreparedBy"],
    preparedby: json["Preparedby"],
    preparedByid: json["PreparedById"],
    Preparedbyname: json["Preparedbyname"],
    preparedName: json["preparedByName"],
    prepareby: json["preparedby"],
    appRemarks: json["appRemarks"],
    preparedByName: json["Prepared_by"],
      preparebyname: json["PreparedByName"],
      preparedByBOQ: json["preparedBy"],
    netAmt: json["NetAmt"],
    netAmount: json["NetAmount"],
    frProjectName: json["FrProjectName"],
    toProjectId: json["ToProjectId"],
    toProjectName: json["ToProjectName"],
    ToProjectName: json["toProjectName"],
    type: json["Type"],
    DprType: json["DPRType"],
    appNo: json["AppNo"],
    subContractorName: json["SubContractorName"],
    SubcontName: json["subcontractorName"],
    subContractor: json["subContractorName"],
    totNos: json["TotNos"],
    totAmt: json["TotNos"],
    Payfor: json["Payfor"],
    ProjectId: json["ProjectId"],
    projId: json["projectId"],
    SiteId: json["SiteId"],
    SiteID: json["SiteID"],
    VerifiedBy: json["VerifiedBy"],
    PreapprovedBy: json["PreapprovedBy"],
    potype: json["PoType"],
    req_remarks: json["RequestRemarks"],
    app_remarks: json["AppRemarks"],
    delaydays: json["DelayDays"],
    fromDate: json["FromDate"],
    frDate: json["fromDate"],
    toDate: json["ToDate"],
    tDate: json["toDate"],
    billno: json["Billno"],
    billNo: json["billNo"],
    purchaseType: json["PurchaseType"],
    PurchaseType: json["purchaseType"],
    requisitionType: json["requisitionType"],
    approvedby: json["approvedby"],
    workshift: json["workshift"],
    workordertype: json["WorkOrderType"],
    worktype: json["worktype"],
    shift: json["shift"],
    dcno: json["dcno"],
    dcNo: json["dcNo"],
    vehicleno: json["vehicleno"],
    vehicleName: json["vehicleName"],
    entryType: json["entryType"],
    staffName: json["StaffName"],
    StaffName: json["staffName"],
    staffId: json["staffId"],
    reqAmt: json["ReqAmt"],
    leaveReason: json["LeaveReason"],
    LeaveReason: json["leaveReason"],
    totalLeave: json["TotalLeave"],
    leaveFromDate: json["leaveFromDate"],
    totalLeaveDays: json["totalLeaveDays"],
    leaveToDate: json["leaveToDate"],
    permissionReason: json["permissionReason"],
    permissionFromDate: json["permissionFromDate"],
    permissionToDate: json["permissionToDate"],
    permissionFromTime: json["permissionFromTime"],
    PermissionFromTime: json["PermissionFromTime"],
    permissionToTime: json["permissionToTime"],
    permissionTimeHrs: json["permissionTimeHrs"],
    permissionTimeMins: json["permissionTimeMins"],
    Time: json["Time"],
    Address: json["Address"],
    Remarks: json["Remarks"],
    Designation: json["Designation"],
    totalPermissionHours: json["totalPermissionHours"],
    employeeName: json["EmployeeName"],
    empName: json["employeeName"],
    PurchaseOrdDate: json["PurchaseOrdDate"],
    purchaseOrdNo: json["PurchaseOrdNo"],
    inwType: json["inw_type"],
    entryDate: json["entryDate"],
    entryDateMobile: json["entryDateMobile"],
    approveByName: json["ApproveByName"],
    approvedbyname:json["approvedbyname"],
    createdByName: json["CreatedByName"],
    createdByNamebill: json["createdByName"],
    PurchaseOrdNo: json["purchaseOrdNo"],
    purchaseOrdDate: json["purchaseOrdDate"],
    fromSiteName: json["FromSiteName"],
    transferEntryDate: json["TransferEntryDate"],
    transEntryDate: json["transferEntryDate"],
    TransferNo: json["transferNo"],
    transferNo: json["TransferNo"],
    reqMasId: json["ReqMasId"],
    subcontractName: json["SubcontractName"],
    SubcontractName: json["subcontractName"],
    entryName: json["entryName"],
    verifiedBy: json["verifedName"],
      materialReqOrdMasId: json["materialReqOrdMasId"],
      reqDueDate: json["reqDueDate"],
      qCount: json["qCount"],
      createdBy: json["createdBy"],
      employeeId: json["employeeId"],
      quoteRemarks: json["quoteRemarks"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    workId: json["workId"],
    netPayAmount: json["netPayAmount"],
    entryNo: json["entryNo"],
    billStatus: json["billStatus"],
    billType: json["billType"],
    siteVoucherNo: json["siteVoucherNo"],
    vocdate: json["vocdate"],
    accountName: json["accountName"],
    payMode: json["payMode"],
    accountTypeName: json["accountTypeName"],
    siteVoucherAmount: json["SiteVoucherAmount"],
    payfor: json["payfor"],
    advanceReqVoucherAmount: json["advanceReqVoucherAmount"],
    advanceReqVoucherType: json["advanceReqVoucherType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ReqOrdMasId": ReqOrdMasId,
    "PONO": PONo,
    "PoId": PoId,
    "requisitionNo": requisitionNo,
    "requisitionTypeValue": requisitionTypeValue,
    "reqOrdNo": reqOrdNo,
    "ReqOrdNo": ReqOrdNo,
    "reviseNo": reviseNo,
    "reviseDate": reviseDate,
    "LabourAttendanceNo": labourAttendanceNo,
    "LabourAttendanceDate": labourAttendanceDate,
    "reqOrdDate": reqOrdDate,
    "ReqOrdDate": ReqOrdDate,
    "reqdueDate": reqdueDate,
    "ReqdueDate": ReqDueDate,
    "requestType": requestType,
    "projectID": projectId,
    "appRemarks": appRemarks,
    "ProjectID": ProjectID,
    "Projectid": Projectid,
    "projectId": projId,
    "siteID": siteId,
    "SiteID": SiteID,
    "fromProjectName": fromProjectName,
    "FromProjectName": FromProjectName,
    "siteName": siteName,
    "createdName": createdName,
    "CreatedName": CreatedName,
    "verifyName": verifyName,
    "ApproveName": approveName,
    "approvedName": approvedName,
    "preApprovedName": preApprovedName,
    "projectName": projectName,
    "ProjectName": ProjectName,
    "ApprovedBy": approvedName,
    "purchaseType":PurchaseType,
    "Id": id,
    "AppId": appId,
    "No": no,
    "PODate": date,
    "DueDate": dueDate,
    "deliveryDate": deliveryDate,
    "ProjectName": projectName,
    "SiteName": SiteName,
    "Acc_name": accName,
    "Acc_type": accType,
    "SupplierName": supplierName,
    "supplierName": suppliername,
    "supplier": supplier,
    "PreparedBy": preparedBy,
    "Preparedby": preparedby,
    "PreparedById": preparedByid,
    "Prepared_by": preparedByName,
    "Preparedbyname": Preparedbyname,
    "preparedByName": preparedName,
    "PreparedByName": preparebyname,
    "preparedby": prepareby,
    "preparedBy": preparedByBOQ,
    "NetAmt": netAmt,
    "NetAmount":netAmount,
    "FrProjectName": frProjectName,
    "ToProjectId": toProjectId,
    "ToProjectName": toProjectName,
    "toProjectName": ToProjectName,
    "Type": type,
    "DPRType": DprType,
    "AppNo": appNo,
    "SubContractorName": subContractorName,
    "subcontractorName": SubcontName,
    "subContractorName": subContractor,
    "TotNos": totNos,
    "TotNos": totAmt,
    "Payfor": Payfor,
    "ProjectId": ProjectId,
    "SiteId": SiteId,
    "VerifiedBy": VerifiedBy,
    "PoType": potype,
    "RequestRemarks": req_remarks,
    "AppRemarks": app_remarks,
    "DelayDays": delaydays,
    "FromDate": fromDate,
    "fromDate": frDate,
    "ToDate": toDate,
    "toDate": tDate,
    "Billno": billno,
    "billNo": billNo,
    "approvedby": approvedby,
    "workshift": workshift,
    "WorkOrderType": workordertype,
    "worktype": worktype,
    "shift": shift,
    "dcno": dcno,
    "dcNo": dcNo,
    "vehicleno": vehicleno,
    "vehicleName": vehicleName,
    "entryType": entryType,
    "requisitionType": requisitionType,
    "StaffName":staffName,
    "staffName":StaffName,
    "staffId":staffId,
    "ReqAmt": reqAmt,
    "LeaveReason": leaveReason,
    "leaveReason": LeaveReason,
    "leaveFromDate": leaveFromDate,
    "totalLeaveDays": totalLeaveDays,
    "leaveToDate": leaveToDate,
    "TotalLeave": totalLeave,
    "permissionReason": permissionReason,
    "permissionFromDate": permissionFromDate,
    "permissionToDate": permissionToDate,
    "permissionFromTime": permissionFromTime,
    "PermissionFromTime": PermissionFromTime,
    "permissionToTime": permissionToTime,
    "permissionTimeHrs": permissionTimeHrs,
    "permissionTimeMins": permissionTimeMins,
    "Address": Address,
    "Remarks":   Remarks,
    "Time":Time,
    "Designation":   Designation,
    "totalPermissionHours": totalPermissionHours,
    "EmployeeName":employeeName,
    "employeeName":empName,
    "PurchaseOrdNo": purchaseOrdNo,
    "purchaseOrdNo": PurchaseOrdNo,
    "purchaseOrdDate": purchaseOrdDate,
    "PurchaseOrdDate": PurchaseOrdDate,
    "inw_type": inwType,
    "ApproveByName": approveByName,
    "CreatedByName": createdByName,
    "createdByName": createdByNamebill,
    "approvedbyname":approvedbyname,
    "FromSiteName": fromSiteName,
    "TransferEntryDate": transferEntryDate,
    "transferEntryDate": transEntryDate,
    "transferNo": TransferNo,
    "TransferNo": transferNo,
    "ReqMasId": reqMasId,
    "entryDate": entryDate,
    "entryDateMobile": entryDateMobile,
    "SubcontractName": subcontractName,
    "subcontractName": SubcontractName,
    "entryName": entryName,
    "verifedName": verifiedBy,
    "materialReqOrdMasId": materialReqOrdMasId,
    "reqDueDate": reqDueDate,
    "qCount": qCount,
    "createdBy": createdBy,
    "employeeId": employeeId,
    "quoteRemarks": quoteRemarks,
    "workNo": workNo,
    "workDate":workDate,
    "workId":workId,
    "netPayAmount":netPayAmount,
    "entryNo": entryNo,
    "billStatus": billStatus,
    "billType": billType,
    "siteVoucherNo": siteVoucherNo,
    "vocdate": vocdate,
    "accountName": accountName,
    "payMode": payMode,
    "accountTypeName": accountTypeName,
    "SiteVoucherAmount": siteVoucherAmount,
    "payfor": payfor,
    "advanceReqVoucherType": advanceReqVoucherType,
    "advanceReqVoucherAmount": advanceReqVoucherAmount,

  };
}
