// To parse this JSON data, do
//
//     final staffvouchersiteRequest = staffvouchersiteRequestFromJson(jsonString);

import 'dart:convert';

StaffvouchersiteRequest staffvouchersiteRequestFromJson(String str) => StaffvouchersiteRequest.fromJson(json.decode(str));

String staffvouchersiteRequestToJson(StaffvouchersiteRequest data) => json.encode(data.toJson());

class StaffvouchersiteRequest {
  StaffvouchersiteRequest({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.vocType,
    this.staffId,
    this.accTypeId,
    this.accNameId,
    this.payFor,
    this.payMode,
    this.payType,
    this.vocAmt,
    this.companyId,
    this.bankId,
    this.chqNo,
    this.chqDate,
    this.nameThrough,
    this.remarks,
    this.preparedby,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.vocDet,
  });

  String? vocId;
  String? vocNo;
  String? vocDate;
  String? vocType;
  String? staffId;
  String? accTypeId;
  String? accNameId;
  String? payFor;
  String? payMode;
  String? payType;
  String? vocAmt;
  String? companyId;
  String? bankId;
  String? chqNo;
  String? chqDate;
  String? nameThrough;
  String? remarks;
  String? preparedby;
  String? userId;
  String? deviceName;
  String? entryMode;
  List<VocDet>? vocDet;

  factory StaffvouchersiteRequest.fromJson(Map<String, dynamic> json) => StaffvouchersiteRequest(
    vocId: json["VocId"],
    vocNo: json["VocNo"],
    vocDate: json["VocDate"],
    vocType: json["VocType"],
    staffId: json["StaffId"],
    accTypeId: json["AccTypeId"],
    accNameId: json["AccNameId"],
    payFor: json["PayFor"],
    payMode: json["PayMode"],
    payType: json["PayType"],
    vocAmt: json["VocAmt"],
    companyId: json["CompanyId"],
    bankId: json["BankId"],
    chqNo: json["ChqNo"],
    chqDate: json["ChqDate"],
    nameThrough: json["NameThrough"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    vocDet: List<VocDet>.from(json["VocDet"].map((x) => VocDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "VocId": vocId,
    "VocNo": vocNo,
    "VocDate": vocDate,
    "VocType": vocType,
    "StaffId": staffId,
    "AccTypeId": accTypeId,
    "AccNameId": accNameId,
    "PayFor": payFor,
    "PayMode": payMode,
    "PayType": payType,
    "VocAmt": vocAmt,
    "CompanyId": companyId,
    "BankId": bankId,
    "ChqNo": chqNo,
    "ChqDate": chqDate,
    "NameThrough": nameThrough,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "UserId": userId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "VocDet": List<dynamic>.from(vocDet!.map((x) => x.toJson())),
  };
}

class VocDet {
  VocDet({
    this.projectId,
    this.siteId,
    this.payType,
    this.amt,
    this.tdsPer,
    this.tdsAmt,
    this.netAmt,
  });

  String? projectId;
  String? siteId;
  String? payType;
  String? amt;
  String? tdsPer;
  String? tdsAmt;
  String? netAmt;

  factory VocDet.fromJson(Map<String, dynamic> json) => VocDet(
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    payType: json["PayType"],
    amt: json["Amt"],
    tdsPer: json["TdsPer"],
    tdsAmt: json["TdsAmt"],
    netAmt: json["NetAmt"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "SiteId": siteId,
    "PayType": payType,
    "Amt": amt,
    "TdsPer": tdsPer,
    "TdsAmt": tdsAmt,
    "NetAmt": netAmt,
  };
}
