// To parse this JSON data, do
//
//     final boqRevisedEditResponse = boqRevisedEditResponseFromJson(jsonString);

import 'dart:convert';

BoqRevisedEditResponse boqRevisedEditResponseFromJson(String str) => BoqRevisedEditResponse.fromJson(json.decode(str));

String boqRevisedEditResponseToJson(BoqRevisedEditResponse data) => json.encode(data.toJson());

class BoqRevisedEditResponse {
  bool? success;
  String? message;
  Result? result;

  BoqRevisedEditResponse({
    this.success,
    this.message,
    this.result,
  });

  factory BoqRevisedEditResponse.fromJson(Map<String, dynamic> json) => BoqRevisedEditResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  int? id;
  String? reviseNo;
  String? reviseDate;
  int? projectId;
  int? siteId;
  String? remarks;
  int? createdBy;
  String? createdDt;
  int? approvedBy;
  String? createdByName;
  String? projectName;
  String? siteName;
  int? measureHeadItemId;
  String? measureHeadItemName;
  List<BoqReviseDet>? boqReviseDets;

  Result({
    this.id,
    this.reviseNo,
    this.reviseDate,
    this.projectId,
    this.siteId,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.approvedBy,
    this.createdByName,
    this.projectName,
    this.siteName,
    this.measureHeadItemId,
    this.boqReviseDets,
    this.measureHeadItemName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    reviseNo: json["reviseNo"],
    reviseDate: json["reviseDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    approvedBy: json["approvedBy"],
    createdByName: json["createdByName"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    measureHeadItemId: json["measureHeadItemId"],
    measureHeadItemName: json["measureHeadItemName"],
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
    "approvedBy": approvedBy,
    "createdByName": createdByName,
    "projectName": projectName,
    "siteName": siteName,
    "measureHeadItemId": measureHeadItemId,
    "measureHeadItemName": measureHeadItemName,
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
  String? remarks;
  double? reviseQty;
  String? approveStatus;
  String? scaleName;
  String? itemDescription;
  String? measureHeadItemName;
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
    this.remarks,
    this.reviseQty,
    this.approveStatus,
    this.scaleName,
    this.itemDescription,
    this.measureHeadItemName,
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
    remarks: json["remarks"],
    reviseQty: json["reviseQty"],
    approveStatus: json["approveStatus"],
    scaleName: json["scaleName"],
    itemDescription: json["itemDescription"],
    measureHeadItemName: json["measureHeadItemName"],
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
    "remarks": remarks,
    "reviseQty": reviseQty,
    "approveStatus": approveStatus,
    "scaleName": scaleName,
    "itemDescription": itemDescription,
    "measureHeadItemName": measureHeadItemName,
    "boQcode": boQcode,
  };
}
