// To parse this JSON data, do
//
//     final matTransReqItemList = matTransReqItemListFromJson(jsonString);

import 'dart:convert';

List<MatTransReqItemList> matTransReqItemListFromJson(String str) => List<MatTransReqItemList>.from(json.decode(str).map((x) => MatTransReqItemList.fromJson(x)));

String matTransReqItemListToJson(List<MatTransReqItemList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatTransReqItemList {
  int? materialid;
  String? material;
  String? scale;
  double? stockQty;
  bool? check = false;

  MatTransReqItemList({
   this.materialid,
   this.material,
   this.scale,
   this.stockQty,
  });

  factory MatTransReqItemList.fromJson(Map<String, dynamic> json) => MatTransReqItemList(
    materialid: json["materialid"],
    material: json["Material"],
    scale: json["scale"],
    stockQty: json["Stock_Qty"],
  );

  Map<String, dynamic> toJson() => {
    "materialid": materialid,
    "Material": material,
    "scale": scale,
    "Stock_Qty": stockQty,
  };
}
