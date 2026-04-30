

import 'dart:convert';

List<OnItemSelectDprList> onItemSelectDprListFromJson(String str) => List<OnItemSelectDprList>.from(json.decode(str).map((x) => OnItemSelectDprList.fromJson(x)));

String onItemSelectDprListToJson(List<OnItemSelectDprList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnItemSelectDprList {
  OnItemSelectDprList({
    this.boqCode,
    this.workName,
    this.unit,
    this.balQty,
    this.qty,
    this.rate,
    this.amt,
  });

  String? boqCode;
  String? workName;
  String? unit;
  double? balQty;
  double? qty;
  double? rate;
  double? amt;

  factory OnItemSelectDprList.fromJson(Map<String, dynamic> json) => OnItemSelectDprList(
    boqCode: json["BOQCode"],
    workName: json["WorkName"],
    unit: json["Unit"],
    balQty: json["BalQty"],
    qty: json["Qty"],
    rate: json["Rate"].toDouble(),
    amt: json["Amt"],
  );

  Map<String, dynamic> toJson() => {
    "BOQCode": boqCode,
    "WorkName": workName,
    "Unit": unit,
    "BalQty": balQty,
    "Qty": qty,
    "Rate": rate,
    "Amt": amt,
  };
}
