// To parse this JSON data, do
//
//     final billBoqWorkOrdDet = billBoqWorkOrdDetFromJson(jsonString);

import 'dart:convert';

BillBoqWorkOrdDet billBoqWorkOrdDetFromJson(String str) => BillBoqWorkOrdDet.fromJson(json.decode(str));

String billBoqWorkOrdDetToJson(BillBoqWorkOrdDet data) => json.encode(data.toJson());

class BillBoqWorkOrdDet {
  bool? success;
  List<Result>? result;
  String? message;

  BillBoqWorkOrdDet({
    this.success,
    this.result,
    this.message,
  });

  factory BillBoqWorkOrdDet.fromJson(Map<String, dynamic> json) => BillBoqWorkOrdDet(
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
  int? headItemid;
  int? subItemid;
  String? boqcode;
  String? itemCode;
  String? itemDesc;
  int? scaleId;
  String? unit;
  double? rate;
  double? CurBillQty;
  double? amt1;
  int? level3ItemId;
  int? siteId;
  String? sIteName;
  int? dworkDetId;
  double? qty;
  double? balbillqty;
  double? totalqty;
  double? amount;
  int? status;

  Result({
    this.headItemid,
    this.subItemid,
    this.boqcode,
    this.itemCode,
    this.itemDesc,
    this.scaleId,
    this.unit,
    this.rate,
    this.CurBillQty,
    this.amt1,
    this.level3ItemId,
    this.siteId,
    this.sIteName,
    this.dworkDetId,
    this.qty,
    this.balbillqty,
    this.totalqty,
    this.amount,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    headItemid: json["HeadItem_id"],
    subItemid: json["SubItem_id"],
    boqcode: json["boqcode"],
    itemCode: json["ItemCode"],
    itemDesc: json["itemdesc"],
    scaleId: json["scaleId"],
    unit: json["ScaleName"],
    rate: json["Rate"],
    CurBillQty: json["CurBillQty"],
    amt1: json["Amt1"],
    level3ItemId: json["Level3ItemId"],
    siteId: json["SiteId"],
    sIteName: json["SIteName"],
    dworkDetId: json["dworkDet_id"],
    qty: json["qty"],
    balbillqty: json["balbillqty"],
    totalqty: json["Totalqty"],
    amount: json["Amt"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItem_id": headItemid,
    "SubItem_id": subItemid,
    "boqcode": boqcode,
    "ItemCode": itemCode,
    "itemdesc": itemDesc,
    "scaleId": scaleId,
    "ScaleName": unit,
    "Rate": rate,
    "CurBillQty": CurBillQty,
    "Amt1": amt1,
    "Level3ItemId": level3ItemId,
    "SiteId": siteId,
    "SIteName": sIteName,
    "dworkDet_id": dworkDetId,
    "qty": qty,
    "balbillqty": balbillqty,
    "Totalqty": totalqty,
    "Amt": amount,
    "Status": status,
  };
}
