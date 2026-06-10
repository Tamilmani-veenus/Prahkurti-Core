// To parse this JSON data, do
//
//     final requisitonSlipsaveRequest = requisitonSlipsaveRequestFromJson(jsonString);

import 'dart:convert';

RequisitonSlipsaveRequest requisitonSlipsaveRequestFromJson(String str) => RequisitonSlipsaveRequest.fromJson(json.decode(str));

String requisitonSlipsaveRequestToJson(RequisitonSlipsaveRequest data) => json.encode(data.toJson());

class RequisitonSlipsaveRequest {
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
  String? verifyStatus;
  String? approveStatus;
  String? verifyRemarks;
  String? approveRemarks;

  RequisitonSlipsaveRequest({
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
    this.verifyStatus,
    this.approveStatus,
    this.verifyRemarks,
    this.approveRemarks,
  });

  factory RequisitonSlipsaveRequest.fromJson(Map<String, dynamic> json) => RequisitonSlipsaveRequest(
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
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
    verifyRemarks: json["verifyRemarks"],
    approveRemarks: json["approveRemarks"],
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
    "verifyStatus": verifyStatus,
    "approveStatus": approveStatus,
    "verifyRemarks": verifyRemarks,
    "approveRemarks": approveRemarks,
  };
}
