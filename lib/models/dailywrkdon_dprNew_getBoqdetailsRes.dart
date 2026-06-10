// To parse this JSON data, do
//
//     final getDprNewBoqListModel = getDprNewBoqListModelFromJson(jsonString);

import 'dart:convert';

GetDprNewBoqListModel getDprNewBoqListModelFromJson(String str) => GetDprNewBoqListModel.fromJson(json.decode(str));

String getDprNewBoqListModelToJson(GetDprNewBoqListModel data) => json.encode(data.toJson());

class GetDprNewBoqListModel {
  bool? success;
  String? message;
  List<Result>? result;

  GetDprNewBoqListModel({
    this.success,
    this.message,
    this.result,
  });

  factory GetDprNewBoqListModel.fromJson(Map<String, dynamic> json) => GetDprNewBoqListModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? headItemIdd;
  int? subItemId;
  String? boqcode;
  int? workdetid;
  String? itemCode;
  String? itemdesc;
  int? unit;
  double? rate;
  double? qty;
  double? amt;
  String? cement;
  int? measureLevel3ItemId;
  int? wokMasDetid;
  String? workremarks;
  double? boqqty;
  double? workQty;
  double? balQty;
  int? siteid;
  String? sitename;
  String? activeStatus;
  String? scaleName;

  Result({
    this.headItemIdd,
    this.subItemId,
    this.boqcode,
    this.workdetid,
    this.itemCode,
    this.itemdesc,
    this.unit,
    this.rate,
    this.qty,
    this.amt,
    this.cement,
    this.measureLevel3ItemId,
    this.wokMasDetid,
    this.workremarks,
    this.boqqty,
    this.workQty,
    this.balQty,
    this.siteid,
    this.sitename,
    this.activeStatus,
    this.scaleName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    headItemIdd: json["HeadItemIdd"],
    subItemId: json["SubItemId"],
    boqcode: json["boqcode"],
    workdetid: json["Workdetid"],
    itemCode: json["ItemCode"],
    itemdesc: json["itemdesc"],
    unit: json["Unit"],
    rate: json["Rate"],
    qty: json["Qty"],
    amt: json["Amt"],
    cement: json["cement"],
    measureLevel3ItemId: json["measureLevel3ItemId"],
    wokMasDetid: json["wokMas_detid"],
    workremarks: json["workremarks"],
    boqqty: json["Boqqty"],
    workQty: json["WorkQty"],
    balQty: json["balQty"],
    siteid: json["siteid"],
    sitename: json["sitename"],
    activeStatus: json["activeStatus"],
    scaleName: json["ScaleName"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItemIdd": headItemIdd,
    "SubItemId": subItemId,
    "boqcode": boqcode,
    "Workdetid": workdetid,
    "ItemCode": itemCode,
    "itemdesc": itemdesc,
    "Unit": unit,
    "Rate": rate,
    "Qty": qty,
    "Amt": amt,
    "cement": cement,
    "measureLevel3ItemId": measureLevel3ItemId,
    "wokMas_detid": wokMasDetid,
    "workremarks": workremarks,
    "Boqqty": boqqty,
    "WorkQty": workQty,
    "balQty": balQty,
    "siteid": siteid,
    "sitename": sitename,
    "activeStatus": activeStatus,
    "ScaleName": scaleName,
  };
}
