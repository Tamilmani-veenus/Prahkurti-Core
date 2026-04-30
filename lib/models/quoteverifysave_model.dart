// To parse this JSON data, do
//
//     final quoteverifysave = quoteverifysaveFromJson(jsonString);

import 'dart:convert';

Quoteverifysave quoteverifysaveFromJson(String str) => Quoteverifysave.fromJson(json.decode(str));

String quoteverifysaveToJson(Quoteverifysave data) => json.encode(data.toJson());

class Quoteverifysave {
  int? reqId;
  String? reqNo;
  int? supplierId;
  int? empId;
  String? userId;
  String? deviceName;
  String? entryMode;
  String? appRemarks;
  String? remarks;
  // List<QuoteDet>? quoteDet;

  Quoteverifysave({
    this.reqId,
    this.reqNo,
    this.supplierId,
    this.empId,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.appRemarks,
    this.remarks,
    // this.quoteDet,
  });

  factory Quoteverifysave.fromJson(Map<String, dynamic> json) => Quoteverifysave(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    supplierId: json["Supplierid"],
    empId: json["EmpId"],
    userId: json["Userid"],
    deviceName: json["Devicename"],
    entryMode: json["EntryMode"],
    appRemarks: json["AppRemarks"],
    remarks: json["Remarks"],
    // quoteDet: List<QuoteDet>.from(json["QuoteDet"].map((x) => QuoteDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "Supplierid": supplierId,
    "EmpId": empId,
    "Userid": userId,
    "Devicename": deviceName,
    "EntryMode": entryMode,
    "AppRemarks": appRemarks,
    "Remarks": remarks,
    // "QuoteDet": List<dynamic>.from(quoteDet!.map((x) => x.toJson())),
  };
}

// class QuoteDet {
//   String? reqId;
//   String? quoteId;
//   String? supplierId;
//   String? no;
//   String? remarks;
//
//   QuoteDet({
//     this.reqId,
//     this.quoteId,
//     this.supplierId,
//     this.no,
//     this.remarks,
//   });
//
//   factory QuoteDet.fromJson(Map<String, dynamic> json) => QuoteDet(
//     reqId: json["reqId"],
//     quoteId: json["quoteId"],
//     supplierId: json["supplierId"],
//     no: json["No"],
//     remarks: json["Remarks"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "reqId": reqId,
//     "quoteId": quoteId,
//     "supplierId": supplierId,
//     "No": no,
//     "Remarks": remarks,
//   };
// }
