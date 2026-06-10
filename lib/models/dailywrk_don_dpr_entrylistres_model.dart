// To parse this JSON data, do
//
//     final dailywrkDoneDprEntrylistResmodel = dailywrkDoneDprEntrylistResmodelFromJson(jsonString);

import 'dart:convert';

DailywrkDoneDprEntrylistResmodel dailywrkDoneDprEntrylistResmodelFromJson(String str) => DailywrkDoneDprEntrylistResmodel.fromJson(json.decode(str));

String dailywrkDoneDprEntrylistResmodelToJson(DailywrkDoneDprEntrylistResmodel data) => json.encode(data.toJson());

class DailywrkDoneDprEntrylistResmodel {
  bool? success;
  List<Result>? result;
  String? message;

  DailywrkDoneDprEntrylistResmodel({
    this.success,
    this.result,
    this.message,
  });

  factory DailywrkDoneDprEntrylistResmodel.fromJson(Map<String, dynamic> json) => DailywrkDoneDprEntrylistResmodel(
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
  String? workNo;
  String? workDate;
  String? workType;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? entryType;
  int? dprType;
  String? billStatus;
  int? totalAmount;
  String? refNo;
  dynamic remarks;
  int? createdBy;
  DateTime? createdDt;
  int? verifyBy;
  String? verifyStatus;
  dynamic verifyDt;
  int? approvedBy;
  String? approveStatus;
  dynamic approveDt;
  String? projectName;
  String? siteName;
  dynamic status;
  String? subcontractorName;
  String? createdName;
  dynamic verifyName;
  dynamic approvedName;
  String? entryTypeDesc;
  String? workTypeDesc;

  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.workType,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.entryType,
    this.dprType,
    this.billStatus,
    this.totalAmount,
    this.refNo,
    this.remarks,
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
    this.status,
    this.subcontractorName,
    this.createdName,
    this.verifyName,
    this.approvedName,
    this.entryTypeDesc,
    this.workTypeDesc,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    workType: json["workType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    entryType: json["entryType"],
    dprType: json["dprType"],
    billStatus: json["billStatus"],
    totalAmount: json["totalAmount"],
    refNo: json["refNo"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: DateTime.parse(json["createdDt"]),
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    status: json["status"],
    subcontractorName: json["subcontractorName"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approvedName: json["approvedName"],
    entryTypeDesc: json["entryTypeDesc"],
    workTypeDesc: json["workTypeDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "workDate": workDate,
    "workType": workType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "entryType": entryType,
    "dprType": dprType,
    "billStatus": billStatus,
    "totalAmount": totalAmount,
    "refNo": refNo,
    "remarks": remarks,
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
    "status": status,
    "subcontractorName": subcontractorName,
    "createdName": createdName,
    "verifyName": verifyName,
    "approvedName": approvedName,
    "entryTypeDesc": entryTypeDesc,
    "workTypeDesc": workTypeDesc,
  };
}
