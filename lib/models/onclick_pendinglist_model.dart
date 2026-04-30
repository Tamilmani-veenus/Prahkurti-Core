

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
  String? reqOrdNo;
  String? ReqOrdNo;
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
  double? totNos;
  double? totAmt;
  String? Payfor;
  int? ProjectId;
  int? ProjectID;
  int? SiteId;
  int? SiteID;
  String? VerifiedBy;
  String? PreapprovedBy;
  String? req_remarks;
  String? app_remarks;
  String? appRemarks;
  int? delaydays;
  String? fromDate;
  String? toDate;
  String? billno;
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
  String? vehicleno;
  String? vehicleName;
  String? entryType;
  double? reqAmt;
  String? leaveReason;
  String? lFrdate;
  String? lTodate;
  double? totalLeave;
  String? perReason;
  String? pFrdate;
  String? pTodate;
  String? pFrTime;
  String? pToTime;
  String? Time;
  String? Address;
  String? Remarks;
  String? Designation;
  double? totalPerHrs;
  String? employeeName;
  String? purchaseOrdNo;
  String? PurchaseOrdNo;
  String? purchaseOrdDate;
  String? PurchaseOrdDate;
  String? inwType;
  String? approveByName;
  String? createdByName;
  String? approvedbyname;
  String? fromSiteName;
  String? transferEntryDate;
  String? transEntryDate;
  String? entryDate;
  String? transferNo;
  String? TransferNo;
  int? reqMasId;
  String? subcontractName;
  String? entryName;
  String? verifiedBy;
  int? materialReqOrdMasId;
  String? reqDueDate;
  int? qCount;
  dynamic createdBy;
  int? employeeId;
  String? quoteRemarks;

  OnClickListResult({
    this.id,
    this.ReqOrdMasId,
    this.PONo,
    this.PoId,
    this.reqOrdNo,
    this.ReqOrdNo,
    this.labourAttendanceNo,
    this.labourAttendanceDate,
    this.reqOrdDate,
    this.ReqOrdDate,
    this.reqdueDate,
    this.ReqDueDate,
    this.requestType,
    this.projectId,
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
    this.netAmt,
    this.netAmount,
    this.frProjectName,
    this.toProjectId,
    this.toProjectName,
    this.ToProjectName,
    this.type,
    this.potype,
    this.DprType,
    this.appNo,
    this.subContractorName,
    this.totNos,
    this.totAmt,
    this.Payfor,
    this.ProjectId,
    this.ProjectID,
    this.SiteId,
    this.SiteID,
    this.VerifiedBy,
    this.PreapprovedBy,
    this.req_remarks,
    this.app_remarks,
    this.appRemarks,
    this.delaydays,
    this.fromDate,
    this.toDate,
    this.billno,
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
    this.reqAmt,
    this.leaveReason,
    this.lFrdate,
    this.lTodate,
    this.totalLeave,
    this.perReason,
    this.pFrdate,
    this.pTodate,
    this.pFrTime,
    this.pToTime,
    this.Time,
    this.Address,
    this.Remarks,
    this.Designation,
    this.totalPerHrs,
    this.employeeName,
    this.purchaseOrdNo,
    this.PurchaseOrdNo,
    this.purchaseOrdDate,
    this.PurchaseOrdDate,
    this.inwType,
    this.approveByName,
    this.createdByName,
    this.approvedbyname,
    this.fromSiteName,
    this.transferEntryDate,
    this.transEntryDate,
    this.transferNo,
    this.TransferNo,
    this.reqMasId,
    this.entryType,
    this.entryDate,
    this.subcontractName,
    this.entryName,
    this.verifiedBy,
    this.materialReqOrdMasId,
    this.reqDueDate,
    this.qCount,
    this.createdBy,
    this.employeeId,
    this.quoteRemarks,
  });

  factory OnClickListResult.fromJson(Map<String, dynamic> json) => OnClickListResult(
    id: json["id"],
    ReqOrdMasId: json["ReqOrdMasId"],
    PONo: json["PONO"],
    PoId: json["PoId"],
    reqOrdNo: json["reqOrdNo"],
    ReqOrdNo: json["ReqOrdNo"],
    labourAttendanceNo: json["LabourAttendanceNo"],
    labourAttendanceDate: json["LabourAttendanceDate"],
    reqOrdDate: json["reqOrdDate"],
    ReqOrdDate: json["ReqOrdDate"],
    reqdueDate: json["reqdueDate"],
    ReqDueDate: json["ReqdueDate"],
    requestType: json["requestType"],
    projectId: json["projectID"],
    ProjectID:json["ProjectID"],
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
    accName: json["Acc_name"],
    accType: json["Acc_type"],
    supplierName: json["SupplierName"],
    suppliername: json["supplierName"],
    supplier: json["supplier"],
    preparedBy: json["PreparedBy"],
    preparedby: json["Preparedby"],
    preparedByid: json["PreparedById"],
    Preparedbyname: json["Preparedbyname"],
    prepareby: json["preparedby"],
    appRemarks: json["appRemarks"],
    preparedByName: json["Prepared_by"],
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
    totNos: json["TotNos"],
    totAmt: json["TotNos"],
    Payfor: json["Payfor"],
    ProjectId: json["ProjectId"],
    SiteId: json["SiteId"],
    SiteID: json["SiteID"],
    VerifiedBy: json["VerifiedBy"],
    PreapprovedBy: json["PreapprovedBy"],
    potype: json["PoType"],
    req_remarks: json["RequestRemarks"],
    app_remarks: json["AppRemarks"],
    delaydays: json["DelayDays"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    billno: json["Billno"],
    purchaseType: json["PurchaseType"],
    PurchaseType: json["purchaseType"],
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
    reqAmt: json["ReqAmt"],
    leaveReason: json["LeaveReason"],
    lFrdate: json["LFrdate"],
    lTodate: json["LTodate"],
    totalLeave: json["TotalLeave"],
    perReason: json["PerReason"],
    pFrdate: json["PFrdate"],
    pTodate: json["PTodate"],
    pFrTime: json["PFrTime"],
    pToTime: json["PToTime"],
    Time: json["Time"],
    Address: json["Address"],
    Remarks: json["Remarks"],
    Designation: json["Designation"],
    totalPerHrs: json["TotalPerHrs"],
    employeeName: json["EmployeeName"],
    PurchaseOrdDate: json["PurchaseOrdDate"],
    purchaseOrdNo: json["PurchaseOrdNo"],
    inwType: json["inw_type"],
    entryDate: json["entryDate"],
    approveByName: json["ApproveByName"],
    approvedbyname:json["approvedbyname"],
    createdByName: json["CreatedByName"],
    PurchaseOrdNo: json["purchaseOrdNo"],
    purchaseOrdDate: json["purchaseOrdDate"],
    fromSiteName: json["FromSiteName"],
    transferEntryDate: json["TransferEntryDate"],
    transEntryDate: json["transferEntryDate"],
    TransferNo: json["transferNo"],
    transferNo: json["TransferNo"],
    reqMasId: json["ReqMasId"],
    subcontractName: json["SubcontractName"],
    entryName: json["entryName"],
    verifiedBy: json["verifedName"],
      materialReqOrdMasId: json["materialReqOrdMasId"],
      reqDueDate: json["reqDueDate"],
      qCount: json["qCount"],
      createdBy: json["createdBy"],
      employeeId: json["employeeId"],
      quoteRemarks: json["quoteRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ReqOrdMasId": ReqOrdMasId,
    "PONO": PONo,
    "PoId": PoId,
    "reqOrdNo": reqOrdNo,
    "ReqOrdNo": ReqOrdNo,
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
    "preparedby": prepareby,
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
    "ToDate": toDate,
    "Billno": billno,
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
    "StaffName":staffName,
    "ReqAmt": reqAmt,
    "LeaveReason": leaveReason,
    "LFrdate": lFrdate,
    "LTodate": lTodate,
    "TotalLeave": totalLeave,
    "PerReason": perReason,
    "PFrdate": pFrdate,
    "PTodate": pTodate,
    "PFrTime": pFrTime,
    "PToTime": pToTime,
    "Address": Address,
    "Remarks":   Remarks,
    "Time":Time,
    "Designation":   Designation,
    "TotalPerHrs": totalPerHrs,
    "EmployeeName":employeeName,
    "PurchaseOrdNo": purchaseOrdNo,
    "purchaseOrdNo": PurchaseOrdNo,
    "purchaseOrdDate": purchaseOrdDate,
    "PurchaseOrdDate": PurchaseOrdDate,
    "inw_type": inwType,
    "ApproveByName": approveByName,
    "CreatedByName": createdByName,
    "approvedbyname":approvedbyname,
    "FromSiteName": fromSiteName,
    "TransferEntryDate": transferEntryDate,
    "transferEntryDate": transEntryDate,
    "transferNo": TransferNo,
    "TransferNo": transferNo,
    "ReqMasId": reqMasId,
    "entryDate": entryDate,
    "SubcontractName": subcontractName,
    "entryName": entryName,
    "verifedName": verifiedBy,
    "materialReqOrdMasId": materialReqOrdMasId,
    "reqDueDate": reqDueDate,
    "qCount": qCount,
    "createdBy": createdBy,
    "employeeId": employeeId,
    "quoteRemarks": quoteRemarks,
  };
}
