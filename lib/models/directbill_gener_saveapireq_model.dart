import 'dart:convert';

BillDirectGenSaveApiReq billDirectGenSaveApiReqFromJson(String str) => BillDirectGenSaveApiReq.fromJson(json.decode(str));

String billDirectGenSaveApiReqToJson(BillDirectGenSaveApiReq data) => json.encode(data.toJson());

class BillDirectGenSaveApiReq {
  BillDirectGenSaveApiReq({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
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
    this.userId,
    this.deviceName,
    this.entryMode,
    this.billDet,
    this.workOrderId,
    this.billno,
  });

  String? workId;
  String? workNo;
  String? workDate;
  String? projectId;
  String? siteId;
  String? subContId;
  String? entryType;
  String? fromDate;
  String? toDate;
  String? rndOff;
  String? billAmt;
  String? actAdvAmt;
  String? advAmt;
  String? netPayAmt;
  String? debitAmt;
  String? creditAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? remarks;
  String? preparedby;
  String? userId;
  String? deviceName;
  String? entryMode;
  String? workOrderId;
  String? billno;
  List<BillDet>? billDet;

  factory BillDirectGenSaveApiReq.fromJson(Map<String, dynamic> json) => BillDirectGenSaveApiReq(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
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
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    workOrderId: json["WorkOrderId"],
    billno: json["billno"],
    billDet: List<BillDet>.from(json["BillDet"].map((x) => BillDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
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
    "UserId": userId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "WorkOrderId": workOrderId,
    "billno": billno,
    "BillDet": List<dynamic>.from(billDet!.map((x) => x.toJson())),
  };
}

class BillDet {
  BillDet({
    this.sno,
    this.itemDes,
    this.unit,
    this.qty,
    this.rate,
    this.amount,
  });

  String? sno;
  String? itemDes;
  String? unit;
  String? qty;
  String? rate;
  String? amount;

  factory BillDet.fromJson(Map<String, dynamic> json) => BillDet(
    sno: json["Sno"],
    itemDes: json["ItemDes"],
    unit: json["Unit"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "Sno": sno,
    "ItemDes": itemDes,
    "Unit": unit,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
  };
}
