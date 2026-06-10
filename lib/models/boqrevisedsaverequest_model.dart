// To parse this JSON data, do
//
//     final boqRevisedSaveRequest = boqRevisedSaveRequestFromJson(jsonString);

import 'dart:convert';

BoqRevisedSaveRequest boqRevisedSaveRequestFromJson(String str) => BoqRevisedSaveRequest.fromJson(json.decode(str));

String boqRevisedSaveRequestToJson(BoqRevisedSaveRequest data) => json.encode(data.toJson());

class BoqRevisedSaveRequest {
  int? id;
  String? reviseNo;
  String? reviseDate;
  int? projectId;
  int? siteId;
  String? remarks;
  int? createdBy;
  String? createdDt;
  int? measureHeadItemId;
  List<BoqReviseDet>? boqReviseDets;

  BoqRevisedSaveRequest({
    this.id,
    this.reviseNo,
    this.reviseDate,
    this.projectId,
    this.siteId,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.measureHeadItemId,
    this.boqReviseDets,
  });

  factory BoqRevisedSaveRequest.fromJson(Map<String, dynamic> json) => BoqRevisedSaveRequest(
    id: json["id"],
    reviseNo: json["reviseNo"],
    reviseDate: json["reviseDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    measureHeadItemId: json["measureHeadItemId"],
    boqReviseDets: List<BoqReviseDet>.from(json["boqReviseDets"].map((x) => BoqReviseDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reviseNo": reviseNo,
    "reviseDate": reviseDate,
    "projectId": projectId,
    "siteId": siteId,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "measureHeadItemId": measureHeadItemId,
    "boqReviseDets": List<dynamic>.from(boqReviseDets!.map((x) => x.toJson())),
  };
}

class BoqReviseDet {
  int? id;
  int? boqReviseMasId;
  int? measureHeadItemId;
  int? measureSubItemId;
  int? measureLevel3ItemId;
  int? scaleId;
  double? rate;
  double? qty;
  double? reviseQty;
  String? remarks;
  int? approvedBy;
  String? approveStatus;
  String? boQcode;


  BoqReviseDet({
    this.id,
    this.boqReviseMasId,
    this.measureHeadItemId,
    this.measureSubItemId,
    this.measureLevel3ItemId,
    this.scaleId,
    this.rate,
    this.qty,
    this.reviseQty,
    this.remarks,
    this.approvedBy,
    this.approveStatus,
    this.boQcode,
  });

  factory BoqReviseDet.fromJson(Map<String, dynamic> json) => BoqReviseDet(
    id: json["id"],
    boqReviseMasId: json["boqReviseMasId"],
    measureHeadItemId: json["measureHeadItemId"],
    measureSubItemId: json["measureSubItemId"],
    measureLevel3ItemId: json["measureLevel3ItemId"],
    scaleId: json["scaleId"],
    rate: json["rate"],
    qty: json["qty"],
    reviseQty: json["reviseQty"],
    remarks: json["remarks"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    boQcode: json["boQcode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "boqReviseMasId": boqReviseMasId,
    "measureHeadItemId": measureHeadItemId,
    "measureSubItemId": measureSubItemId,
    "measureLevel3ItemId": measureLevel3ItemId,
    "scaleId": scaleId,
    "rate": rate,
    "qty": qty,
    "reviseQty": reviseQty,
    "remarks": remarks,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "boQcode": boQcode,
  };
}
