// To parse this JSON data, do
//
//     final dprItemListResponse = dprItemListResponseFromJson(jsonString);

import 'dart:convert';

DprItemListResponse dprItemListResponseFromJson(String str) => DprItemListResponse.fromJson(json.decode(str));

String dprItemListResponseToJson(DprItemListResponse data) => json.encode(data.toJson());

class DprItemListResponse {
  bool? success;
  List<Result>? result;
  String? message;

  DprItemListResponse({
    this.success,
    this.result,
    this.message
  });

  factory DprItemListResponse.fromJson(Map<String, dynamic> json) => DprItemListResponse(
      success: json["success"],
      result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? woDetId;
  int? headItemId;
  int? subItemId;
  String? boqCode;
  String? itemDesc;
  int? scaleId;
  String? unit;
  double? rate;
  double? qty;
  double? amount;
  String? cement;
  int? level3ItemId;
  String? workRemarks;
  double? boqQty;
  double? workQty;
  double? balQty;
  int? siteId;
  String? siteName;
  String? activeSatus;
  bool? isCheck = false;

  Result({
    this.woDetId,
    this.headItemId,
    this.subItemId,
    this.boqCode,
    this.itemDesc,
    this.scaleId,
    this.unit,
    this.rate,
    this.qty,
    this.amount,
    this.cement,
    this.level3ItemId,
    this.workRemarks,
    this.boqQty,
    this.workQty,
    this.balQty,
    this.siteId,
    this.siteName,
    this.activeSatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    woDetId: json["Workdetid"],
    headItemId: json["HeadItemIdd"],
    subItemId: json["SubItemId"],
    boqCode: json["boqCode"],
    itemDesc: json["itemdesc"],
    scaleId: json["Unit"],
    unit: json["ScaleName"],
    rate: json["Rate"],
    qty: json["Qty"],
    amount: json["Amt"],
    cement: json["cement"],
    level3ItemId: json["measureLevel3ItemId"],
    workRemarks: json["workRemarks"],
    boqQty: json["Boqqty"],
    workQty: json["WorkQty"],
    balQty: json["balQty"],
    siteId: json["siteid"],
    siteName: json["sitename"],
    activeSatus: json["activeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "Workdetid": woDetId,
    "HeadItemIdd": headItemId,
    "SubItemId": subItemId,
    "boqCode": boqCode,
    "itemdesc": itemDesc,
    "Unit": scaleId,
    "ScaleName": unit,
    "Rate": rate,
    "Qty": qty,
    "Amt": amount,
    "cement": cement,
    "measureLevel3ItemId": level3ItemId,
    "workRemarks": workRemarks,
    "Boqqty": boqQty,
    "WorkQty": workQty,
    "balQty": balQty,
    "siteid": siteId,
    "sitename": siteName,
    "activeStatus": activeSatus,
  };
}
