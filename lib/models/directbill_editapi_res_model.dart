// import 'dart:convert';
//
// List<DirectbillEditApiResModel> directbillEditApiResModelFromJson(String str) => List<DirectbillEditApiResModel>.from(json.decode(str).map((x) => DirectbillEditApiResModel.fromJson(x)));
//
// String directbillEditApiResModelToJson(List<DirectbillEditApiResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class DirectbillEditApiResModel {
//   DirectbillEditApiResModel({
//     this.workId,
//     this.workNo,
//     this.workDate,
//     this.projectId,
//     this.siteId,
//     this.subContId,
//     this.entryType,
//     this.fromDate,
//     this.toDate,
//     this.rndOff,
//     this.billAmt,
//     this.actAdvAmt,
//     this.advAmt,
//     this.netPayAmt,
//     this.debitAmt,
//     this.creditAmt,
//     this.debitRemarks,
//     this.creditRemarks,
//     this.remarks,
//     this.preparedby,
//     this.userId,
//     this.deviceName,
//     this.entryMode,
//     this.billEditDet,
//   });
//
//   int? workId;
//   String? workNo;
//   String? workDate;
//   int? projectId;
//   int? siteId;
//   int? subContId;
//   String? entryType;
//   String? fromDate;
//   String? toDate;
//   double? rndOff;
//   double? billAmt;
//   double? actAdvAmt;
//   double? advAmt;
//   double? netPayAmt;
//   double? debitAmt;
//   double? creditAmt;
//   String? debitRemarks;
//   String? creditRemarks;
//   String? remarks;
//   int? preparedby;
//   String? userId;
//   String? deviceName;
//   String? entryMode;
//   List<BillEditDet>? billEditDet;
//
//   factory DirectbillEditApiResModel.fromJson(Map<String, dynamic> json) => DirectbillEditApiResModel(
//     workId: json["WorkId"],
//     workNo: json["WorkNo"],
//     workDate: json["WorkDate"],
//     projectId: json["ProjectId"],
//     siteId: json["SiteId"],
//     subContId: json["SubContId"],
//     entryType: json["EntryType"],
//     fromDate: json["FromDate"],
//     toDate: json["ToDate"],
//     rndOff: json["RndOff"],
//     billAmt: json["BillAmt"],
//     actAdvAmt: json["ActAdvAmt"],
//     advAmt: json["AdvAmt"],
//     netPayAmt: json["NetPayAmt"],
//     debitAmt: json["DebitAmt"],
//     creditAmt: json["CreditAmt"],
//     debitRemarks: json["DebitRemarks"],
//     creditRemarks: json["CreditRemarks"],
//     remarks: json["remarks"],
//     preparedby: json["Preparedby"],
//     userId: json["UserId"],
//     deviceName: json["DeviceName"],
//     entryMode: json["EntryMode"],
//     billEditDet: List<BillEditDet>.from(json["BillEditDet"].map((x) => BillEditDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "WorkId": workId,
//     "WorkNo": workNo,
//     "WorkDate": workDate,
//     "ProjectId": projectId,
//     "SiteId": siteId,
//     "SubContId": subContId,
//     "EntryType": entryType,
//     "FromDate": fromDate,
//     "ToDate": toDate,
//     "RndOff": rndOff,
//     "BillAmt": billAmt,
//     "ActAdvAmt": actAdvAmt,
//     "AdvAmt": advAmt,
//     "NetPayAmt": netPayAmt,
//     "DebitAmt": debitAmt,
//     "CreditAmt": creditAmt,
//     "DebitRemarks": debitRemarks,
//     "CreditRemarks": creditRemarks,
//     "remarks": remarks,
//     "Preparedby": preparedby,
//     "UserId": userId,
//     "DeviceName": deviceName,
//     "EntryMode": entryMode,
//     "BillEditDet": List<dynamic>.from(billEditDet!.map((x) => x.toJson())),
//   };
// }
//
// class BillEditDet {
//   BillEditDet({
//     this.sno,
//     this.itemDes,
//     this.unit,
//     this.qty,
//     this.rate,
//     this.amount,
//   });
//
//   int? sno;
//   String? itemDes;
//   String? unit;
//   double? qty;
//   double? rate;
//   double? amount;
//
//   factory BillEditDet.fromJson(Map<String, dynamic> json) => BillEditDet(
//     sno: json["Sno"],
//     itemDes: json["ItemDes"],
//     unit: json["Unit"],
//     qty: json["Qty"],
//     rate: json["Rate"],
//     amount: json["Amount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Sno": sno,
//     "ItemDes": itemDes,
//     "Unit": unit,
//     "Qty": qty,
//     "Rate": rate,
//     "Amount": amount,
//   };
// }


