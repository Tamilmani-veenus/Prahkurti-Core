// To parse this JSON data, do
//
//     final inwardAllDatasaRes = inwardAllDatasaResFromJson(jsonString);

import 'dart:convert';

InwardAllDatasaRes inwardAllDatasaResFromJson(String str) => InwardAllDatasaRes.fromJson(json.decode(str));

String inwardAllDatasaResToJson(InwardAllDatasaRes data) => json.encode(data.toJson());

class InwardAllDatasaRes {
  bool? success;
  String? message;
  List<getByIdResult>? result;

  InwardAllDatasaRes({
    this.success,
    this.message,
    this.result,
  });

  factory InwardAllDatasaRes.fromJson(Map<String, dynamic> json) => InwardAllDatasaRes(
    success: json["success"],
    message: json["message"],
    result: List<getByIdResult>.from(json["result"].map((x) => getByIdResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class getByIdResult {
  int? purOrdMasId;
  int? supplierid;
  int? projectid;
  String? projectName;
  String? siteName;
  String? supplierName;
  String? purchaseType;
  int? siteid;
  String? purchaseOrdNo;
  int? poDetId;
  int? materialId;
  String? materialName;
  int? scaleId;
  String? unit;
  String? remarks;
  double? poQty;
  double? balQty;
  double? inwQty;
  double? rate;
  int? qty;
  int? amount;
  String? inwardType;
  double? addQty;
  double? lessQty;
  double? discper;
  int? discamt;
  double? vatper;
  int? vatamt;
  int? netamt;

  getByIdResult({
    this.purOrdMasId,
    this.supplierid,
    this.projectid,
    this.projectName,
    this.siteName,
    this.supplierName,
    this.purchaseType,
    this.siteid,
    this.purchaseOrdNo,
    this.poDetId,
    this.materialId,
    this.materialName,
    this.scaleId,
    this.unit,
    this.remarks,
    this.poQty,
    this.balQty,
    this.inwQty,
    this.rate,
    this.qty,
    this.amount,
    this.inwardType,
    this.addQty,
    this.lessQty,
    this.discper,
    this.discamt,
    this.vatper,
    this.vatamt,
    this.netamt,
  });

  factory getByIdResult.fromJson(Map<String, dynamic> json) => getByIdResult(
    purOrdMasId: json["PurOrdMasId"],
    supplierid: json["supplierid"],
    projectid: json["projectid"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    supplierName: json["SupplierName"],
    purchaseType: json["PurchaseType"],
    siteid: json["siteid"],
    purchaseOrdNo: json["PurchaseOrdNo"],
    poDetId: json["PurOrdDetId"],
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    scaleId: json["UnitId"],
    unit: json["UnitName"],
    remarks: json["Remarks"],
    poQty: json["poqty"],
    balQty: json["balqty"],
    inwQty: json["GRNQty"],
    rate: json["rate"],
    qty: json["qty"],
    amount: json["amount"],
    inwardType: json["InwardType"],
    addQty: json["addQty"],
    lessQty: json["lessQty"],
    discper: json["discper"],
    discamt: json["discamt"],
    vatper: json["vatper"],
    vatamt: json["vatamt"],
    netamt: json["netamt"],
  );

  Map<String, dynamic> toJson() => {
    "PurOrdMasId": purOrdMasId,
    "supplierid": supplierid,
    "projectid": projectid,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SupplierName": supplierName,
    "PurchaseType": purchaseType,
    "siteid": siteid,
    "PurchaseOrdNo": purchaseOrdNo,
    "PurOrdDetId": poDetId,
    "MaterialId": materialId,
    "MaterialName": materialName,
    "UnitId": scaleId,
    "UnitName": unit,
    "Remarks": remarks,
    "poqty": poQty,
    "balqty": balQty,
    "GRNQty": inwQty,
    "rate": rate,
    "qty": qty,
    "amount": amount,
    "InwardType": inwardType,
    "addQty": addQty,
    "lessQty": lessQty,
    "discper": discper,
    "discamt": discamt,
    "vatper": vatper,
    "vatamt": vatamt,
    "netamt": netamt,
  };
}
