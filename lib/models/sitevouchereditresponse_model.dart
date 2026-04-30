// To parse this JSON data, do
//
//     final sitevouchereditResponse = sitevouchereditResponseFromJson(jsonString);

import 'dart:convert';

List<SitevouchereditResponse> sitevouchereditResponseFromJson(String str) => List<SitevouchereditResponse>.from(json.decode(str).map((x) => SitevouchereditResponse.fromJson(x)));

String sitevouchereditResponseToJson(List<SitevouchereditResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SitevouchereditResponse {
  SitevouchereditResponse({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.vocType,
    this.projectId,
    this.accTypeId,
    this.accNameId,
    this.projectName,
    this.accTypeName,
    this.accNameName,
    this.payFor,
    this.payForName,
    this.paidFromName,
    this.paidFrom,
    this.payMode,
    this.payModeName,
    this.payType,
    this.vocAmt,
    this.companyId,
    this.bankId,
    this.bankName,
    this.chqNo,
    this.chqDate,
    this.nameThrough,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.vocEditDet,
  });

  int? vocId;
  String? vocNo;
  String? vocDate;
  String? vocType;
  int? projectId;
  int? accTypeId;
  int? accNameId;
  String? projectName;
  String? accTypeName;
  String? accNameName;
  String? payFor;
  String? payForName;
  int? payMode;
  String? payModeName;
  String? paidFromName;
  int? paidFrom;
  String? payType;
  double? vocAmt;
  int? companyId;
  int? bankId;
  String? bankName;
  String? chqNo;
  String? chqDate;
  String? nameThrough;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  int? userId;
  String? entryMode;
  List<VocEditDet>? vocEditDet;

  factory SitevouchereditResponse.fromJson(Map<String, dynamic> json) => SitevouchereditResponse(
    vocId: json["VocId"],
    vocNo: json["VocNo"],
    vocDate: json["VocDate"],
    vocType: json["VocType"],
    projectId: json["ProjectId"],
    accTypeId: json["AccTypeId"],
    accNameId: json["AccNameId"],
    projectName: json["ProjectName"],
    accTypeName: json["AccTypeName"],
    accNameName: json["AccNameName"],
    payFor: json["PayFor"],
    payForName: json["PayForName"],
    payMode: json["PayMode"],
    payModeName: json["PayModeName"],
    payType: json["PayType"],
    vocAmt: json["VocAmt"],
    companyId: json["CompanyId"],
    paidFromName: json["PaidFromName"],
    paidFrom: json["PaidFrom"],
    bankId: json["BankId"],
    bankName: json["BankName"],
    chqNo: json["ChqNo"],
    chqDate: json["ChqDate"],
    nameThrough: json["NameThrough"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    vocEditDet: List<VocEditDet>.from(json["VocEditDet"].map((x) => VocEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "VocId": vocId,
    "VocNo": vocNo,
    "VocDate": vocDate,
    "VocType": vocType,
    "ProjectId": projectId,
    "AccTypeId": accTypeId,
    "AccNameId": accNameId,
    "ProjectName": projectName,
    "AccTypeName": accTypeName,
    "AccNameName": accNameName,
    "PayFor": payFor,
    "PayForName": payForName,
    "PayMode": payMode,
    "PayModeName": payModeName,
    "PayType": payType,
    "VocAmt": vocAmt,
    "CompanyId": companyId,
    "PaidFromName" : paidFromName,
    "PaidFrom" : paidFrom,
    "BankId": bankId,
    "BankName": bankName,
    "ChqNo": chqNo,
    "ChqDate": chqDate,
    "NameThrough": nameThrough,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "VocEditDet": List<dynamic>.from(vocEditDet!.map((x) => x.toJson())),
  };
}

class VocEditDet {
  VocEditDet({
    this.siteId,
    this.payType,
    this.payTypeName,
    this.siteName,
    this.amt,
    this.tdsPer,
    this.tdsAmt,
    this.netAmt,
  });

  int? siteId;
  String? payType;
  String? payTypeName;
  String? siteName;
  double? amt;
  double? tdsPer;
  double? tdsAmt;
  double? netAmt;

  factory VocEditDet.fromJson(Map<String, dynamic> json) => VocEditDet(
    siteId: json["SiteId"],
    payType: json["PayType"],
    payTypeName: json["PayTypeName"],
    siteName: json["SiteName"],
    amt: json["Amt"],
    tdsPer: json["TdsPer"],
    tdsAmt: json["TdsAmt"],
    netAmt: json["NetAmt"],
  );

  Map<String, dynamic> toJson() => {
    "SiteId": siteId,
    "PayType": payType,
    "PayTypeName": payTypeName,
    "SiteName": siteName,
    "Amt": amt,
    "TdsPer": tdsPer,
    "TdsAmt": tdsAmt,
    "NetAmt": netAmt,
  };
}
