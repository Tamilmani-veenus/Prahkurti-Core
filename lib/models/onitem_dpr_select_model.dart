// To parse this JSON data, do
//
//     final onItemSelectDprList = onItemSelectDprListFromJson(jsonString);

import 'dart:convert';

OnItemSelectDprList onItemSelectDprListFromJson(String str) => OnItemSelectDprList.fromJson(json.decode(str));

String onItemSelectDprListToJson(OnItemSelectDprList data) => json.encode(data.toJson());

class OnItemSelectDprList {
  bool? success;
  List<Result>? result;
  String? message;

  OnItemSelectDprList({
    this.success,
    this.result,
    this.message,
  });

  factory OnItemSelectDprList.fromJson(Map<String, dynamic> json) => OnItemSelectDprList(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json['message']
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? headItemId;
  int? subItemId;
  String? boqcode;
  String? itemdesc;
  int? scaleId;
  String? scaleName;
  double? rate;
  double? qty;
  double? amount;
  double? cement;
  int? level3ItemId;
  int? subContarctWorkdetid;
  String? workRemarks;
  double? balQty;
  int? siteId;
  String? siteName;
  String? active;

  Result({
    this.headItemId,
    this.subItemId,
    this.boqcode,
    this.itemdesc,
    this.scaleId,
    this.scaleName,
    this.rate,
    this.qty,
    this.amount,
    this.cement,
    this.level3ItemId,
    this.subContarctWorkdetid,
    this.workRemarks,
    this.balQty,
    this.siteId,
    this.siteName,
    this.active,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    headItemId: json["HeadItemId"],
    subItemId: json["SubItemId"],
    boqcode: json["Boqcode"],
    itemdesc: json["Itemdesc"],
    scaleId: json["ScaleId"],
    scaleName: json["ScaleName"],
    rate: json["Rate"],
    qty: json["Qty"],
    amount: json["Amount"],
    cement: json["Cement"],
    level3ItemId: json["Level3ItemId"],
    subContarctWorkdetid: json["SubContarctWorkdetid"],
    workRemarks: json["WorkRemarks"],
    balQty: json["BalQty"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    active: json["Active"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItemId": headItemId,
    "SubItemId": subItemId,
    "Boqcode": boqcode,
    "Itemdesc": itemdesc,
    "ScaleId": scaleId,
    "ScaleName": scaleName,
    "Rate": rate,
    "Qty": qty,
    "Amount": amount,
    "Cement": cement,
    "Level3ItemId": level3ItemId,
    "SubContarctWorkdetid": subContarctWorkdetid,
    "WorkRemarks": workRemarks,
    "BalQty": balQty,
    "SiteId": siteId,
    "SiteName": siteName,
    "Active": active,
  };
}
