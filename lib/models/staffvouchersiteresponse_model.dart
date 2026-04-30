// To parse this JSON data, do
//
//     final staffvouchereditResponse = staffvouchereditResponseFromJson(jsonString);

import 'dart:convert';

List<StaffvouchereditResponse> staffvouchereditResponseFromJson(String str) => List<StaffvouchereditResponse>.from(json.decode(str).map((x) => StaffvouchereditResponse.fromJson(x)));

String staffvouchereditResponseToJson(List<StaffvouchereditResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffvouchereditResponse {
  StaffvouchereditResponse({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.vocType,
    this.staffId,
    this.accTypeId,
    this.accNameId,
    this.staffName,
    this.accTypeName,
    this.accNameName,
    this.payFor,
    this.payForName,
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
  int? staffId;
  int? accTypeId;
  int? accNameId;
  String? staffName;
  String? accTypeName;
  String? accNameName;
  String? payFor;
  String? payForName;
  int? payMode;
  String? payModeName;
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

  factory StaffvouchereditResponse.fromJson(Map<String, dynamic> json) => StaffvouchereditResponse(
    vocId: json["VocId"],
    vocNo: json["VocNo"],
    vocDate: json["VocDate"],
    vocType: json["VocType"],
    staffId: json["StaffId"],
    accTypeId: json["AccTypeId"],
    accNameId: json["AccNameId"],
    staffName: json["StaffName"],
    accTypeName: json["AccTypeName"],
    accNameName: json["AccNameName"],
    payFor: json["PayFor"],
    payForName: json["PayForName"],
    payMode: json["PayMode"],
    payModeName: json["PayModeName"],
    payType: json["PayType"],
    vocAmt: json["VocAmt"],
    companyId: json["CompanyId"],
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
    "StaffId": staffId,
    "AccTypeId": accTypeId,
    "AccNameId": accNameId,
    "StaffName": staffName,
    "AccTypeName": accTypeName,
    "AccNameName": accNameName,
    "PayFor": payFor,
    "PayForName": payForName,
    "PayMode": payMode,
    "PayModeName": payModeName,
    "PayType": payType,
    "VocAmt": vocAmt,
    "CompanyId": companyId,
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
    this.projectId,
    this.siteId,
    this.payType,
    this.payTypeName,
    this.projectName,
    this.siteName,
    this.amt,
    this.tdsPer,
    this.tdsAmt,
    this.netAmt,
  });

  int? projectId;
  int? siteId;
  String? payType;
  String? payTypeName;
  String? projectName;
  String? siteName;
  double? amt;
  double? tdsPer;
  double? tdsAmt;
  double? netAmt;

  factory VocEditDet.fromJson(Map<String, dynamic> json) => VocEditDet(
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    payType: json["PayType"],
    payTypeName: json["PayTypeName"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    amt: json["Amt"],
    tdsPer: json["TdsPer"],
    tdsAmt: json["TdsAmt"],
    netAmt: json["NetAmt"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "SiteId": siteId,
    "PayType": payType,
    "PayTypeName": payTypeName,
    "ProjectName": projectName,
    "SiteName": siteName,
    "Amt": amt,
    "TdsPer": tdsPer,
    "TdsAmt": tdsAmt,
    "NetAmt": netAmt,
  };
}
