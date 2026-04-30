// To parse this JSON data, do
//
//     final boqRevisedRequest = boqRevisedRequestFromJson(jsonString);

import 'dart:convert';

BoqRevisedRequest boqRevisedRequestFromJson(String str) => BoqRevisedRequest.fromJson(json.decode(str));

String boqRevisedRequestToJson(BoqRevisedRequest data) => json.encode(data.toJson());

class BoqRevisedRequest {
  BoqRevisedRequest({
    this.revise_Id,
    this.reviseNo,
    this.reviseDate,
    this.projectId,
    this.siteId,
    this.remarks,
    this.preparedBy,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.appStatus,
    this.dprDet,
  });
  int? revise_Id;
  String? reviseNo;
  String? reviseDate;
  String? projectId;
  String? siteId;
  String? remarks;
  String? preparedBy;
  String? userId;
  String? deviceName;
  String? entryMode;
  String? appStatus;
  List<DprDet>? dprDet;

  factory BoqRevisedRequest.fromJson(Map<String, dynamic> json) => BoqRevisedRequest(
    revise_Id: json["Revise_Id"],
    reviseNo: json["Revise_No"],
    reviseDate: json["Revise_Date"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    remarks: json["Remarks"],
    preparedBy: json["Prepared_By"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    appStatus: json["App_status"],
    dprDet: List<DprDet>.from(json["DprDet"].map((x) => DprDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Revise_Id": revise_Id,
    "Revise_No": reviseNo,
    "Revise_Date": reviseDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "Remarks": remarks,
    "Prepared_By": preparedBy,
    "UserId": userId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "App_status": appStatus,
    "DprDet": List<dynamic>.from(dprDet!.map((x) => x.toJson())),
  };
}

class DprDet {
  DprDet({
    this.hdNmeId,
    this.sbNmeId,
    this.level3ItemId,
    this.unit,
    this.rate,
    this.qty,
    this.detRemarks,
  });

  String? hdNmeId;
  String? sbNmeId;
  String? level3ItemId;
  String? unit;
  String? rate;
  String? qty;
  String? detRemarks;

  factory DprDet.fromJson(Map<String, dynamic> json) => DprDet(
    hdNmeId: json["HdNme_Id"],
    sbNmeId: json["SbNme_Id"],
    level3ItemId: json["Level3item_id"],
    unit: json["Unit"],
    rate: json["Rate"],
    qty: json["Qty"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "HdNme_Id": hdNmeId,
    "SbNme_Id": sbNmeId,
    "Level3item_id": level3ItemId,
    "Unit": unit,
    "Rate": rate,
    "Qty": qty,
    "DetRemarks": detRemarks,
  };
}
