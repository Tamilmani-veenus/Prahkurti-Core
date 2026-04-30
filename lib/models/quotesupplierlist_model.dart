// To parse this JSON data, do
//
//     final quotesupplierlist = quotesupplierlistFromJson(jsonString);

import 'dart:convert';

Quotesupplierlist quotesupplierlistFromJson(String str) => Quotesupplierlist.fromJson(json.decode(str));

String quotesupplierlistToJson(Quotesupplierlist data) => json.encode(data.toJson());

class Quotesupplierlist {
  bool? success;
  List<Result>? result;
  String? message;

  Quotesupplierlist({
    this.success,
    this.result,
    this.message,
  });

  factory Quotesupplierlist.fromJson(Map<String, dynamic> json) => Quotesupplierlist(
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
  int? id;
  int? supplierId;
  double? netAmount;
  int? materialReqMasId;
  String? supplierName;
  String? remarks;
  bool? isChecked = false;

  Result({
    this.id,
    this.supplierId,
    this.netAmount,
    this.materialReqMasId,
    this.supplierName,
    this.remarks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    supplierId: json["supplierId"],
    netAmount: json["netAmount"],
    materialReqMasId: json["materialReqMasId"],
    supplierName: json["supplierName"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplierId": supplierId,
    "netAmount": netAmount,
    "materialReqMasId": materialReqMasId,
    "supplierName": supplierName,
    "remarks": remarks,
  };
}
