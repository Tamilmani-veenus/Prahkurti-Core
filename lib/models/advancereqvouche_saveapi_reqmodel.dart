import 'dart:convert';

AdvanceReqvoucherSaveApiReq advanceReqvoucherSaveApiReqFromJson(String str) => AdvanceReqvoucherSaveApiReq.fromJson(json.decode(str));

String advanceReqvoucherSaveApiReqToJson(AdvanceReqvoucherSaveApiReq data) => json.encode(data.toJson());

class AdvanceReqvoucherSaveApiReq {
  AdvanceReqvoucherSaveApiReq({
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
  String? projectId;
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

  factory AdvanceReqvoucherSaveApiReq.fromJson(Map<String, dynamic> json) => AdvanceReqvoucherSaveApiReq(
    vocId: json["VocId"],
    vocNo: json["VocNo"],
    vocDate: json["VocDate"],
    vocType: json["VocType"],
    projectId: json["ProjectId"],
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
    //-----NMR----
    this.siteId,
    this.payType,
    this.amt,
    this.tdsPer,
    this.tdsAmt,
    this.netAmt,
    //-----Advance------
    this.purOrdMasId,
    this.workOrdId,
  });
//-----NMR----
  String? siteId;
  String? payType;
  String? amt;
  String? tdsPer;
  String? tdsAmt;
  String? netAmt;
  //-----Advance------
  String? purOrdMasId;
  String? workOrdId;


  factory VocDet.fromJson(Map<String, dynamic> json) => VocDet(
    //-----NMR----
    siteId: json["SiteId"],
    payType: json["PayType"],
    amt: json["Amt"],
    tdsPer: json["TdsPer"],
    tdsAmt: json["TdsAmt"],
    netAmt: json["NetAmt"],
    //-----Advance------
    purOrdMasId: json["PurOrdMasId"],
    workOrdId: json["WorkOrdId"],
  );

  Map<String, dynamic> toJson() => {
    //-----NMR----
    "SiteId": siteId,
    "PayType": payType,
    "Amt": amt,
    "TdsPer": tdsPer,
    "TdsAmt": tdsAmt,
    "NetAmt": netAmt,
    //-----Advance------
    "PurOrdMasId": purOrdMasId,
    "WorkOrdId": workOrdId,
  };
}
