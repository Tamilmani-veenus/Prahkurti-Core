// To parse this JSON data, do
//
//     final mrnfinalapprovalModel = mrnfinalapprovalModelFromJson(jsonString);

import 'dart:convert';

MrnfinalapprovalModel mrnfinalapprovalModelFromJson(String str) => MrnfinalapprovalModel.fromJson(json.decode(str));

String mrnfinalapprovalModelToJson(MrnfinalapprovalModel data) => json.encode(data.toJson());

class MrnfinalapprovalModel {
  bool? success;
  String? message;
  Result? result;

  MrnfinalapprovalModel({
    this.success,
    this.message,
    this.result,
  });

  factory MrnfinalapprovalModel.fromJson(Map<String, dynamic> json) => MrnfinalapprovalModel(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class Result {
  int? id;
  String? no;
  String? date;
  String? dueDate;
  String? requestType;
  int? ProjectId;
  int? SiteId;
  String? req_remarks;
  int? createdBy;
  String? createdDt;
  int? preparedByid;
  String? verifyStatus;
  String? verifyDate;
  String? app_remarks;
  String? approveStatus;
  int? updatedBy;
  String? updatedDate;
  int? preApproveBy;
  String? preApproveStatus;
  String? preApproveDate;
  int? approvedBy;
  String? approveDate;
  dynamic? fromProjectName;
  String? siteName;
  String? preparedBy;
  String? VerifiedBy;
  String? approvedName;
  String? PreapprovedBy;
  String? projectName;
  dynamic? approveNo;
  List<MMatReqMasLink>? mMatReqMasLink;

  Result({
    this.id,
    this.no,
    this.date,
    this.dueDate,
    this.requestType,
    this.ProjectId,
    this.preparedByid,
    this.SiteId,
    this.req_remarks,
    this.createdBy,
    this.createdDt,
    this.VerifiedBy,
    this.verifyStatus,
    this.verifyDate,
    this.app_remarks,
    this.approveStatus,
    this.updatedBy,
    this.updatedDate,
    this.preApproveBy,
    this.preApproveStatus,
    this.preApproveDate,
    this.approvedBy,
    this.approveDate,
    this.fromProjectName,
    this.siteName,
    this.preparedBy,
    this.approvedName,
    this.PreapprovedBy,
    this.projectName,
    this.approveNo,
    this.mMatReqMasLink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    no: json["reqOrdNo"],
    date: json["reqOrdDate"],
    dueDate: json["reqdueDate"],
    requestType: json["requestType"],
    ProjectId: json["projectID"],
    SiteId: json["siteID"],
    req_remarks: json["reqRemarks"],
    createdBy: json["createdBy"],
    preparedByid: json["createdBy"],
    createdDt: json["createdDt"],
    VerifiedBy: json["verifyName"],
    verifyStatus: json["verifyStatus"],
    verifyDate: json["verifyDate"],
    app_remarks: json["approveRemarks"],
    approveStatus: json["approveStatus"],
    updatedBy: json["updatedBy"],
    updatedDate: json["updatedDate"],
    preApproveBy: json["preApproveBy"],
    preApproveStatus: json["preApproveStatus"],
    preApproveDate: json["preApproveDate"],
    approvedBy: json["approvedBy"],
    approveDate: json["approveDate"],
    fromProjectName: json["fromProjectName"],
    siteName: json["siteName"],
    preparedBy: json["createdName"],
    approvedName: json["approvedName"],
    PreapprovedBy: json["preApprovedName"],
    projectName: json["projectName"],
    approveNo: json["approveNo"],
    mMatReqMasLink: List<MMatReqMasLink>.from(json["mMatReqMasLink"].map((x) => MMatReqMasLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reqOrdNo": no,
    "reqOrdDate": date,
    "reqdueDate": dueDate,
    "requestType": requestType,
    "projectID": ProjectId,
    "createdBy": preparedByid,
    "siteID": SiteId,
    "reqRemarks": req_remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyName": VerifiedBy,
    "verifyStatus": verifyStatus,
    "verifyDate": verifyDate,
    "approveRemarks": app_remarks,
    "approveStatus": approveStatus,
    "updatedBy": updatedBy,
    "updatedDate": updatedDate,
    "preApproveBy": preApproveBy,
    "preApproveStatus": preApproveStatus,
    "preApproveDate": preApproveDate,
    "approvedBy": approvedBy,
    "approveDate": approveDate,
    "fromProjectName": fromProjectName,
    "siteName": siteName,
    "createdName": preparedBy,
    "approvedName": approvedName,
    "preApprovedName": PreapprovedBy,
    "projectName": projectName,
    "approveNo": approveNo,
    "mMatReqMasLink": List<dynamic>.from(mMatReqMasLink!.map((x) => x.toJson())),
  };
}

class MMatReqMasLink {
  int? reqMasDetId;
  int? materialReqOrdMasid;
  int? materialid;
  int? scaleId;
  int? siteId;
  int? refProjectId;
  num? reqQty;
  num? qty;
  String? remarks;
  String? description;
  String? apptype;
  String? preApproveStatus;
  String? approveType;
  String? approveStatus;
  String? material;
  String? scale;
  dynamic? refProjectName;
  num? stockQty;
  num? balQty;

  MMatReqMasLink({
    this.reqMasDetId,
    this.materialReqOrdMasid,
    this.materialid,
    this.scaleId,
    this.siteId,
    this.refProjectId,
    this.reqQty,
    this.qty,
    this.remarks,
    this.description,
    this.apptype,
    this.preApproveStatus,
    this.approveType,
    this.approveStatus,
    this.material,
    this.scale,
    this.refProjectName,
    this.stockQty,
    this.balQty,
  });

  factory MMatReqMasLink.fromJson(Map<String, dynamic> json) => MMatReqMasLink(
    reqMasDetId: json["id"],
    materialReqOrdMasid: json["materialReqOrdMasid"],
    materialid: json["materialID"],
    scaleId: json["scaleID"],
    siteId: json["siteID"],
    refProjectId: json["refProjectId"],
    reqQty: json["reqQty"]as num?,
    qty: json["qty"]as num?,
    remarks: json["remarks"],
    description: json["reqDescription"],
    apptype: json["preApproveType"],
    preApproveStatus: json["preApproveStatus"],
    approveType: json["approveType"],
    approveStatus: json["approveStatus"],
    material: json["materialName"],
    scale: json["scaleName"],
    refProjectName: json["refProjectName"],
    stockQty: json["stockQty"]as num?,
    balQty: json["balQty"]as num?,
  );

  Map<String, dynamic> toJson() => {
    "id": reqMasDetId,
    "materialReqOrdMasid": materialReqOrdMasid,
    "materialID": materialid,
    "scaleID": scaleId,
    "siteID": siteId,
    "refProjectId": refProjectId,
    "reqQty": reqQty,
    "qty": qty,
    "remarks": remarks,
    "reqDescription": description,
    "preApproveType": apptype,
    "preApproveStatus": preApproveStatus,
    "approveType": approveType,
    "approveStatus": approveStatus,
    "materialName": material,
    "scaleName": scale,
    "refProjectName": refProjectName,
    "stockQty": stockQty,
    "balQty": balQty,
  };
}
