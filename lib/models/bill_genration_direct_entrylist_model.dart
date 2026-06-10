// To parse this JSON data, do
//
//     final billDirectentrylist = billDirectentrylistFromJson(jsonString);

import 'dart:convert';

BillDirectentrylist billDirectentrylistFromJson(String str) => BillDirectentrylist.fromJson(json.decode(str));

String billDirectentrylistToJson(BillDirectentrylist data) => json.encode(data.toJson());

class BillDirectentrylist {
  bool? success;
  List<Result>? result;
  String? message;

  BillDirectentrylist({
    this.success,
    this.result,
    this.message,
  });

  factory BillDirectentrylist.fromJson(Map<String, dynamic> json) => BillDirectentrylist(
    success: json["success"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  int? id;
  String? workNo;
  String? workDate;
  String? entryType;
  String? billType;
  int? projectId;
  int? siteId;
  int? subContractorId;
  int? workOrderId;
  int? refWorkId;
  String? fromWorkDate;
  String? toWorkDate;
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
  String? subContractorName;
  String? createdName;
  String? verifiedName;
  String? approvedName;
  String? status;


  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.entryType,
    this.billType,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.workOrderId,
    this.refWorkId,
    this.fromWorkDate,
    this.toWorkDate,
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
    this.subContractorName,
    this.createdName,
    this.verifiedName,
    this.approvedName,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    entryType: json["entryType"],
    billType: json["billType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    workOrderId: json["workOrderId"],
    refWorkId: json["refWorkId"],
    fromWorkDate: json["fromWorkDate"],
    toWorkDate: json["toWorkDate"],
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
    subContractorName: json["subContractorName"],
    createdName: json["createdName"],
    verifiedName: json["verifiedName"],
    approvedName: json["approvedName"],
    status: json["status"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "workDate": workDate,
    "entryType": entryType,
    "billType": billType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "workOrderId": workOrderId,
    "refWorkId": refWorkId,
    "fromWorkDate": fromWorkDate,
    "toWorkDate": toWorkDate,
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
    "subContractorName": subContractorName,
    "createdName": createdName,
    "verifiedName": verifiedName,
    "approvedName": approvedName,
    "status": status,
  };
}
