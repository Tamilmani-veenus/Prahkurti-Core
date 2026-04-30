import 'dart:convert';

DailywrkDoneDprlabourSaveApiReq dailywrkDoneDprlabourSaveApiReqFromJson(String str) => DailywrkDoneDprlabourSaveApiReq.fromJson(json.decode(str));

String dailywrkDoneDprlabourSaveApiReqToJson(DailywrkDoneDprlabourSaveApiReq data) => json.encode(data.toJson());

class DailywrkDoneDprlabourSaveApiReq {
  DailywrkDoneDprlabourSaveApiReq({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.refNo,
    this.entryType,
    this.remarks,
    this.preparedby,
    this.approvedby,
    this.userId,
    this.empId,
    this.deviceName,
    this.entryMode,
    this.dprLab,
    this.dprDet,
  });

  String? workId;
  String? workNo;
  String? workDate;
  String? projectId;
  String? siteId;
  String? subContId;
  String? refNo;
  String? entryType;
  String? remarks;
  String? preparedby;
  String? approvedby;
  String? userId;
  String? empId;
  String? deviceName;
  String? entryMode;
  List<DprLab>? dprLab;
  List<DprDet>? dprDet;

  factory DailywrkDoneDprlabourSaveApiReq.fromJson(Map<String, dynamic> json) => DailywrkDoneDprlabourSaveApiReq(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    refNo: json["RefNo"],
    entryType: json["EntryType"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    approvedby: json["Approvedby"],
    userId: json["UserId"],
    empId: json["EmpId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    dprLab: List<DprLab>.from(json["DprLab"].map((x) => DprLab.fromJson(x))),
    dprDet: List<DprDet>.from(json["DprDet"].map((x) => DprDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "RefNo": refNo,
    "EntryType": entryType,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "Approvedby": approvedby,
    "UserId": userId,
    "EmpId": empId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "DprLab": List<dynamic>.from(dprLab!.map((x) => x.toJson())),
    "DprDet": List<dynamic>.from(dprDet!.map((x) => x.toJson())),
  };
}

class DprDet {
  DprDet({
    this.headItemId,
    this.subItemId,
    this.level3ItemId,
    this.woDetId,
    this.unit,
    this.qty,
    this.rate,
    this.amount,
    this.detRemarks,
  });

  String? headItemId;
  String? subItemId;
  String? level3ItemId;
  String? woDetId;
  String? unit;
  String? qty;
  String? rate;
  String? amount;
  String? detRemarks;

  factory DprDet.fromJson(Map<String, dynamic> json) => DprDet(
    headItemId: json["HeadItemId"],
    subItemId: json["SubItemId"],
    level3ItemId: json["Level3ItemId"],
    woDetId: json["WODetId"],
    unit: json["Unit"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItemId": headItemId,
    "SubItemId": subItemId,
    "Level3ItemId": level3ItemId,
    "WODetId": woDetId,
    "Unit": unit,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
    "DetRemarks": detRemarks,
  };
}

class DprLab {
  DprLab({
    this.categoryId,
    this.subId,
    this.subcontName,
    this.nos,
    this.wages,
    this.otHrs,
    this.otAmt,
    this.amount,
    this.labRemark,
  });

  String? categoryId;
  String? subId;
  String? subcontName;
  String? nos;
  String? wages;
  String? otHrs;
  String? otAmt;
  String? amount;
  String? labRemark;

  factory DprLab.fromJson(Map<String, dynamic> json) => DprLab(
    categoryId: json["CategoryId"],
    subId: json["SubContId"],
    subcontName: json["SubContName"],
    nos: json["Nos"],
    wages: json["Wages"],
    otHrs: json["OTHrs"],
    otAmt: json["OTAmt"],
    amount: json["Amount"],
    labRemark: json["LabRemark"],
  );

  Map<String, dynamic> toJson() => {
    "CategoryId": categoryId,
    "SubContId": subId,
    "SubContName": subcontName,
    "Nos": nos,
    "Wages": wages,
    "OTHrs": otHrs,
    "OTAmt": otAmt,
    "Amount": amount,
    "LabRemark": labRemark,
  };
}
