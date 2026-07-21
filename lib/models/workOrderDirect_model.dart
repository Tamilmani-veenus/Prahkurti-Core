// To parse this JSON data, do
//
//     final workOrdDirectModel = workOrdDirectModelFromJson(jsonString);

import 'dart:convert';

WorkOrdDirectModel workOrdDirectModelFromJson(String str) => WorkOrdDirectModel.fromJson(json.decode(str));

String workOrdDirectModelToJson(WorkOrdDirectModel data) => json.encode(data.toJson());

class WorkOrdDirectModel {
  bool? success;
  List<Result>? result;
  String? message;

  WorkOrdDirectModel({
    this.success,
    this.result,
    this.message,
  });

  factory WorkOrdDirectModel.fromJson(Map<String, dynamic> json) => WorkOrdDirectModel(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  int? id;
  String? workOrderNo;
  String? entryDate;
  String? entryType;
  int? projectId;
  int? siteId;
  int? subContractorId;
  double? roundOff;
  double? workOrderAmount;
  double? netAmount;
  String? remarks;
  String? termsCondition;
  String? workStatus;
  String? mailStatus;
  String? downloadStatus;
  String? active;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDt;
  int? approvedBy;
  String? approveStatus;
  String? approveDt;
  String? projectName;
  String? siteName;
  String? createdName;
  String? verifyName;
  String? approveName;
  String? subContractorName;
  dynamic? headItemName;
  dynamic? subHeadItemName;
  dynamic? level3ItemName;
  String? entryTypeName;


  Result({
    this.id,
    this.workOrderNo,
    this.entryDate,
    this.entryType,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.roundOff,
    this.workOrderAmount,
    this.netAmount,
    this.remarks,
    this.termsCondition,
    this.workStatus,
    this.mailStatus,
    this.downloadStatus,
    this.active,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.verifyDt,
    this.approvedBy,
    this.approveStatus,
    this.approveDt,
    this.projectName,
    this.siteName,
    this.createdName,
    this.verifyName,
    this.approveName,
    this.subContractorName,
    this.headItemName,
    this.subHeadItemName,
    this.level3ItemName,
    this.entryTypeName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workOrderNo: json["workOrderNo"],
    entryDate: json["entryDate"],
    entryType: json["entryType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    roundOff: json["roundOff"],
    workOrderAmount: json["workOrderAmount"],
    netAmount: json["netAmount"].toDouble(),
    remarks: json["remarks"],
    termsCondition: json["termsCondition"],
    workStatus: json["workStatus"],
    mailStatus: json["mailStatus"],
    downloadStatus: json["downloadStatus"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approveName: json["approveName"],
    subContractorName: json["subContractorName"],
    headItemName: json["headItemName"],
    subHeadItemName: json["subHeadItemName"],
    level3ItemName: json["level3ItemName"],
    entryTypeName: json["entryTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workOrderNo": workOrderNo,
    "entryDate": entryDate,
    "entryType": entryType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "roundOff": roundOff,
    "workOrderAmount": workOrderAmount,
    "netAmount": netAmount,
    "remarks": remarks,
    "termsCondition": termsCondition,
    "workStatus": workStatus,
    "mailStatus": mailStatus,
    "downloadStatus": downloadStatus,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDt": verifyDt,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDt": approveDt,
    "projectName": projectName,
    "siteName": siteName,
    "createdName": createdName,
    "verifyName": verifyName,
    "approveName": approveName,
    "subContractorName": subContractorName,
    "headItemName": headItemName,
    "subHeadItemName": subHeadItemName,
    "level3ItemName": level3ItemName,
    "entryTypeName": entryTypeName,
  };
}


