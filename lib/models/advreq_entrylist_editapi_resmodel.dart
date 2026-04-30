import 'dart:convert';

List<AdvReqEditApiResmodel> advReqEditApiResmodelFromJson(String str) => List<AdvReqEditApiResmodel>.from(json.decode(str).map((x) => AdvReqEditApiResmodel.fromJson(x)));

String advReqEditApiResmodelToJson(List<AdvReqEditApiResmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvReqEditApiResmodel {
  AdvReqEditApiResmodel({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.projectId,
    this.projectName,
    this.accTypeId,
    this.accNameId,
    this.payMode,
    this.vocType,
    this.payFor,
    this.payType,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.vocAmt,
    this.nameThrough,
    this.companyId,
    this.bankId,
    this.bankName,
    this.chqNo,
    this.chqDate,
    this.accNameName,
    this.accTypeName,
    this.payForName,
    this.PayModeName,
    this.vocEditDet,
  });

  int? vocId;
  String? vocNo;
  String? vocDate;
  int? projectId;
  String? projectName;
  int? accTypeId;
  int? accNameId;
  int? payMode;
  String? vocType;
  String? payFor;
  String? payType;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  double? vocAmt;
  String? nameThrough;
  int? companyId;
  int? bankId;
  String? bankName;
  String? chqNo;
  String? chqDate;
  String? accNameName;
  String? accTypeName;
  String? payForName;
  String? PayModeName;
  List<VocEditDet>? vocEditDet;

  factory AdvReqEditApiResmodel.fromJson(Map<String, dynamic> json) => AdvReqEditApiResmodel(
    vocId: json["VocId"],
    vocNo: json["VocNo"],
    vocDate: json["VocDate"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    accTypeId: json["AccTypeId"],
    accNameId: json["AccNameId"],
    payMode: json["PayMode"],
    vocType: json["VocType"],
    payFor: json["PayFor"],
    payType: json["PayType"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    vocAmt: json["VocAmt"],
    nameThrough: json["NameThrough"],
    companyId: json["CompanyId"],
    bankId: json["BankId"],
    bankName: json["BankName"],
    chqNo: json["ChqNo"],
    chqDate: json["ChqDate"],
    accNameName: json["AccNameName"],
    accTypeName: json["AccTypeName"],
    payForName: json["PayForName"],
    PayModeName: json["PayModeName"],
    vocEditDet: List<VocEditDet>.from(json["VocEditDet"].map((x) => VocEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "VocId": vocId,
    "VocNo": vocNo,
    "VocDate": vocDate,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "AccTypeId": accTypeId,
    "AccNameId": accNameId,
    "PayMode": payMode,
    "VocType": vocType,
    "PayFor": payFor,
    "PayType": payType,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "VocAmt": vocAmt,
    "NameThrough": nameThrough,
    "CompanyId": companyId,
    "BankId": bankId,
    "BankName": bankName,
    "ChqNo": chqNo,
    "ChqDate": chqDate,
    "AccNameName": accNameName,
    "AccTypeName": accTypeName,
    "PayForName": payForName,
    "PayModeName": PayModeName,
    "VocEditDet": List<dynamic>.from(vocEditDet!.map((x) => x.toJson())),
  };
}

class VocEditDet {
  int? siteId;
  String? payType;
  String? payTypeName;
  String? siteName;
  double? amt;
  double? tdsPer;
  double? tdsAmt;
  double? netAmt;
  int? purOrdMasId;
  dynamic poNo;
  int? workOrdId;
  int? projectId;
  dynamic project;
  double? billAmt;
  double? bAmount;
  double? advancAmt;
  double? amount;

  VocEditDet({
    this.siteId,
    this.payType,
    this.payTypeName,
    this.siteName,
    this.amt,
    this.tdsPer,
    this.tdsAmt,
    this.netAmt,
    this.purOrdMasId,
    this.poNo,
    this.workOrdId,
    this.projectId,
    this.project,
    this.billAmt,
    this.bAmount,
    this.advancAmt,
    this.amount,
  });

  factory VocEditDet.fromJson(Map<String, dynamic> json) => VocEditDet(
    siteId: json["SiteId"],
    payType: json["PayType"],
    payTypeName: json["PayTypeName"],
    siteName: json["SiteName"],
    amt: json["Amt"],
    tdsPer: json["TdsPer"],
    tdsAmt: json["TdsAmt"],
    netAmt: json["NetAmt"],
    purOrdMasId: json["PurOrdMasId"],
    poNo: json["PoNo"],
    workOrdId: json["WorkOrdId"],
    projectId: json["projectId"],
    project: json["project"],
    billAmt: json["BillAmt"],
    bAmount: json["BAmount"],
    advancAmt: json["AdvancAmt"],
    amount: json["Amount"],
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
    "PurOrdMasId": purOrdMasId,
    "PoNo": poNo,
    "WorkOrdId": workOrdId,
    "projectId": projectId,
    "project": project,
    "BillAmt": billAmt,
    "BAmount": bAmount,
    "AdvancAmt": advancAmt,
    "Amount": amount,
  };
}



// To parse this JSON data, do
//
//     final advReqEditApiResmodel = advReqEditApiResmodelFromJson(jsonString);

// To parse this JSON data, do
//
//     final advReqEditApiResmodel = advReqEditApiResmodelFromJson(jsonString);

// import 'dart:convert';
//
// List<AdvReqEditApiResmodel> advReqEditApiResmodelFromJson(String str) => List<AdvReqEditApiResmodel>.from(json.decode(str).map((x) => AdvReqEditApiResmodel.fromJson(x)));
//
// String advReqEditApiResmodelToJson(List<AdvReqEditApiResmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class AdvReqEditApiResmodel {
//   int? vocId;
//   String? vocNo;
//   String? vocDate;
//   String? vocType;
//   int? projectId;
//   int? accTypeId;
//   int? accNameId;
//   String? projectName;
//   String? accTypeName;
//   String? accNameName;
//   String? payFor;
//   String? payForName;
//   int? payMode;
//   String? payModeName;
//   String? payType;
//   double? vocAmt;
//   int? companyId;
//   int? bankId;
//   String? bankName;
//   String? chqNo;
//   String? chqDate;
//   String? nameThrough;
//   String? remarks;
//   int? preparedby;
//   String? preparedbyName;
//   int? userId;
//   String? entryMode;
//   List<VocDet>? vocDet;
//
//   AdvReqEditApiResmodel({
//      this.vocId,
//      this.vocNo,
//      this.vocDate,
//      this.vocType,
//      this.projectId,
//      this.accTypeId,
//      this.accNameId,
//      this.projectName,
//      this.accTypeName,
//      this.accNameName,
//      this.payFor,
//      this.payForName,
//      this.payMode,
//      this.payModeName,
//      this.payType,
//      this.vocAmt,
//      this.companyId,
//      this.bankId,
//      this.bankName,
//      this.chqNo,
//      this.chqDate,
//      this.nameThrough,
//      this.remarks,
//      this.preparedby,
//      this.preparedbyName,
//      this.userId,
//      this.entryMode,
//      this.vocDet,
//   });
//
//   factory AdvReqEditApiResmodel.fromJson(Map<String, dynamic> json) => AdvReqEditApiResmodel(
//     vocId: json["VocId"],
//     vocNo: json["VocNo"],
//     vocDate: json["VocDate"],
//     vocType: json["VocType"],
//     projectId: json["ProjectId"],
//     accTypeId: json["AccTypeId"],
//     accNameId: json["AccNameId"],
//     projectName: json["ProjectName"],
//     accTypeName: json["AccTypeName"],
//     accNameName: json["AccNameName"],
//     payFor: json["PayFor"],
//     payForName: json["PayForName"],
//     payMode: json["PayMode"],
//     payModeName: json["PayModeName"],
//     payType: json["PayType"],
//     vocAmt: json["VocAmt"],
//     companyId: json["CompanyId"],
//     bankId: json["BankId"],
//     bankName: json["BankName"],
//     chqNo: json["ChqNo"],
//     chqDate: json["ChqDate"],
//     nameThrough: json["NameThrough"],
//     remarks: json["Remarks"],
//     preparedby: json["Preparedby"],
//     preparedbyName: json["PreparedbyName"],
//     userId: json["UserId"],
//     entryMode: json["EntryMode"],
//     vocDet: List<VocDet>.from(json["VocDet"].map((x) => VocDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "VocId": vocId,
//     "VocNo": vocNo,
//     "VocDate": vocDate,
//     "VocType": vocType,
//     "ProjectId": projectId,
//     "AccTypeId": accTypeId,
//     "AccNameId": accNameId,
//     "ProjectName": projectName,
//     "AccTypeName": accTypeName,
//     "AccNameName": accNameName,
//     "PayFor": payFor,
//     "PayForName": payForName,
//     "PayMode": payMode,
//     "PayModeName": payModeName,
//     "PayType": payType,
//     "VocAmt": vocAmt,
//     "CompanyId": companyId,
//     "BankId": bankId,
//     "BankName": bankName,
//     "ChqNo": chqNo,
//     "ChqDate": chqDate,
//     "NameThrough": nameThrough,
//     "Remarks": remarks,
//     "Preparedby": preparedby,
//     "PreparedbyName": preparedbyName,
//     "UserId": userId,
//     "EntryMode": entryMode,
//     "VocDet": List<dynamic>.from(vocDet!.map((x) => x.toJson())),
//   };
// }
//
// class VocDet {
//   int? purOrdMasId;
//   int? workOrderId;
//   int? siteId;
//   String? payType;
//   String? payTypeName;
//   String? siteName;
//   double? amt;
//   double? tdsPer;
//   double? tdsAmt;
//   double? netAmt;
//   String? orderNo;
//   int? projectid;
//   String? project;
//   double? amount;
//   double? bAmount;
//   double? advanceAmt;
//
//   VocDet({
//     this.purOrdMasId,
//     this.workOrderId,
//     this.siteId,
//     this.payType,
//     this.payTypeName,
//     this.siteName,
//     this.amt,
//     this.tdsPer,
//     this.tdsAmt,
//     this.netAmt,
//     this.orderNo,
//     this.projectid,
//     this.project,
//     this.amount,
//     this.bAmount,
//     this.advanceAmt,
//   });
//
//   factory VocDet.fromJson(Map<String, dynamic> json) => VocDet(
//     purOrdMasId: json["PurOrdMasId"],
//     workOrderId: json["WorkOrderId"],
//     siteId: json["SiteId"],
//     payType: json["PayType"] ?? "",
//     payTypeName: json["PayTypeName"] ?? "",
//     siteName: json["SiteName"],
//     amt: json["Amt"],
//     tdsPer: json["TdsPer"],
//     tdsAmt: json["TdsAmt"],
//     netAmt: json["NetAmt"],
//     orderNo: json["PoNo"],
//     projectid: json["Projectid"],
//     project: json["Project"],
//     amount: json["Amount"],
//     bAmount: json["BAmount"],
//     advanceAmt: json["AdvanceAmt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "PurOrdMasId": purOrdMasId,
//     "WorkOrderId": workOrderId,
//     "SiteId": siteId,
//     "PayType": payType,
//     "PayTypeName": payTypeName,
//     "SiteName": siteName,
//     "Amt": amt,
//     "TdsPer": tdsPer,
//     "TdsAmt": tdsAmt,
//     "NetAmt": netAmt,
//     "PoNo": orderNo,
//     "Projectid": projectid,
//     "Project": project,
//     "Amount": amount,
//     "BAmount": bAmount,
//     "AdvanceAmt": advanceAmt,
//   };
// }