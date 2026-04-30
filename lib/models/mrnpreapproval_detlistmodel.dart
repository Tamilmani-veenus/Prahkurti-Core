// To parse this JSON data, do
//
//     final mrnfinalapprovalModel = mrnfinalapprovalModelFromJson(jsonString);

import 'dart:convert';

MrnpreapprovalModel mrnpreapprovalModelFromJson(String str) => MrnpreapprovalModel.fromJson(json.decode(str));

String mrnfinalapprovalModelToJson(MrnpreapprovalModel data) => json.encode(data.toJson());

class MrnpreapprovalModel {
  bool? success;
  String? message;
  Result? result;

  MrnpreapprovalModel({
    this.success,
    this.message,
    this.result,
  });

  factory MrnpreapprovalModel.fromJson(Map<String, dynamic> json) => MrnpreapprovalModel(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:result!.toJson(),
  };
}

class Result {
  int? materialReqOrdMasId;
  String? no;
  String? date;
  int? ProjectId;
  String? projectName;
  String? dueDate;
  int? SiteId;
  String? req_remarks;
  String? siteName;
  String? preparedBy;
  String? VerifiedBy;
  int? preparedByid;
  String? createdDt;
  String? requestType;
  String? approveDate;
  int? approvedBy;
  String? approveStatus;
  String? approveRemarks;
  int? preApproveBy;
  String? preApproveDate;
  String? preApproveStatus;
  List<MMatReqMasLink>? mMatReqMasLink;

  Result({
    this.materialReqOrdMasId,
    this.no,
    this.date,
    this.ProjectId,
    this.projectName,
    this.dueDate,
    this.SiteId,
    this.req_remarks,
    this.siteName,
    this.preparedBy,
    this.VerifiedBy,
    this.preparedByid,
    this.createdDt,
    this.requestType,
    this.approveDate,
    this.approvedBy,
    this.approveStatus,
    this.approveRemarks,
    this.preApproveBy,
    this.preApproveDate,
    this.preApproveStatus,
    this.mMatReqMasLink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    materialReqOrdMasId: json["materialReqOrdMasId"],
    no: json["ReqOrdNo"],
    date: json["ReqOrdDate"],
    ProjectId: json["ProjectID"],
    projectName: json["ProjectName"],
    dueDate: json["ReqdueDate"],
    SiteId: json["SiteID"],
    req_remarks: json["ReqRemarks"],
    siteName: json["SiteName"],
    preparedBy: json["CreatedName"],
    VerifiedBy: json["VerifyName"],
    preparedByid: json["CreatedBy"],
    createdDt: json["CreatedDt"],
    requestType: json["RequestType"],
    approveDate: json["ApproveDate"],
    approvedBy: json["ApprovedBy"],
    approveStatus: json["ApproveStatus"],
    approveRemarks: json["ApproveRemarks"],
    preApproveBy: json["PreApproveBy"],
    preApproveDate: json["PreApproveDate"],
    preApproveStatus: json["PreApproveStatus"],
    mMatReqMasLink: List<MMatReqMasLink>.from(json["mMatReqMasLink"].map((x) => MMatReqMasLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "materialReqOrdMasId": materialReqOrdMasId,
    "ReqOrdNo": no,
    "ReqOrdDate": date,
    "ProjectID": ProjectId,
    "ProjectName": projectName,
    "ReqdueDate": dueDate,
    "SiteID": SiteId,
    "ReqRemarks": req_remarks,
    "SiteName": siteName,
    "CreatedName": preparedBy,
    "VerifyName": VerifiedBy,
    "CreatedBy": preparedByid,
    "CreatedDt": createdDt,
    "RequestType": requestType,
    "ApproveDate": approveDate,
    "ApprovedBy": approvedBy,
    "ApproveStatus": approveStatus,
    "ApproveRemarks": approveRemarks,
    "PreApproveBy": preApproveBy,
    "PreApproveDate": preApproveDate,
    "PreApproveStatus": preApproveStatus,
    "mMatReqMasLink": List<dynamic>.from(mMatReqMasLink!.map((x) => x.toJson())),
  };
}

class MMatReqMasLink {
  int? reqMasDetId;
  int? materialReqOrdMasId;
  int? materialid;
  String? material;
  double? reqQty;
  double? qty;
  int? siteId;
  int? scaleId;
  String? scale;
  double? estQty;
  double? stockQty;
  double? balQty;
  String? type;
  String? appType;
  String? approveName;
  int? refProjectId;
  String? refProjectName;
  String? description;
  String? remarks;

  MMatReqMasLink({
    this.reqMasDetId,
    this.materialReqOrdMasId,
    this.materialid,
    this.material,
    this.reqQty,
    this.qty,
    this.siteId,
    this.scaleId,
    this.scale,
    this.estQty,
    this.stockQty,
    this.balQty,
    this.type,
    this.appType,
    this.approveName,
    this.refProjectId,
    this.refProjectName,
    this.description,
    this.remarks,
  });

  factory MMatReqMasLink.fromJson(Map<String, dynamic> json) => MMatReqMasLink(
    reqMasDetId: json["materialReqOrdDetId"],
    materialReqOrdMasId: json["materialReqOrdMasId"],
    materialid: json["Materialid"],
    material: json["MaterialName"],
    reqQty: json["req_qty"],
    qty: json["qty"],
    siteId: json["SiteID"],
    scaleId: json["ScaleID"],
    scale: json["ScaleName"],
    estQty: json["EstQty"],
    stockQty: json["StockQty"],
    balQty: json["BalQty"],
    type: json["type"],
    appType: json["app_type"],
    approveName: json["ApproveName"],
    refProjectId: json["RefProjectId"],
    refProjectName: json["Ref_ProjectName"],
    description: json["Description"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "materialReqOrdDetId": reqMasDetId,
    "materialReqOrdMasId": materialReqOrdMasId,
    "Materialid": materialid,
    "MaterialName": material,
    "req_qty": reqQty,
    "qty": qty,
    "SiteID": siteId,
    "ScaleID": scaleId,
    "ScaleName": scale,
    "EstQty": estQty,
    "StockQty": stockQty,
    "BalQty": balQty,
    "type": type,
    "app_type": appType,
    "ApproveName": approveName,
    "RefProjectId": refProjectId,
    "Ref_ProjectName": refProjectName,
    "Description": description,
    "remarks": remarks,
  };
}
