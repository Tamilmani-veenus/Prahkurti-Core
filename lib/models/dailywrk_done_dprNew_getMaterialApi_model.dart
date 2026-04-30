


import 'dart:convert';

List<DailywrkdonDprNewGetMaterialRes> dailywrkdonDprNewGetMaterialResFromJson(String str) => List<DailywrkdonDprNewGetMaterialRes>.from(json.decode(str).map((x) => DailywrkdonDprNewGetMaterialRes.fromJson(x)));

String dailywrkdonDprNewGetMaterialResToJson(List<DailywrkdonDprNewGetMaterialRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailywrkdonDprNewGetMaterialRes {
  DailywrkdonDprNewGetMaterialRes({
    this.materialName,
    this.materialId,
    this.Scale,
  });

  String? materialName;
  int? materialId;
  String? Scale;

  factory DailywrkdonDprNewGetMaterialRes.fromJson(Map<String, dynamic> json) => DailywrkdonDprNewGetMaterialRes(
    materialName: json["MaterialName"],
    materialId: json["MaterialId"],
    Scale: json["Scale"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialName": materialName,
    "MaterialId": materialId,
    "Scale": Scale,
  };
}
