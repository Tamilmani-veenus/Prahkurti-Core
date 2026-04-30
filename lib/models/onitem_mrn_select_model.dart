

import 'dart:convert';

List<OnItemSelectMrnList> onItemSelectMrnListFromJson(String str) => List<OnItemSelectMrnList>.from(json.decode(str).map((x) => OnItemSelectMrnList.fromJson(x)));

String onItemSelectMrnListToJson(List<OnItemSelectMrnList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnItemSelectMrnList {
  OnItemSelectMrnList({
    this.material,
    this.scale,
    this.reqQty,
    this.appQty,
    this.appType,
    this.remarks,
  });

  String? material;
  String? scale;
  double? reqQty;
  double? appQty;
  String? appType;
  String? remarks;

  factory OnItemSelectMrnList.fromJson(Map<String, dynamic> json) => OnItemSelectMrnList(
    material: json["Material"],
    scale: json["Scale"],
    reqQty: json["ReqQty"],
    appQty: json["AppQty"],
    appType: json["AppType"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "Material": material,
    "Scale": scale,
    "ReqQty": reqQty,
    "AppQty": appQty,
    "AppType": appType,
    "Remarks": remarks,
  };
}
