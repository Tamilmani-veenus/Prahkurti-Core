// To parse this JSON data, do
//
//     final onItemSelectInwardList = onItemSelectInwardListFromJson(jsonString);

import 'dart:convert';

OnItemSelectInwardList onItemSelectInwardListFromJson(String str) => OnItemSelectInwardList.fromJson(json.decode(str));

String onItemSelectInwardListToJson(OnItemSelectInwardList data) => json.encode(data.toJson());

class OnItemSelectInwardList {
  bool? success;
  String? message;
  List<Result>? result;

  OnItemSelectInwardList({
    this.success,
    this.message,
    this.result,
  });

  factory OnItemSelectInwardList.fromJson(Map<String, dynamic> json) => OnItemSelectInwardList(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null? [] :List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? purOrdDetId;
  int? materialid;
  String? materialName;
  int? scaleId;
  String? scaleName;
  double? poqty;
  double? inwQty;
  double? balPoQty;

  Result({
    this.purOrdDetId,
    this.materialid,
    this.materialName,
    this.scaleId,
    this.scaleName,
    this.poqty,
    this.inwQty,
    this.balPoQty,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    purOrdDetId: json["PurOrdDetId"],
    materialid: json["Materialid"],
    materialName: json["MaterialName"],
    scaleId: json["ScaleID"],
    scaleName: json["ScaleName"],
    poqty: json["poqty"],
    inwQty: json["InwQty"],
    balPoQty: json["BalPoQty"],
  );

  Map<String, dynamic> toJson() => {
    "PurOrdDetId": purOrdDetId,
    "Materialid": materialid,
    "MaterialName": materialName,
    "ScaleID": scaleId,
    "ScaleName": scaleName,
    "poqty": poqty,
    "InwQty": inwQty,
    "BalPoQty": balPoQty,
  };
}
