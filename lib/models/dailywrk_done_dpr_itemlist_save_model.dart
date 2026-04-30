import 'dart:convert';
import 'dart:io';

DailywrkDoneDprItemlistSaveModel dailywrkDoneDprItemlistSaveModelFromJson(String str) => DailywrkDoneDprItemlistSaveModel.fromJson(json.decode(str));

String dailywrkDoneDprItemlistSaveModelToJson(DailywrkDoneDprItemlistSaveModel data) => json.encode(data.toJson());

class DailywrkDoneDprItemlistSaveModel {
  DailywrkDoneDprItemlistSaveModel({
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
    this.entryMode,
    this.deviceName,
    this.dprDet,
    this.files,
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
  String? entryMode;
  String? deviceName;
  List<DprDet>? dprDet;
  List<File>? files;

  factory DailywrkDoneDprItemlistSaveModel.fromJson(Map<String, dynamic> json) => DailywrkDoneDprItemlistSaveModel(
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
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    files: json["files"],
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
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "files": files,
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



DprItemlistscreenSaveResponse dprItemscreenSaveResponseFromJson(String str) => DprItemlistscreenSaveResponse.fromJson(json.decode(str));

String dprItemscreenSaveResponseToJson(DprItemlistscreenSaveResponse data) => json.encode(data.toJson());

class DprItemlistscreenSaveResponse {
  DprItemlistscreenSaveResponse({
    this.RetString,
  });

  String? RetString;

  factory DprItemlistscreenSaveResponse.fromJson(Map<String, dynamic> json) => DprItemlistscreenSaveResponse(
    RetString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": RetString,
  };
}