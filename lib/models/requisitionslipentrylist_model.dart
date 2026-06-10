// To parse this JSON data, do
//
//     final requisitonSlipEntrylistResponse = requisitonSlipEntrylistResponseFromJson(jsonString);

import 'dart:convert';

RequisitonSlipEntrylistResponse requisitonSlipEntrylistResponseFromJson(String str) => RequisitonSlipEntrylistResponse.fromJson(json.decode(str));

String requisitonSlipEntrylistResponseToJson(RequisitonSlipEntrylistResponse data) => json.encode(data.toJson());

class RequisitonSlipEntrylistResponse {
  bool? success;
  String? message;
  List<Result>? result;

  RequisitonSlipEntrylistResponse({
    this.success,
    this.message,
    this.result,
  });

  factory RequisitonSlipEntrylistResponse.fromJson(Map<String, dynamic> json) => RequisitonSlipEntrylistResponse(
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
  String? verifyDt;
  int? approvedBy;
  String? approveStatus;
  String? approveDt;
  String? verifyRemarks;
  String? approveRemarks;
  String? status;
  String? staffName;
  String? projectName;
  String? createdName;
  String? approvedName;
  String? verifyName;
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
    this.verifyDt,
    this.approvedBy,
    this.approveStatus,
    this.approveDt,
    this.verifyRemarks,
    this.approveRemarks,
    this.status,
    this.staffName,
    this.projectName,
    this.createdName,
    this.approvedName,
    this.verifyName,
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
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    verifyRemarks: json["verifyRemarks"],
    approveRemarks: json["approveRemarks"],
    status: json["status"],
    staffName: json["staffName"],
    projectName: json["projectName"],
    createdName: json["createdName"],
    approvedName: json["approvedName"],
    verifyName: json["verifyName"],
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
    "verifyDt": verifyDt,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDt": approveDt,
    "verifyRemarks": verifyRemarks,
    "approveRemarks": approveRemarks,
    "status": status,
    "staffName": staffName,
    "projectName": projectName,
    "createdName": createdName,
    "approvedName": approvedName,
    "verifyName": verifyName,
    "staffNo": staffNo,
    "requisitionTypeDesc": requisitionTypeDesc,
  };
}
