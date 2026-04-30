

import 'dart:convert';

List<OnItemSelectInwardList> onItemSelectInwardListFromJson(String str) => List<OnItemSelectInwardList>.from(json.decode(str).map((x) => OnItemSelectInwardList.fromJson(x)));

String onItemSelectInwardListToJson(List<OnItemSelectInwardList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnItemSelectInwardList {
  OnItemSelectInwardList({
    this.materialId,
    this.materialName,
    this.scale,
    this.poQty,
    this.inwQty,
  });

  int? materialId;
  String? materialName;
  String? scale;
  double? poQty;
  double? inwQty;

  factory OnItemSelectInwardList.fromJson(Map<String, dynamic> json) => OnItemSelectInwardList(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    scale: json["Scale"],
    poQty: json["POQty"],
    inwQty: json["InwQty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Scale": scale,
    "POQty": poQty,
    "InwQty": inwQty,
  };
}
