// To parse this JSON data, do
//
//     final transferPendingMaterialList = transferPendingMaterialListFromJson(jsonString);

import 'dart:convert';

List<TransferPendingMaterialList> transferPendingMaterialListFromJson(String str) => List<TransferPendingMaterialList>.from(json.decode(str).map((x) => TransferPendingMaterialList.fromJson(x)));

String transferPendingMaterialListToJson(List<TransferPendingMaterialList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferPendingMaterialList {
  int? reqMasDetId;
  String? material;
  int? reqQty;
  int? qty;
  int? transQty;
  String? scale;
  int? estQty;
  int? balQty;
  String? appType;
  String? refProjectid;
  int? frpid;
  int? materialid;
  String? remarks;
  int? appMasId;
  int? reqMasId;

  TransferPendingMaterialList({
    this.reqMasDetId,
    this.material,
    this.reqQty,
    this.qty,
    this.transQty,
    this.scale,
    this.estQty,
    this.balQty,
    this.appType,
    this.refProjectid,
    this.frpid,
    this.materialid,
    this.remarks,
    this.appMasId,
    this.reqMasId,
  });

  factory TransferPendingMaterialList.fromJson(Map<String, dynamic> json) => TransferPendingMaterialList(
    reqMasDetId: json["req_mas_det_id"],
    material: json["Material"],
    reqQty: json["req_qty"],
    qty: json["qty"],
    transQty: json["Trans_qty"],
    scale: json["Scale"],
    estQty: json["EstQty"],
    balQty: json["Bal_Qty"],
    appType: json["app_type"],
    refProjectid: json["Ref_Projectid"],
    frpid: json["frpid"],
    materialid: json["Materialid"],
    remarks: json["remarks"],
    appMasId: json["app_mas_id"],
    reqMasId: json["req_mas_id"],
  );

  Map<String, dynamic> toJson() => {
    "req_mas_det_id": reqMasDetId,
    "Material": material,
    "req_qty": reqQty,
    "qty": qty,
    "Trans_qty": transQty,
    "Scale": scale,
    "EstQty": estQty,
    "Bal_Qty": balQty,
    "app_type": appType,
    "Ref_Projectid": refProjectid,
    "frpid": frpid,
    "Materialid": materialid,
    "remarks": remarks,
    "app_mas_id": appMasId,
    "req_mas_id": reqMasId,
  };
}
