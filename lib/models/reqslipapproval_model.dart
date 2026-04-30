// To parse this JSON data, do
//
//     final reqSlipApproval = reqSlipApprovalFromJson(jsonString);

import 'dart:convert';

ReqSlipApproval reqSlipApprovalFromJson(String str) => ReqSlipApproval.fromJson(json.decode(str));

String reqSlipApprovalToJson(ReqSlipApproval data) => json.encode(data.toJson());

class ReqSlipApproval {
  String? urlName;
  String? reqId;
  String? reqNo;
  String? deviceName;
  String? userId;
  String? approvedBy;
  String? appRemarks;

  ReqSlipApproval({
  this.urlName,
  this.reqId,
  this.reqNo,
  this.deviceName,
  this.userId,
  this.approvedBy,
  this.appRemarks,
  });

  factory ReqSlipApproval.fromJson(Map<String, dynamic> json) => ReqSlipApproval(
    urlName: json["URLName"],
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    deviceName: json["DeviceName"],
    userId: json["UserId"],
    approvedBy: json["ApprovedBy"],
    appRemarks: json["AppRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "URLName": urlName,
    "ReqId": reqId,
    "ReqNo": reqNo,
    "DeviceName": deviceName,
    "UserId": userId,
    "ApprovedBy": approvedBy,
    "AppRemarks": appRemarks,
  };
}
