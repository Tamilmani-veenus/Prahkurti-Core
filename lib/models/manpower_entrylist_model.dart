// To parse this JSON data, do
//
//     final manPowerEntryListModel = manPowerEntryListModelFromJson(jsonString);

import 'dart:convert';

ManPowerEntryListModel manPowerEntryListModelFromJson(String str) => ManPowerEntryListModel.fromJson(json.decode(str));

String manPowerEntryListModelToJson(ManPowerEntryListModel data) => json.encode(data.toJson());

class ManPowerEntryListModel {
  bool? success;
  List<Result>? result;
  String? message;

  ManPowerEntryListModel({
    this.success,
    this.result,
    this.message,
  });

  factory ManPowerEntryListModel.fromJson(Map<String, dynamic> json) => ManPowerEntryListModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? manPowerNo;
  String? entryDate;
  int? projectId;
  int? siteId;
  String? remarks;
  int? approvedBy;
  String? approveStatus;
  int? createdBy;
  String? createdDt;
  String? projectName;
  String? siteName;
  String? createdByName;
  String? status;

  Result({
    this.id,
    this.manPowerNo,
    this.entryDate,
    this.projectId,
    this.siteId,
    this.remarks,
    this.approvedBy,
    this.approveStatus,
    this.createdBy,
    this.createdDt,
    this.projectName,
    this.siteName,
    this.createdByName,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    manPowerNo: json["manPowerNo"],
    entryDate: json["entryDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    remarks: json["remarks"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    createdByName: json["createdByName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerNo": manPowerNo,
    "entryDate": entryDate,
    "projectId": projectId,
    "siteId": siteId,
    "remarks": remarks,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "projectName": projectName,
    "siteName": siteName,
    "createdByName": createdByName,
    "status": status,
  };
}
