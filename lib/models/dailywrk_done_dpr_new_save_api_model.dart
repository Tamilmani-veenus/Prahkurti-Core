// To parse this JSON data, do
//
//     final dailywrkdonDprNewGetBoqdetailsRes = dailywrkdonDprNewGetBoqdetailsResFromJson(jsonString);

import 'dart:convert';

DailywrkdonDprNewSaveReq dailywrkdonDprNewsaveReqFromJson(String str) => DailywrkdonDprNewSaveReq.fromJson(json.decode(str));

String dailywrkdonDprNewSaveReqToJson(DailywrkdonDprNewSaveReq data) => json.encode(data.toJson());

class DailywrkdonDprNewSaveReq {
  DailywrkdonDprNewSaveReq({
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
    this.dprDet,
    this.dprLab,
    this.dprMaterial,
    this.dprMeasurement,
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
  List<DprDet>? dprDet;
  List<DprLab>? dprLab;
  List<DprMaterial>? dprMaterial;
  List<DprMeasurement>? dprMeasurement;

  factory DailywrkdonDprNewSaveReq.fromJson(Map<String, dynamic> json) => DailywrkdonDprNewSaveReq(
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
    dprDet: List<DprDet>.from(json["DprDet"].map((x) => DprDet.fromJson(x))),
    dprLab: List<DprLab>.from(json["DprLab"].map((x) => DprLab.fromJson(x))),
    dprMaterial: List<DprMaterial>.from(json["DprMaterial"].map((x) => DprMaterial.fromJson(x))),
    dprMeasurement: List<DprMeasurement>.from(json["DprMeasurement"].map((x) => DprMeasurement.fromJson(x))),
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
    "DprDet": List<dynamic>.from(dprDet!.map((x) => x.toJson())),
    "DprLab": List<dynamic>.from(dprLab!.map((x) => x.toJson())),
    "DprMaterial": List<dynamic>.from(dprMaterial!.map((x) => x.toJson())),
    "DprMeasurement": List<dynamic>.from(dprMeasurement!.map((x) => x.toJson())),
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
    this.nos,
    this.wages,
    this.otHrs,
    this.otAmt,
    this.amount,
    this.labRemark,
  });

  String? categoryId;
  String? nos;
  String? wages;
  String? otHrs;
  String? otAmt;
  String? amount;
  String? labRemark;

  factory DprLab.fromJson(Map<String, dynamic> json) => DprLab(
    categoryId: json["CategoryId"],
    nos: json["Nos"],
    wages: json["Wages"],
    otHrs: json["OTHrs"],
    otAmt: json["OTAmt"],
    amount: json["Amount"],
    labRemark: json["LabRemark"],
  );

  Map<String, dynamic> toJson() => {
    "CategoryId": categoryId,
    "Nos": nos,
    "Wages": wages,
    "OTHrs": otHrs,
    "OTAmt": otAmt,
    "Amount": amount,
    "LabRemark": labRemark,
  };
}

class DprMaterial {
  DprMaterial({
    this.MaterialId,
    this.Unit,
    this.Qty,
  });

  String? MaterialId;
  String? Unit;
  String? Qty;

  factory DprMaterial.fromJson(Map<String, dynamic> json) => DprMaterial(
    MaterialId: json["MaterialId"],
    Unit: json["Unit"],
    Qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": MaterialId,
    "Unit": Unit,
    "Qty": Qty,
  };
}

class DprMeasurement {
  DprMeasurement({
    this.WorkDesc,
    this.N,
    this.L,
    this.B,
    this.D,
    this.Qty,
  });

  String? WorkDesc;
  String? N;
  String? L;
  String? B;
  String? D;
  String? Qty;

  factory DprMeasurement.fromJson(Map<String, dynamic> json) => DprMeasurement(
    WorkDesc: json["WorkDesc"],
    N: json["N"],
    L: json["L"],
    B: json["B"],
    D: json["D"],
    Qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "WorkDesc": WorkDesc,
    "N": N,
    "L": L,
    "B": B,
    "D": D,
    "Qty": Qty,
  };
}



