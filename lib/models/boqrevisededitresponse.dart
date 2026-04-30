// To parse this JSON data, do
//
//     final boqRevisedEditResponse = boqRevisedEditResponseFromJson(jsonString);

import 'dart:convert';

List<BoqRevisedEditResponse> boqRevisedEditResponseFromJson(String str) => List<BoqRevisedEditResponse>.from(json.decode(str).map((x) => BoqRevisedEditResponse.fromJson(x)));

String boqRevisedEditResponseToJson(List<BoqRevisedEditResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoqRevisedEditResponse {
  BoqRevisedEditResponse({
    this.reviseId,
    this.reviseNo,
    this.reviseDate,
    this.projectId,
    this.siteId,
    this.projectName,
    this.siteName,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.dprEditDet,
  });

  int? reviseId;
  String? reviseNo;
  String? reviseDate;
  int? projectId;
  int? siteId;
  String? projectName;
  String? siteName;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  List<DprEditDet>? dprEditDet;

  factory BoqRevisedEditResponse.fromJson(Map<String, dynamic> json) => BoqRevisedEditResponse(
    reviseId: json["Revise_Id"],
    reviseNo: json["Revise_No"],
    reviseDate: json["Revise_Date"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    dprEditDet: List<DprEditDet>.from(json["DprEditDet"].map((x) => DprEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Revise_Id": reviseId,
    "Revise_No": reviseNo,
    "Revise_Date": reviseDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "DprEditDet": List<dynamic>.from(dprEditDet!.map((x) => x.toJson())),
  };
}

class DprEditDet {
  DprEditDet({
    this.hdNmeId,
    this.sbNmeId,
    this.level3ItemId,
    this.boqCode,
    this.itemDesc,
    this.unit,
    this.rate,
    this.detRemarks,
    this.qty,
  });

  int? hdNmeId;
  int? sbNmeId;
  int? level3ItemId;
  String? boqCode;
  String? itemDesc;
  String? unit;
  double? rate;
  String? detRemarks;
  double? qty;

  factory DprEditDet.fromJson(Map<String, dynamic> json) => DprEditDet(
    hdNmeId: json["HdNme_Id"],
    sbNmeId: json["SbNme_Id"],
    level3ItemId: json["Level3item_id"],
    boqCode: json["BoqCode"],
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    rate: json["Rate"],
    detRemarks: json["DetRemarks"],
    qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "HdNme_Id": hdNmeId,
    "SbNme_Id": sbNmeId,
    "Level3item_id": level3ItemId,
    "BoqCode": boqCode,
    "ItemDesc": itemDesc,
    "Unit": unit,
    "Rate": rate,
    "DetRemarks": detRemarks,
    "Qty": qty,
  };
}
