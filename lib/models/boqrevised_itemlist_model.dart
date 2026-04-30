// To parse this JSON data, do
//
//     final boqRevisedItemlistResponse = boqRevisedItemlistResponseFromJson(jsonString);

import 'dart:convert';

List<BoqRevisedItemlistResponse> boqRevisedItemlistResponseFromJson(String str) => List<BoqRevisedItemlistResponse>.from(json.decode(str).map((x) => BoqRevisedItemlistResponse.fromJson(x)));

String boqRevisedItemlistResponseToJson(List<BoqRevisedItemlistResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoqRevisedItemlistResponse {
  BoqRevisedItemlistResponse({
    this.headItemId,
    this.subItemId,
    this.level3ItemId,
    this.woDetId,
    this.boqCode,
    this.itemDesc,
    this.unit,
    this.rate,
    this.qty,
    this.amt,
    this.balQty,
  });

  int? headItemId;
  int? subItemId;
  int? level3ItemId;
  int? woDetId;
  String? boqCode;
  String? itemDesc;
  String? unit;
  double? rate;
  double? qty;
  double? amt;
  double? balQty;
  bool? isCheck=false;

  factory BoqRevisedItemlistResponse.fromJson(Map<String, dynamic> json) => BoqRevisedItemlistResponse(
    headItemId: json["HeadItemId"],
    subItemId: json["SubItemId"],
    level3ItemId: json["Level3ItemId"],
    woDetId: json["WODetId"],
    boqCode: json["BoqCode"],
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    rate: json["Rate"],
    qty: json["Qty"],
    amt: json["Amt"],
    balQty: json["BalQty"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItemId": headItemId,
    "SubItemId": subItemId,
    "Level3ItemId": level3ItemId,
    "WODetId": woDetId,
    "BoqCode": boqCode,
    "ItemDesc": itemDesc,
    "Unit": unit,
    "Rate": rate,
    "Qty": qty,
    "Amt": amt,
    "BalQty": balQty,
  };
}
