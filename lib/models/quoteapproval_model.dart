// To parse this JSON data, do
//
//     final quoteverifysave = quoteverifysaveFromJson(jsonString);

import 'dart:convert';

QuoteApprovesave quoteapprovesaveFromJson(String str) => QuoteApprovesave.fromJson(json.decode(str));

String quoteapprovesaveToJson(QuoteApprovesave data) => json.encode(data.toJson());

class QuoteApprovesave {
  int? reqId;
  String? reqNo;
  int? projectId;
  int? supplierId;
  int? empId;
  String? userId;
  String? deviceName;
  String? entryMode;
  String? appRemarks;
  String? remarks;
  List<QuoteDet>? quoteDet;

  QuoteApprovesave({
    this.reqId,
    this.reqNo,
    this.projectId,
    this.supplierId,
    this.empId,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.appRemarks,
    this.remarks,
    this.quoteDet,
  });

  factory QuoteApprovesave.fromJson(Map<String, dynamic> json) => QuoteApprovesave(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    projectId: json["Projectid"],
    supplierId: json["Supplierid"],
    empId: json["EmpId"],
    userId: json["Userid"],
    deviceName: json["Devicename"],
    entryMode: json["EntryMode"],
    appRemarks: json["AppRemarks"],
    remarks: json["Remarks"],
    quoteDet: List<QuoteDet>.from(json["QuoteDet"].map((x) => QuoteDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "Projectid": projectId,
    "Supplierid": supplierId,
    "EmpId": empId,
    "Userid": userId,
    "Devicename": deviceName,
    "EntryMode": entryMode,
    "AppRemarks": appRemarks,
    "Remarks": remarks,
    "QuoteDet": List<dynamic>.from(quoteDet!.map((x) => x.toJson())),
  };
}

class QuoteDet {
  String? reqId;
  String? quoteId;
  String? supplierId;
  String? no;
  String? remarks;

  QuoteDet({
    this.reqId,
    this.quoteId,
    this.supplierId,
    this.no,
    this.remarks,
  });

  factory QuoteDet.fromJson(Map<String, dynamic> json) => QuoteDet(
    reqId: json["reqId"],
    quoteId: json["quoteId"],
    supplierId: json["supplierId"],
    no: json["No"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "reqId": reqId,
    "quoteId": quoteId,
    "supplierId": supplierId,
    "No": no,
    "Remarks": remarks,
  };
}
