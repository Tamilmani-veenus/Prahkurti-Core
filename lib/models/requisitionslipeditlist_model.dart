// To parse this JSON data, do
//
//     final requisitonSlipeditlist = requisitonSlipeditlistFromJson(jsonString);

import 'dart:convert';

List<RequisitonSlipeditlist> requisitonSlipeditlistFromJson(String str) => List<RequisitonSlipeditlist>.from(json.decode(str).map((x) => RequisitonSlipeditlist.fromJson(x)));

String requisitonSlipeditlistToJson(List<RequisitonSlipeditlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequisitonSlipeditlist {
  RequisitonSlipeditlist({
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
    this.verifyStatus,
    this.verifiedBy,
    this.verifyRemarks,
    this.appStatus,
    this.approvedBy,
    this.appRemarks,
    this.projectName,
    this.staffName,
    this.userId,
    this.entryMode,
  });

  int? reqId;
  String? reqNo;
  String? reqDate;
  int? staffId;
  int? projectid;
  String? reqType;
  String? leaveReason;
  String? lFrdate;
  String? lTodate;
  double? totalLeave;
  String? perReason;
  String? pFrdate;
  String? pTodate;
  String? pFrTime;
  String? pToTime;
  double? totalPerHrs;
  String? verifyStatus;
  int? verifiedBy;
  String? verifyRemarks;
  String? appStatus;
  int? approvedBy;
  String? appRemarks;
  String? projectName;
  String? staffName;
  int? userId;
  String? entryMode;

  factory RequisitonSlipeditlist.fromJson(Map<String, dynamic> json) => RequisitonSlipeditlist(
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
    verifyStatus: json["VerifyStatus"],
    verifiedBy: json["VerifiedBy"],
    verifyRemarks: json["VerifyRemarks"],
    appStatus: json["AppStatus"],
    approvedBy: json["ApprovedBy"],
    appRemarks: json["AppRemarks"],
    projectName: json["ProjectName"],
    staffName: json["StaffName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
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
    "VerifyStatus": verifyStatus,
    "VerifiedBy": verifiedBy,
    "VerifyRemarks": verifyRemarks,
    "AppStatus": appStatus,
    "ApprovedBy": approvedBy,
    "AppRemarks": appRemarks,
    "ProjectName": projectName,
    "StaffName": staffName,
    "UserId": userId,
    "EntryMode": entryMode,
  };
}
