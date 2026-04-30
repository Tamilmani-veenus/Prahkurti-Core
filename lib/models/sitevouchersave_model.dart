// To parse this JSON data, do
//
//     final sitevouchersaverequest = sitevouchersaverequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

Sitevouchersaverequest sitevouchersaverequestFromJson(String str) => Sitevouchersaverequest.fromJson(json.decode(str));

String sitevouchersaverequestToJson(Sitevouchersaverequest data) => json.encode(data.toJson());

class Sitevouchersaverequest {
  Sitevouchersaverequest({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.vocType,
    this.projectId,
    this.accTypeId,
    this.accNameId,
    this.payFor,
    this.payMode,
    this.payType,
    this.vocAmt,
    this.companyId,
    this.paidFrom,
    this.bankId,
    this.chqNo,
    this.chqDate,
    this.nameThrough,
    this.remarks,
    this.preparedby,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.vocFile,
    this.vocDet,

  });

  String? vocId;
  String? vocNo;
  String? vocDate;
  String? vocType;
  String? projectId;
  String? accTypeId;
  String? accNameId;
  String? payFor;
  String? payMode;
  String? payType;
  String? vocAmt;
  String? companyId;
  String? bankId;
  String? paidFrom;
  String? chqNo;
  String? chqDate;
  String? nameThrough;
  String? remarks;
  String? preparedby;
  String? userId;
  String? deviceName;
  String? entryMode;
  List<File>? vocFile;
  List<VocDet>? vocDet;

  factory Sitevouchersaverequest.fromJson(Map<String, dynamic> json) => Sitevouchersaverequest(
    vocId: json["VocId"],
    vocNo: json["VocNo"],
    vocDate: json["VocDate"],
    vocType: json["VocType"],
    projectId: json["ProjectId"],
    accTypeId: json["AccTypeId"],
    accNameId: json["AccNameId"],
    paidFrom: json["PaidFrom"],
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
    vocFile : json["VocFlie"],
    vocDet: List<VocDet>.from(json["VocDet"].map((x) => VocDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "VocId": vocId,
    "VocNo": vocNo,
    "VocDate": vocDate,
    "VocType": vocType,
    "PaidFrom": paidFrom,
    "ProjectId": projectId,
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
    this.siteId,
    this.payType,
    this.amt,
    this.tdsPer,
    this.tdsAmt,
    this.netAmt,
  });

  String? siteId;
  String? payType;
  String? amt;
  String? tdsPer;
  String? tdsAmt;
  String? netAmt;

  factory VocDet.fromJson(Map<String, dynamic> json) => VocDet(
    siteId: json["SiteId"],
    payType: json["PayType"],
    amt: json["Amt"],
    tdsPer: json["TdsPer"],
    tdsAmt: json["TdsAmt"],
    netAmt: json["NetAmt"],
  );

  Map<String, dynamic> toJson() => {
    "SiteId": siteId,
    "PayType": payType,
    "Amt": amt,
    "TdsPer": tdsPer,
    "TdsAmt": tdsAmt,
    "NetAmt": netAmt,
  };
}
