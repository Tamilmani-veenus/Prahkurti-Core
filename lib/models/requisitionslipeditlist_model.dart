// To parse this JSON data, do
//
//     final requisitonSlipEditList = requisitonSlipEditListFromJson(jsonString);

import 'dart:convert';

RequisitonSlipEditList requisitonSlipEditListFromJson(String str) => RequisitonSlipEditList.fromJson(json.decode(str));

String requisitonSlipEditListToJson(RequisitonSlipEditList data) => json.encode(data.toJson());

class RequisitonSlipEditList {
  bool? success;
  String? message;
  Result? result;

  RequisitonSlipEditList({
    this.success,
    this.message,
    this.result,
  });

  factory RequisitonSlipEditList.fromJson(Map<String, dynamic> json) => RequisitonSlipEditList(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  int? id;
  String? requisitionNo;
  String? requisitionType;
  String? entryDate;
  int? staffId;
  int? projectId;
  String? leaveReason;
  String? leaveFromDate;
  String? leaveToDate;
  double? totalLeaveDays;
  String? permissionReason;
  String? permissionFromDate;
  String? permissionToDate;
  String? permissionFromTime;
  String? permissionToTime;
  int? permissionTimeHrs;
  int? permissionTimeMins;
  double? totalPermissionHours;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? approveStatus;
  String? staffName;
  String? projectName;
  String? createdName;
  String? staffNo;
  String? requisitionTypeDesc;

  Result({
    this.id,
    this.requisitionNo,
    this.requisitionType,
    this.entryDate,
    this.staffId,
    this.projectId,
    this.leaveReason,
    this.leaveFromDate,
    this.leaveToDate,
    this.totalLeaveDays,
    this.permissionReason,
    this.permissionFromDate,
    this.permissionToDate,
    this.permissionFromTime,
    this.permissionToTime,
    this.permissionTimeHrs,
    this.permissionTimeMins,
    this.totalPermissionHours,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.approveStatus,
    this.staffName,
    this.projectName,
    this.createdName,
    this.staffNo,
    this.requisitionTypeDesc,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    requisitionNo: json["requisitionNo"],
    requisitionType: json["requisitionType"],
    entryDate: json["entryDate"],
    staffId: json["staffId"],
    projectId: json["projectId"],
    leaveReason: json["leaveReason"],
    leaveFromDate: json["leaveFromDate"],
    leaveToDate: json["leaveToDate"],
    totalLeaveDays: json["totalLeaveDays"],
    permissionReason: json["permissionReason"],
    permissionFromDate: json["permissionFromDate"],
    permissionToDate: json["permissionToDate"],
    permissionFromTime: json["permissionFromTime"],
    permissionToTime: json["permissionToTime"],
    permissionTimeHrs: json["permissionTimeHrs"],
    permissionTimeMins: json["permissionTimeMins"],
    totalPermissionHours: json["totalPermissionHours"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
    staffName: json["staffName"],
    projectName: json["projectName"],
    createdName: json["createdName"],
    staffNo: json["staffNo"],
    requisitionTypeDesc: json["requisitionTypeDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "requisitionNo": requisitionNo,
    "requisitionType": requisitionType,
    "entryDate": entryDate,
    "staffId": staffId,
    "projectId": projectId,
    "leaveReason": leaveReason,
    "leaveFromDate": leaveFromDate,
    "leaveToDate": leaveToDate,
    "totalLeaveDays": totalLeaveDays,
    "permissionReason": permissionReason,
    "permissionFromDate": permissionFromDate,
    "permissionToDate": permissionToDate,
    "permissionFromTime": permissionFromTime,
    "permissionToTime": permissionToTime,
    "permissionTimeHrs": permissionTimeHrs,
    "permissionTimeMins": permissionTimeMins,
    "totalPermissionHours": totalPermissionHours,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "approveStatus": approveStatus,
    "staffName": staffName,
    "projectName": projectName,
    "createdName": createdName,
    "staffNo": staffNo,
    "requisitionTypeDesc": requisitionTypeDesc,
  };
}
