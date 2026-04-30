// To parse this JSON data, do
//
//     final stockmaterial = stockmaterialFromJson(jsonString);

import 'dart:convert';

Stockmaterial stockmaterialFromJson(String str) => Stockmaterial.fromJson(json.decode(str));

String stockmaterialToJson(Stockmaterial data) => json.encode(data.toJson());

class Stockmaterial {
  bool? success;
  String? message;
  List<Result>? result;

  Stockmaterial({
    this.success,
    this.message,
    this.result,
  });

  factory Stockmaterial.fromJson(Map<String, dynamic> json) => Stockmaterial(
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
  int? reqDetId;
  int? materialId;
  String? material;
  int? scaleId;
  String? scale;
  double? balQty;
  double? stockQty;
  int? transReqDetId;
  bool? check=false;

  Result({
    this.reqDetId,
    this.materialId,
    this.material,
    this.scaleId,
    this.scale,
    this.balQty,
    this.transReqDetId,
    this.stockQty,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reqDetId: json["id"],
    materialId: json["materialId"],
    material: json["materialName"],
    scaleId: json["ScaleID"],
    scale: json["ScaleName"],
    balQty: json["BalQty"],
    transReqDetId: json["transfer_detid"],
    stockQty: json["StockQty"],
  );

  Map<String, dynamic> toJson() => {
    "id": reqDetId,
    "materialId": materialId,
    "materialName": material,
    "ScaleID": scaleId,
    "ScaleName": scale,
    "BalQty": balQty,
    "transfer_detid": transReqDetId,
    "StockQty": stockQty,
  };
}