// To parse this JSON data, do
//
//     final directbillEditApiResModel = directbillEditApiResModelFromJson(jsonString);

import 'dart:convert';

List<DirectbillEditApiResModel> directbillEditApiResModelFromJson(String str) => List<DirectbillEditApiResModel>.from(json.decode(str).map((x) => DirectbillEditApiResModel.fromJson(x)));

String directbillEditApiResModelToJson(List<DirectbillEditApiResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DirectbillEditApiResModel {
  DirectbillEditApiResModel({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.projectName,
    this.siteName,
    this.subContName,
    this.entryType,
    this.fromDate,
    this.toDate,
    this.rndOff,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.debitAmt,
    this.creditAmt,
    this.debitRemarks,
    this.creditRemarks,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.workOrderId,
    this.workOrderNo,
    this.billNo,
    this.billEditDet,
  });

  int? workId;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContId;
  String? projectName;
  String? siteName;
  String? subContName;
  String? entryType;
  String? fromDate;
  String? toDate;
  double? rndOff;
  double? billAmt;
  double? actAdvAmt;
  double? advAmt;
  double? netPayAmt;
  double? debitAmt;
  double? creditAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  int? userId;
  String? workOrderNo;
  int? workOrderId;
  String? entryMode;
  String? billNo;
  List<BillEditDet>? billEditDet;

  factory DirectbillEditApiResModel.fromJson(Map<String, dynamic> json) => DirectbillEditApiResModel(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    entryType: json["EntryType"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    rndOff: json["RndOff"],
    billAmt: json["BillAmt"],
    actAdvAmt: json["ActAdvAmt"],
    advAmt: json["AdvAmt"],
    netPayAmt: json["NetPayAmt"],
    debitAmt: json["DebitAmt"],
    creditAmt: json["CreditAmt"],
    debitRemarks: json["DebitRemarks"],
    creditRemarks: json["CreditRemarks"],
    remarks: json["remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    workOrderNo: json["WorkOrderNo"],
    workOrderId: json["WorkOrderId"],
    billNo: json["BillNo"],
    billEditDet: List<BillEditDet>.from(json["BillEditDet"].map((x) => BillEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubContName": subContName,
    "EntryType": entryType,
    "FromDate": fromDate,
    "ToDate": toDate,
    "RndOff": rndOff,
    "BillAmt": billAmt,
    "ActAdvAmt": actAdvAmt,
    "AdvAmt": advAmt,
    "NetPayAmt": netPayAmt,
    "DebitAmt": debitAmt,
    "CreditAmt": creditAmt,
    "DebitRemarks": debitRemarks,
    "CreditRemarks": creditRemarks,
    "remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "WorkOrderNo": workOrderNo,
    "WorkOrderId": workOrderId,
    "BillNo": billNo,
    "BillEditDet": List<dynamic>.from(billEditDet!.map((x) => x.toJson())),
  };
}

class BillEditDet {
  BillEditDet({
    this.sno,
    this.itemDesc,
    this.unit,
    this.qty,
    this.rate,
    this.amount,
    this.workOrderId,
    this.workDetid,
  });

  int? sno;
  String? itemDesc;
  String? unit;
  double? qty;
  double? rate;
  double? amount;
  int? workDetid;
  int? workOrderId;

  factory BillEditDet.fromJson(Map<String, dynamic> json) => BillEditDet(
    sno: json["Sno"],
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    workDetid: json["WorkOrderDetId"],
    workOrderId: json["WorkOrderId"],
  );

  Map<String, dynamic> toJson() => {
    "Sno": sno,
    "ItemDesc": itemDesc,
    "Unit": unit,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
    "WorkOrderDetId": workDetid,
    "WorkOrderId": workOrderId,
  };
}
