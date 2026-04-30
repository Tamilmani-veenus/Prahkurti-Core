// To parse this JSON data, do
//
//     final requisitonSlipsaveRequest = requisitonSlipsaveRequestFromJson(jsonString);

import 'dart:convert';

RequisitonSlipsaveRequest requisitonSlipsaveRequestFromJson(String str) => RequisitonSlipsaveRequest.fromJson(json.decode(str));

String requisitonSlipsaveRequestToJson(RequisitonSlipsaveRequest data) => json.encode(data.toJson());

class RequisitonSlipsaveRequest {
  RequisitonSlipsaveRequest({
    this.reqId,
    this.reqNo,
    this.reqDate,
    this.staffId,
    this.projectid,
    this.reqType,
    this.leaveReason,
    this.lFrdate,
    this.lTodate,
    this.totalLeave,
    this.perReason,
    this.pFrdate,
    this.pTodate,
    this.pFrTime,
    this.pToTime,
    this.totalPerHrs,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.pTimeHrs,
    this.pTimeMins,
  });

  String? reqId;
  String? reqNo;
  String? reqDate;
  String? staffId;
  String? projectid;
  String? reqType;
  String? leaveReason;
  String? lFrdate;
  String? lTodate;
  String? totalLeave;
  String? perReason;
  String? pFrdate;
  String? pTodate;
  String? pFrTime;
  String? pToTime;
  String? totalPerHrs;
  String? userId;
  String? entryMode;
  String? deviceName;
  String? pTimeHrs;
  String? pTimeMins;

  factory RequisitonSlipsaveRequest.fromJson(Map<String, dynamic> json) => RequisitonSlipsaveRequest(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    reqDate: json["ReqDate"],
    staffId: json["StaffId"],
    projectid: json["Projectid"],
    reqType: json["ReqType"],
    leaveReason: json["LeaveReason"],
    lFrdate: json["LFrdate"],
    lTodate: json["LTodate"],
    totalLeave: json["TotalLeave"],
    perReason: json["PerReason"],
    pFrdate: json["PFrdate"],
    pTodate: json["PTodate"],
    pFrTime: json["PFrTime"],
    pToTime: json["PToTime"],
    totalPerHrs: json["TotalPerHrs"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    pTimeHrs: json["PTimeHrs"],
    pTimeMins: json["PTimeMins"],
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "ReqDate": reqDate,
    "StaffId": staffId,
    "Projectid": projectid,
    "ReqType": reqType,
    "LeaveReason": leaveReason,
    "LFrdate": lFrdate,
    "LTodate": lTodate,
    "TotalLeave": totalLeave,
    "PerReason": perReason,
    "PFrdate": pFrdate,
    "PTodate": pTodate,
    "PFrTime": pFrTime,
    "PToTime": pToTime,
    "TotalPerHrs": totalPerHrs,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "PTimeHrs": pTimeHrs,
    "PTimeMins": pTimeMins,
  };
}
