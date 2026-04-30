// To parse this JSON data, do
//
//     final stockwisematerialwise = stockwisematerialwiseFromJson(jsonString);

import 'dart:convert';

Stockwisematerialwise stockwisematerialwiseFromJson(String str) => Stockwisematerialwise.fromJson(json.decode(str));

String stockwisematerialwiseToJson(Stockwisematerialwise data) => json.encode(data.toJson());

class Stockwisematerialwise {
  bool? success;
  String? message;
  List<Result>? result;

  Stockwisematerialwise({
    this.success,
    this.message,
    this.result,
  });

  factory Stockwisematerialwise.fromJson(Map<String, dynamic> json) => Stockwisematerialwise(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? projectName;
  String? siteName;
  String? itemName;
  String? unit;
  double? stockQty;
  String? lastDate;
  String? idleDays;

  Result({
    this.projectName,
    this.siteName,
    this.itemName,
    this.unit,
    this.stockQty,
    this.lastDate,
    this.idleDays,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    projectName: json["Project_Name"],
    siteName: json["SiteName"],
    itemName: json["Item_Name"],
    unit: json["Unit"],
    stockQty: json["Stock_Qty"],
    lastDate: json["LastDate"],
    idleDays: json["IdleDays"],
  );

  Map<String, dynamic> toJson() => {
    "Project_Name": projectName,
    "SiteName": siteName,
    "Item_Name": itemName,
    "Unit": unit,
    "Stock_Qty": stockQty,
    "LastDate": lastDate,
    "IdleDays": idleDays,
  };
}
